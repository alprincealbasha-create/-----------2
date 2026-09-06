begin;

create schema test;

create function test.assert_true(actual boolean, message text)
returns void language plpgsql as $$
begin
  if actual is distinct from true then
    raise exception 'ASSERTION FAILED: %', message;
  end if;
end;
$$;

create function test.assert_count(query text, expected bigint, message text)
returns void language plpgsql as $$
declare actual bigint;
begin
  execute format('select count(*) from (%s) q', query) into actual;
  if actual <> expected then
    raise exception 'ASSERTION FAILED: % (expected %, got %)', message, expected, actual;
  end if;
end;
$$;

create function test.assert_rows(command text, expected bigint, message text)
returns void language plpgsql as $$
declare actual bigint;
begin
  execute command;
  get diagnostics actual = row_count;
  if actual <> expected then
    raise exception 'ASSERTION FAILED: % (expected % affected rows, got %)', message, expected, actual;
  end if;
end;
$$;

create function test.expect_failure(command text, message text)
returns void language plpgsql as $$
begin
  begin
    execute command;
  exception when others then
    return;
  end;
  raise exception 'ASSERTION FAILED: % (command unexpectedly succeeded)', message;
end;
$$;

create function test.expect_deferred_failure(command text, message text)
returns void language plpgsql as $$
begin
  begin
    execute command;
    set constraints all immediate;
  exception when others then
    set constraints all deferred;
    return;
  end;
  raise exception 'ASSERTION FAILED: % (deferred constraint unexpectedly succeeded)', message;
end;
$$;

grant usage on schema test to authenticated;
grant execute on all functions in schema test to authenticated;

insert into public.organizations (id, code, name, timezone) values
  ('10000000-0000-0000-0000-000000000001', 'RW-ONE', 'Rawdat One', 'Asia/Damascus'),
  ('10000000-0000-0000-0000-000000000002', 'RW-TWO', 'Rawdat Two', 'Asia/Riyadh');

