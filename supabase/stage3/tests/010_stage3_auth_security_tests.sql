begin;

create schema stage3_test;
create function stage3_test.assert_true(actual boolean, message text)
returns void language plpgsql as $$
begin
  if actual is distinct from true then
    raise exception 'ASSERTION FAILED: %', message;
  end if;
end;
$$;
create function stage3_test.expect_failure(command text, message text)
returns void language plpgsql as $$
begin
  begin execute command;
  exception when others then return;
  end;
  raise exception 'ASSERTION FAILED: %', message;
end;
$$;
create function stage3_test.assert_rows(command text, expected bigint, message text)
returns void language plpgsql as $$
declare actual bigint;
begin
  execute command;
  get diagnostics actual = row_count;
  if actual <> expected then
    raise exception 'ASSERTION FAILED: % (expected %, got %)', message, expected, actual;
  end if;
end;
$$;

grant usage on schema stage3_test to anon, authenticated, service_role;
grant execute on all functions in schema stage3_test to anon, authenticated, service_role;

insert into public.organizations (id, code, name, timezone) values
  ('10000000-0000-0000-0000-000000000001', 'RW-ONE', 'Rawdat One', 'Asia/Damascus'),
  ('10000000-0000-0000-0000-000000000002', 'RW-TWO', 'Rawdat Two', 'Asia/Riyadh');
