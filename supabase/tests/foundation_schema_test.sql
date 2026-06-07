begin;
select plan(8);

select has_table('public', 'households', 'households exists');
select has_table('public', 'child_profiles', 'child_profiles exists');
select has_table('public', 'parental_consents', 'parental_consents exists');
select has_table('public', 'curriculum_versions', 'curriculum_versions exists');
select has_column('public', 'child_profiles', 'household_id', 'profiles belong to household');
select has_column('public', 'parental_consents', 'policy_version', 'consent is versioned');
select policies_are(
  'public',
  'child_profiles',
  array['members manage child profiles'],
  'child profile household policy exists'
);
select policies_are(
  'public',
  'parental_consents',
  array['members manage consents'],
  'consent household policy exists'
);

select * from finish();
rollback;
