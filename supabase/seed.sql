insert into public.curriculum_versions (id, version, status)
values ('00000000-0000-0000-0000-000000000001', 'foundation-draft-1', 'draft')
on conflict (version) do nothing;

insert into public.phonemes (
  curriculum_version_id,
  code,
  example_word,
  instructional_status
)
select
  '00000000-0000-0000-0000-000000000001',
  item.code,
  item.example_word,
  'draft'
from (
  values
    ('/m/', 'map'),
    ('/a/', 'apple'),
    ('/t/', 'tap'),
    ('/s/', 'sun'),
    ('/p/', 'pan'),
    ('/i/', 'insect')
) as item(code, example_word)
where not exists (
  select 1
  from public.phonemes phoneme
  where phoneme.curriculum_version_id = '00000000-0000-0000-0000-000000000001'
    and phoneme.code = item.code
);

insert into public.graphemes (
  curriculum_version_id,
  display,
  phoneme_code,
  instructional_status
)
select
  '00000000-0000-0000-0000-000000000001',
  item.display,
  item.phoneme_code,
  'draft'
from (
  values
    ('m', '/m/'),
    ('a', '/a/'),
    ('t', '/t/'),
    ('s', '/s/'),
    ('p', '/p/'),
    ('i', '/i/')
) as item(display, phoneme_code)
where not exists (
  select 1
  from public.graphemes grapheme
  where grapheme.curriculum_version_id = '00000000-0000-0000-0000-000000000001'
    and grapheme.display = item.display
);
