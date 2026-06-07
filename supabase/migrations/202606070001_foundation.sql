create extension if not exists "pgcrypto";

create table public.households (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now()
);

create table public.parent_users (
  id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table public.household_memberships (
  household_id uuid not null references public.households(id) on delete cascade,
  parent_user_id uuid not null references public.parent_users(id) on delete cascade,
  role text not null default 'owner' check (role in ('owner', 'parent')),
  created_at timestamptz not null default now(),
  primary key (household_id, parent_user_id)
);

create table public.child_profiles (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references public.households(id) on delete cascade,
  first_name text not null check (char_length(first_name) between 1 and 60),
  age smallint not null check (age between 4 and 10),
  interests text[] not null default '{}',
  accessibility_preferences jsonb not null default '{}'::jsonb,
  setup_complete boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.parental_consents (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references public.households(id) on delete cascade,
  child_id uuid not null references public.child_profiles(id) on delete cascade,
  parent_user_id uuid not null references public.parent_users(id) on delete cascade,
  microphone_processing boolean not null default false,
  cloud_ai_processing boolean not null default false,
  retain_selected_audio boolean not null default false,
  accepted_at timestamptz,
  policy_version text not null,
  created_at timestamptz not null default now()
);

create table public.privacy_preferences (
  child_id uuid primary key references public.child_profiles(id) on delete cascade,
  household_id uuid not null references public.households(id) on delete cascade,
  retain_selected_audio boolean not null default false,
  updated_at timestamptz not null default now()
);

create table public.curriculum_versions (
  id uuid primary key default gen_random_uuid(),
  version text not null unique,
  status text not null check (status in ('draft', 'reviewed', 'published', 'retired')),
  created_at timestamptz not null default now(),
  published_at timestamptz
);

create table public.skills (
  id uuid primary key default gen_random_uuid(),
  curriculum_version_id uuid not null references public.curriculum_versions(id) on delete cascade,
  code text not null,
  kind text not null,
  title text not null,
  instructional_status text not null default 'draft'
    check (instructional_status in ('draft', 'expert_reviewed')),
  metadata jsonb not null default '{}'::jsonb,
  unique (curriculum_version_id, code)
);

create table public.skill_prerequisites (
  skill_id uuid not null references public.skills(id) on delete cascade,
  prerequisite_skill_id uuid not null references public.skills(id) on delete cascade,
  primary key (skill_id, prerequisite_skill_id),
  check (skill_id <> prerequisite_skill_id)
);

create table public.graphemes (
  id uuid primary key default gen_random_uuid(),
  curriculum_version_id uuid not null references public.curriculum_versions(id) on delete cascade,
  display text not null,
  phoneme_code text not null,
  instructional_status text not null default 'draft'
    check (instructional_status in ('draft', 'expert_reviewed'))
);

create table public.phonemes (
  id uuid primary key default gen_random_uuid(),
  curriculum_version_id uuid not null references public.curriculum_versions(id) on delete cascade,
  code text not null,
  example_word text,
  instructional_status text not null default 'draft'
    check (instructional_status in ('draft', 'expert_reviewed')),
  unique (curriculum_version_id, code)
);

alter table public.households enable row level security;
alter table public.parent_users enable row level security;
alter table public.household_memberships enable row level security;
alter table public.child_profiles enable row level security;
alter table public.parental_consents enable row level security;
alter table public.privacy_preferences enable row level security;
alter table public.curriculum_versions enable row level security;
alter table public.skills enable row level security;
alter table public.skill_prerequisites enable row level security;
alter table public.graphemes enable row level security;
alter table public.phonemes enable row level security;

create or replace function public.is_household_member(target_household_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.household_memberships membership
    where membership.household_id = target_household_id
      and membership.parent_user_id = auth.uid()
  );
$$;

create policy "parents read own user"
on public.parent_users for select
using (id = auth.uid());

create policy "parents read own memberships"
on public.household_memberships for select
using (parent_user_id = auth.uid());

create policy "members read household"
on public.households for select
using (public.is_household_member(id));

create policy "members manage child profiles"
on public.child_profiles for all
using (public.is_household_member(household_id))
with check (public.is_household_member(household_id));

create policy "members manage consents"
on public.parental_consents for all
using (public.is_household_member(household_id))
with check (
  public.is_household_member(household_id)
  and parent_user_id = auth.uid()
);

create policy "members manage privacy preferences"
on public.privacy_preferences for all
using (public.is_household_member(household_id))
with check (public.is_household_member(household_id));

create policy "authenticated parents read published curriculum"
on public.curriculum_versions for select
to authenticated
using (status = 'published');

create policy "authenticated parents read reviewed skills"
on public.skills for select
to authenticated
using (
  instructional_status = 'expert_reviewed'
  and exists (
    select 1 from public.curriculum_versions version
    where version.id = curriculum_version_id
      and version.status = 'published'
  )
);

create policy "authenticated parents read published prerequisites"
on public.skill_prerequisites for select
to authenticated
using (
  exists (
    select 1
    from public.skills skill
    join public.curriculum_versions version on version.id = skill.curriculum_version_id
    where skill.id = skill_id
      and skill.instructional_status = 'expert_reviewed'
      and version.status = 'published'
  )
);

create policy "authenticated parents read reviewed graphemes"
on public.graphemes for select
to authenticated
using (
  instructional_status = 'expert_reviewed'
  and exists (
    select 1 from public.curriculum_versions version
    where version.id = curriculum_version_id
      and version.status = 'published'
  )
);

create policy "authenticated parents read reviewed phonemes"
on public.phonemes for select
to authenticated
using (
  instructional_status = 'expert_reviewed'
  and exists (
    select 1 from public.curriculum_versions version
    where version.id = curriculum_version_id
      and version.status = 'published'
  )
);