insert into public.branches (id, organization_id, code, name, governorate, city) values
  ('20000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'DAM', 'Damascus', 'Damascus', 'Damascus'),
  ('20000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 'ALP', 'Aleppo', 'Aleppo', 'Aleppo'),
  ('20000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000002', 'DAM', 'Other Damascus', 'Damascus', 'Damascus');

insert into public.classes (id, organization_id, branch_id, code, name, academic_year) values
  ('30000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'KG-A', 'Damascus A', '2026-2027'),
  ('30000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 'KG-A', 'Aleppo A', '2026-2027'),
  ('30000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000003', 'KG-A', 'Other A', '2026-2027');

insert into auth.users (id) values
  ('40000000-0000-0000-0000-000000000001'),
  ('40000000-0000-0000-0000-000000000002'),
  ('40000000-0000-0000-0000-000000000003'),
  ('40000000-0000-0000-0000-000000000004'),
  ('40000000-0000-0000-0000-000000000005'),
  ('40000000-0000-0000-0000-000000000006'),
  ('40000000-0000-0000-0000-000000000007'),
  ('40000000-0000-0000-0000-000000000008'),
  ('40000000-0000-0000-0000-000000000009'),
  ('40000000-0000-0000-0000-000000000010'),
  ('40000000-0000-0000-0000-000000000011');

insert into public.profiles (id, organization_id, branch_id, display_name, role, status) values
  ('40000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', null, 'Org One Admin', 'organization_admin', 'active'),
  ('40000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Manager', 'branch_manager', 'active'),
  ('40000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 'Aleppo Manager', 'branch_manager', 'active'),
  ('40000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Teacher', 'teacher', 'active'),
  ('40000000-0000-0000-0000-000000000005', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Student', 'student', 'active'),
  ('40000000-0000-0000-0000-000000000006', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 'Aleppo Student', 'student', 'active'),
  ('40000000-0000-0000-0000-000000000007', '10000000-0000-0000-0000-000000000002', null, 'Org Two Admin', 'organization_admin', 'active'),
  ('40000000-0000-0000-0000-000000000008', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 'Aleppo Teacher', 'teacher', 'active'),
  ('40000000-0000-0000-0000-000000000009', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Staff', 'staff', 'active'),
  ('40000000-0000-0000-0000-000000000010', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Invited Manager', 'branch_manager', 'invited');

insert into public.students (id, profile_id, organization_id, branch_id, class_id, student_code) values
  ('50000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000005', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'ST-001'),
  ('50000000-0000-0000-0000-000000000002', '40000000-0000-0000-0000-000000000006', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000002', 'ST-002');

insert into public.teacher_classes (organization_id, branch_id, teacher_id, class_id) values
  ('10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000001'),
  ('10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', '40000000-0000-0000-0000-000000000008', '30000000-0000-0000-0000-000000000002');

-- Schema and constraint checks as the migration owner.
select test.assert_true((select count(*) = 6 from pg_catalog.pg_class c join pg_catalog.pg_namespace n on n.oid = c.relnamespace where n.nspname = 'public' and c.relname in ('organizations','branches','classes','profiles','students','teacher_classes') and c.relrowsecurity), 'all six Stage 2 tables must have RLS enabled');
select test.assert_true((select count(*) = 15 from pg_catalog.pg_policies where schemaname = 'public' and tablename in ('organizations','branches','classes','profiles','students','teacher_classes')), 'expected RLS policy set must exist');
select test.expect_failure($q$insert into public.organizations (code, name) values (' rw-one ', 'Duplicate')$q$, 'organization code must be globally normalized unique');
select test.expect_failure($q$insert into public.organizations (code, name, timezone) values ('BAD-TZ', 'Bad timezone', 'Not/AZone')$q$, 'invalid timezone must be rejected');
select test.expect_failure($q$insert into public.branches (organization_id, code, name) values ('10000000-0000-0000-0000-000000000001', ' dam ', 'Duplicate')$q$, 'branch code must be normalized unique inside organization');
select test.expect_failure($q$insert into public.classes (organization_id, branch_id, code, name, academic_year) values ('10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', ' kg-a ', 'Duplicate', '2026-2027')$q$, 'class code/year must be normalized unique inside branch');
select test.expect_failure($q$insert into public.profiles (id, organization_id, branch_id, display_name, role, status) values ('40000000-0000-0000-0000-000000000011', '10000000-0000-0000-0000-000000000001', null, 'Bad Student Scope', 'student', 'active')$q$, 'student role must have a branch');
select test.expect_failure($q$insert into public.profiles (id, organization_id, branch_id, display_name, role, status) values ('40000000-0000-0000-0000-000000000011', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000003', 'Cross Tenant Employee', 'staff', 'active')$q$, 'employee branch must belong to profile organization');
select test.expect_failure($q$update public.students set class_id = '30000000-0000-0000-0000-000000000003' where id = '50000000-0000-0000-0000-000000000001'$q$, 'student class must match organization and branch');
select test.expect_failure($q$insert into public.students (profile_id, organization_id, branch_id, class_id, student_code) values ('40000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'BAD-ROLE')$q$, 'student extension requires student profile role');
select test.expect_failure($q$update public.students set student_code = ' st-001 ' where id = '50000000-0000-0000-0000-000000000002'$q$, 'student code must be normalized unique inside organization');
select test.expect_failure($q$insert into public.teacher_classes (organization_id, branch_id, teacher_id, class_id) values ('10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001')$q$, 'teacher assignment requires teacher role');
select test.expect_failure($q$insert into public.teacher_classes (organization_id, branch_id, teacher_id, class_id) values ('10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000002')$q$, 'teacher assignment cannot cross branches');
select test.expect_failure($q$update public.profiles set role = 'staff' where id = '40000000-0000-0000-0000-000000000005'$q$, 'student role cannot change while student extension exists');
select test.expect_failure($q$update public.profiles set role = 'staff' where id = '40000000-0000-0000-0000-000000000004'$q$, 'teacher role cannot change while class assignment exists');
select test.expect_deferred_failure($q$delete from public.students where id = '50000000-0000-0000-0000-000000000001'$q$, 'student extension cannot be removed while the student profile remains');
select test.expect_deferred_failure($q$insert into public.profiles (id, organization_id, branch_id, display_name, role, status) values ('40000000-0000-0000-0000-000000000011', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Orphan Student', 'student', 'active')$q$, 'student profile must have an extension by transaction end');

set local role authenticated;

-- Organization admin: own organization only, with managed writes.
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000001', true);
select test.assert_count('select * from public.organizations', 1, 'organization admin sees one organization');
select test.assert_count('select * from public.branches', 2, 'organization admin sees all own branches');
select test.assert_count('select * from public.students', 2, 'organization admin sees all own students');
select test.assert_rows($q$insert into public.branches (id, organization_id, code, name) values ('20000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000001', 'HMS', 'Homs')$q$, 1, 'organization admin can add own branch');
select test.expect_failure($q$insert into public.branches (organization_id, code, name) values ('10000000-0000-0000-0000-000000000002', 'NEW', 'Cross Org')$q$, 'organization admin cannot add branch to another organization');

-- Damascus manager: no Aleppo or second-organization access.
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000002', true);
select test.assert_count('select * from public.branches', 1, 'Damascus manager sees only Damascus branch');
select test.assert_count('select * from public.classes', 1, 'Damascus manager sees only Damascus class');
select test.assert_count('select * from public.students', 1, 'Damascus manager sees only Damascus student');
select test.assert_count('select * from public.profiles', 5, 'Damascus manager sees branch profiles only');
select test.assert_rows($q$update public.classes set name = 'Damascus A Updated' where id = '30000000-0000-0000-0000-000000000001'$q$, 1, 'manager can update own class');
select test.assert_rows($q$update public.classes set name = 'Forbidden' where id = '30000000-0000-0000-0000-000000000002'$q$, 0, 'manager cannot update sibling branch class');
select test.assert_rows($q$update public.students set status = 'suspended' where id = '50000000-0000-0000-0000-000000000001'$q$, 1, 'manager can update own student');
select test.assert_rows($q$update public.students set status = 'suspended' where id = '50000000-0000-0000-0000-000000000002'$q$, 0, 'manager cannot update sibling branch student');
select test.assert_rows($q$update public.profiles set role = 'organization_admin' where id = '40000000-0000-0000-0000-000000000002'$q$, 0, 'authenticated manager cannot mutate profile role');
select test.assert_rows($q$delete from public.branches where id = '20000000-0000-0000-0000-000000000001'$q$, 0, 'branch delete is denied');
select test.assert_rows($q$delete from public.classes where id = '30000000-0000-0000-0000-000000000001'$q$, 0, 'class delete is denied');
select test.assert_rows($q$delete from public.students where id = '50000000-0000-0000-0000-000000000001'$q$, 0, 'student delete is denied');
select test.assert_rows($q$delete from public.teacher_classes where teacher_id = '40000000-0000-0000-0000-000000000008'$q$, 0, 'manager cannot delete sibling branch assignment');
select test.assert_rows($q$delete from public.teacher_classes where teacher_id = '40000000-0000-0000-0000-000000000004'$q$, 1, 'manager can delete own branch assignment');

-- Teacher: only own assignment and linked student.
reset role;
insert into public.teacher_classes (organization_id, branch_id, teacher_id, class_id) values
  ('10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000001');
set local role authenticated;
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000004', true);
select test.assert_count('select * from public.classes', 1, 'teacher sees assigned class only');
select test.assert_count('select * from public.students', 1, 'teacher sees assigned students only');
select test.assert_count('select * from public.profiles', 2, 'teacher sees self and linked student profile');
select test.assert_count('select * from public.teacher_classes', 1, 'teacher sees own assignments only');
select test.assert_rows($q$update public.students set status = 'active' where id = '50000000-0000-0000-0000-000000000001'$q$, 0, 'teacher cannot update student');

-- Student: self and own hierarchy only.
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000005', true);
select test.assert_count('select * from public.organizations', 1, 'student sees own organization');
select test.assert_count('select * from public.branches', 1, 'student sees own branch');
select test.assert_count('select * from public.classes', 1, 'student sees own class');
select test.assert_count('select * from public.profiles', 1, 'student sees own profile only');
select test.assert_count('select * from public.students', 1, 'student sees own student row only');
select test.assert_rows($q$update public.students set status = 'active' where profile_id = '40000000-0000-0000-0000-000000000005'$q$, 0, 'student cannot update own managed record');

-- Staff gets branch directory but no child records.
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000009', true);
select test.assert_count('select * from public.classes', 1, 'staff sees own branch classes');
select test.assert_count('select * from public.students', 0, 'staff has no student data access by default');
select test.assert_count('select * from public.profiles', 1, 'staff sees own profile only');

-- Non-active actors authorize nothing.
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000010', true);
select test.assert_count('select * from public.organizations', 0, 'invited actor sees no organization');
select test.assert_count('select * from public.branches', 0, 'invited actor sees no branch');
select test.assert_count('select * from public.profiles', 0, 'invited actor sees no profile through active-only authorization');

reset role;
rollback;

select 'STAGE_2_DATABASE_TESTS_PASS' as result;