insert into public.branches (id, organization_id, code, name) values
  ('20000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'DAM', 'Damascus'),
  ('20000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 'ALP', 'Aleppo'),
  ('20000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000002', 'HMS', 'Homs');
insert into public.classes (id, organization_id, branch_id, code, name, academic_year) values
  ('30000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'KG-A', 'Damascus A', '2026-2027'),
  ('30000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 'KG-A', 'Aleppo A', '2026-2027'),
  ('30000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000003', 'KG-A', 'Homs A', '2026-2027');
insert into auth.users(id) values
  ('40000000-0000-0000-0000-000000000001'),
  ('40000000-0000-0000-0000-000000000002'),
  ('40000000-0000-0000-0000-000000000004'),
  ('40000000-0000-0000-0000-000000000005'),
  ('40000000-0000-0000-0000-000000000006'),
  ('40000000-0000-0000-0000-000000000007'),
  ('40000000-0000-0000-0000-000000000009');
insert into public.profiles(id, organization_id, branch_id, display_name, role, status) values
  ('40000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', null, 'Org One Admin', 'organization_admin', 'active'),
  ('40000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Manager', 'branch_manager', 'active'),
  ('40000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Teacher', 'teacher', 'active'),
  ('40000000-0000-0000-0000-000000000005', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Student', 'student', 'active'),
  ('40000000-0000-0000-0000-000000000006', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 'Aleppo Student', 'student', 'active'),
  ('40000000-0000-0000-0000-000000000007', '10000000-0000-0000-0000-000000000002', null, 'Org Two Admin', 'organization_admin', 'active'),
  ('40000000-0000-0000-0000-000000000009', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Damascus Staff', 'staff', 'active');
insert into public.students(id, profile_id, organization_id, branch_id, class_id, student_code) values
  ('50000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000005', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'ST-001'),
  ('50000000-0000-0000-0000-000000000002', '40000000-0000-0000-0000-000000000006', '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000002', 'ST-002');
insert into public.teacher_classes(organization_id, branch_id, teacher_id, class_id) values
  ('10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000001');

insert into public.student_auth_credentials(profile_id, organization_id, auth_email)
values
  ('40000000-0000-0000-0000-000000000005', '10000000-0000-0000-0000-000000000001', 'student-one@auth.invalid'),
  ('40000000-0000-0000-0000-000000000006', '10000000-0000-0000-0000-000000000001', 'student-two@auth.invalid');

-- Anonymous requests have neither operational table access nor context RPC.
set local role anon;
select stage3_test.expect_failure(
  $q$select * from public.resolve_my_authorization_context()$q$,
  'anonymous caller must not resolve an authorization context'
);
select stage3_test.expect_failure(
  $q$select * from public.profiles$q$,
  'anonymous caller must not read protected profiles'
);

-- Server-only credential metadata and privileged RPCs are not client readable.
set local role authenticated;
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000005', true);
select stage3_test.expect_failure(
  $q$select * from public.student_auth_credentials$q$,
  'student credential metadata must not be readable by authenticated users'
);
select stage3_test.expect_failure(
  $q$select * from public.begin_student_login('RW-ONE', 'ST-001')$q$,
  'student login reservation RPC must be service-only'
);
select stage3_test.expect_failure(
  $q$select public.provision_membership_record(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', null, 'Spoof', 'staff', null, null, '40000000-0000-0000-0000-000000000005')$q$,
  'direct provisioning must be service-only'
);

-- A trusted context is self-bound and includes the required student class.
select stage3_test.assert_true(
  (select id = '40000000-0000-0000-0000-000000000005'
          and organization_id = '10000000-0000-0000-0000-000000000001'
          and branch_id = '20000000-0000-0000-0000-000000000001'
          and class_id = '30000000-0000-0000-0000-000000000001'
          and role = 'student' and status = 'active'
   from public.resolve_my_authorization_context()),
  'authorization context must be bound to auth.uid and student extension'
);

-- Branch managers cannot provision across branches or elevate admin roles.
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000002', true);
select stage3_test.assert_true(
  public.authorize_membership_administration(
    '10000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000001', 'student'),
  'branch manager may provision ordinary users in own branch'
);
select stage3_test.assert_true(
  not public.authorize_membership_administration(
    '10000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000002', 'student'),
  'branch manager cannot provision in sibling branch'
);
select stage3_test.assert_true(
  not public.authorize_membership_administration(
    '10000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000001', 'branch_manager'),
  'branch manager cannot assign a branch manager role'
);

-- Inactive membership loses operational access even while an Auth token exists.
reset role;
update public.profiles set status = 'suspended'
where id = '40000000-0000-0000-0000-000000000005';
set local role authenticated;
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000005', true);
select stage3_test.assert_true(
  (select status = 'suspended' from public.resolve_my_authorization_context()),
  'client can resolve its own inactive state without seeing another profile'
);
select stage3_test.assert_true(
  (select count(*) = 0 from public.students),
  'inactive user must lose operational RLS access immediately'
);

-- Five reserved failed attempts cause a 15-minute lock; success clears it.
reset role;
update public.profiles set status = 'active'
where id = '40000000-0000-0000-0000-000000000005';
set local role service_role;
select * from public.begin_student_login('RW-ONE', 'ST-001');
select * from public.begin_student_login('RW-ONE', 'ST-001');
select * from public.begin_student_login('RW-ONE', 'ST-001');
select * from public.begin_student_login('RW-ONE', 'ST-001');
select * from public.begin_student_login('RW-ONE', 'ST-001');
select stage3_test.assert_true(
  (select failed_attempts = 5 and locked_until >= now() + interval '14 minutes'
   from public.student_auth_credentials
   where profile_id = '40000000-0000-0000-0000-000000000005'),
  'fifth failed attempt must establish a fifteen-minute lock'
);
select stage3_test.assert_true(
  not exists(select 1 from public.begin_student_login('RW-ONE', 'ST-001')),
  'locked credential must not expose an auth identifier'
);
select public.complete_student_login('40000000-0000-0000-0000-000000000005');
select stage3_test.assert_true(
  (select failed_attempts = 0 and locked_until is null
   from public.student_auth_credentials
   where profile_id = '40000000-0000-0000-0000-000000000005'),
  'successful login must clear failure state'
);

-- Service-only provisioning preserves Auth/Profile identity and tenant shape.
reset role;
insert into auth.users(id) values
  ('40000000-0000-0000-0000-000000000011'),
  ('40000000-0000-0000-0000-000000000012');
set local role service_role;
select public.provision_membership_record(
  '40000000-0000-0000-0000-000000000011',
  '10000000-0000-0000-0000-000000000001',
  '20000000-0000-0000-0000-000000000001',
  '30000000-0000-0000-0000-000000000001',
  'Provisioned Student', 'student', 'ST-011',
  'student-eleven@auth.invalid',
  '40000000-0000-0000-0000-000000000001'
);
reset role;
select stage3_test.assert_true(
  exists(
    select 1 from auth.users u
    join public.profiles p on p.id = u.id
    join public.students s on s.profile_id = p.id
    where u.id = '40000000-0000-0000-0000-000000000011'
      and p.organization_id = s.organization_id
      and p.branch_id = s.branch_id
  ),
  'provisioning must preserve auth.users.id=profiles.id and student tenant shape'
);
set local role service_role;
select stage3_test.expect_failure(
  $q$select public.provision_membership_record(
    '40000000-0000-0000-0000-000000000012',
    '10000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000003', null,
    'Cross Tenant', 'staff', null, null,
    '40000000-0000-0000-0000-000000000001')$q$,
  'provisioning cannot create a cross-tenant branch relationship'
);

-- A student branch/class move is atomic and cannot weaken tenant constraints.
select public.change_membership_record(
  '40000000-0000-0000-0000-000000000005',
  '20000000-0000-0000-0000-000000000002',
  '30000000-0000-0000-0000-000000000002',
  'student', 'active',
  '40000000-0000-0000-0000-000000000001'
);
reset role;
select stage3_test.assert_true(
  exists(
    select 1 from public.profiles p join public.students s on s.profile_id = p.id
    where p.id = '40000000-0000-0000-0000-000000000005'
      and p.branch_id = '20000000-0000-0000-0000-000000000002'
      and s.branch_id = p.branch_id
      and s.class_id = '30000000-0000-0000-0000-000000000002'
  ),
  'student membership move must update profile and extension atomically'
);
set local role service_role;
select stage3_test.expect_failure(
  $q$select public.change_membership_record(
    '40000000-0000-0000-0000-000000000001', null, null,
    'organization_admin', 'suspended',
    '40000000-0000-0000-0000-000000000001')$q$,
  'last active organization administrator cannot be suspended'
);

-- A failed Auth revocation is retained as an operational security signal.
select public.record_auth_security_event(
  '10000000-0000-0000-0000-000000000001',
  '40000000-0000-0000-0000-000000000001',
  '40000000-0000-0000-0000-000000000005',
  'session_revocation_failed',
  '{"operation":"membership_update"}'::jsonb
);
reset role;
select stage3_test.assert_true(
  exists(
    select 1 from public.auth_security_events
    where subject_id = '40000000-0000-0000-0000-000000000005'
      and event_type = 'session_revocation_failed'
      and metadata ->> 'operation' = 'membership_update'
  ),
  'session revocation failure must be retained for operational follow-up'
);

-- Existing Stage 2 RLS still rejects foreign IDs and direct profile mutation.
set local role authenticated;
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000004', true);
select stage3_test.assert_true(
  (select count(*) = 0 from public.students
   where profile_id = '40000000-0000-0000-0000-000000000006'),
  'teacher cannot access an unrelated class through a foreign student ID'
);
select set_config('request.jwt.claim.sub', '40000000-0000-0000-0000-000000000009', true);
select stage3_test.assert_true(
  (select count(*) = 0 from public.students),
  'staff has no implicit access to child records'
);
select stage3_test.assert_rows(
  $q$update public.profiles set role = 'organization_admin', branch_id = null where id = '40000000-0000-0000-0000-000000000009'$q$,
  0,
  'client role and scope spoofing must fail'
);

rollback;

select 'STAGE_3_AUTH_SECURITY_TESTS_PASS' as result;
