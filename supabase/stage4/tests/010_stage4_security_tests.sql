begin;

create schema stage4_test;
create function stage4_test.assert_true(actual boolean, message text)
returns void language plpgsql as $$ begin
  if actual is distinct from true then raise exception 'ASSERTION FAILED: %', message; end if;
end $$;
create function stage4_test.expect_failure(command text, message text)
returns void language plpgsql as $$ begin
  begin execute command; exception when others then return; end;
  raise exception 'ASSERTION FAILED: %', message;
end $$;
create function stage4_test.assert_rows(command text, expected bigint, message text)
returns void language plpgsql as $$ declare actual bigint; begin
  execute command; get diagnostics actual = row_count;
  if actual <> expected then raise exception 'ASSERTION FAILED: % (expected %, got %)', message, expected, actual; end if;
end $$;
grant usage on schema stage4_test to anon, authenticated, service_role;
grant execute on all functions in schema stage4_test to anon, authenticated, service_role;

insert into public.organizations(id, code, name, timezone) values
 ('10000000-0000-0000-0000-000000000001','ORG-A','Organization A','Asia/Damascus'),
 ('10000000-0000-0000-0000-000000000002','ORG-B','Organization B','Asia/Riyadh');
insert into public.branches(id,organization_id,code,name) values
 ('20000000-0000-0000-0000-000000000001','10000000-0000-0000-0000-000000000001','DAM','Damascus'),
 ('20000000-0000-0000-0000-000000000002','10000000-0000-0000-0000-000000000001','ALP','Aleppo'),
 ('20000000-0000-0000-0000-000000000003','10000000-0000-0000-0000-000000000002','HMS','Homs');
insert into public.classes(id,organization_id,branch_id,code,name,academic_year) values
 ('30000000-0000-0000-0000-000000000001','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','A','Damascus A','2026-2027'),
 ('30000000-0000-0000-0000-000000000002','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000002','A','Aleppo A','2026-2027'),
 ('30000000-0000-0000-0000-000000000003','10000000-0000-0000-0000-000000000002','20000000-0000-0000-0000-000000000003','A','Homs A','2026-2027');
insert into auth.users(id) select x::uuid from unnest(array[
 '40000000-0000-0000-0000-000000000001','40000000-0000-0000-0000-000000000002',
 '40000000-0000-0000-0000-000000000003','40000000-0000-0000-0000-000000000004',
 '40000000-0000-0000-0000-000000000005','40000000-0000-0000-0000-000000000006',
 '40000000-0000-0000-0000-000000000007','40000000-0000-0000-0000-000000000008',
 '40000000-0000-0000-0000-000000000009','40000000-0000-0000-0000-000000000010'
]) x;
insert into public.profiles(id,organization_id,branch_id,display_name,role,status) values
 ('40000000-0000-0000-0000-000000000001','10000000-0000-0000-0000-000000000001',null,'Org A Admin','organization_admin','active'),
 ('40000000-0000-0000-0000-000000000002','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','Damascus Manager','branch_manager','active'),
 ('40000000-0000-0000-0000-000000000003','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000002','Aleppo Manager','branch_manager','active'),
 ('40000000-0000-0000-0000-000000000004','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','Damascus Teacher','teacher','active'),
 ('40000000-0000-0000-0000-000000000005','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','Student One','student','active'),
 ('40000000-0000-0000-0000-000000000006','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','Student Two','student','active'),
 ('40000000-0000-0000-0000-000000000007','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000002','Aleppo Student','student','active'),
 ('40000000-0000-0000-0000-000000000008','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','Inactive Student','student','suspended'),
 ('40000000-0000-0000-0000-000000000009','10000000-0000-0000-0000-000000000002',null,'Org B Admin','organization_admin','active'),
 ('40000000-0000-0000-0000-000000000010','10000000-0000-0000-0000-000000000002','20000000-0000-0000-0000-000000000003','Org B Student','student','active');
insert into public.students(id,profile_id,organization_id,branch_id,class_id,student_code,status) values
 ('50000000-0000-0000-0000-000000000005','40000000-0000-0000-0000-000000000005','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','30000000-0000-0000-0000-000000000001','S-1','active'),
 ('50000000-0000-0000-0000-000000000006','40000000-0000-0000-0000-000000000006','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','30000000-0000-0000-0000-000000000001','S-2','active'),
 ('50000000-0000-0000-0000-000000000007','40000000-0000-0000-0000-000000000007','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000002','30000000-0000-0000-0000-000000000002','S-3','active'),
 ('50000000-0000-0000-0000-000000000008','40000000-0000-0000-0000-000000000008','10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','30000000-0000-0000-0000-000000000001','S-4','suspended'),
 ('50000000-0000-0000-0000-000000000010','40000000-0000-0000-0000-000000000010','10000000-0000-0000-0000-000000000002','20000000-0000-0000-0000-000000000003','30000000-0000-0000-0000-000000000003','S-5','active');
insert into public.teacher_classes(organization_id,branch_id,teacher_id,class_id) values
 ('10000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000001','40000000-0000-0000-0000-000000000004','30000000-0000-0000-0000-000000000001');

-- Anonymous and client-side direct mutations cannot bypass RPC validation.
set local role anon;
select stage4_test.expect_failure($q$select * from public.dhikr_definitions$q$, 'anonymous cannot read Stage 4 content');
select stage4_test.expect_failure($q$select * from public.list_todays_wirds()$q$, 'anonymous cannot invoke today RPC');

set local role authenticated;
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000001',true);
select stage4_test.expect_failure(
 $q$insert into public.dhikr_definitions(organization_id,title,display_text,default_target,created_by) values ('10000000-0000-0000-0000-000000000001','x','x',1,'40000000-0000-0000-0000-000000000001')$q$,
 'direct table mutation must be denied');

-- Organization A creates/reviews approved content and an active current wird.
create temporary table created_ids(kind text, id uuid);
with d as (select (public.save_dhikr_definition(null,'10000000-0000-0000-0000-000000000001','Tasbih','Subhan Allah','Approved content',100,'in_review','Reference')).id)
insert into created_ids select 'dhikr_a', id from d;
with d as (select (public.save_dhikr_definition((select id from created_ids where kind='dhikr_a'),'10000000-0000-0000-0000-000000000001','Tasbih','Subhan Allah','Approved content',100,'approved','Reference')).id)
select stage4_test.assert_true((select id is not null from d),'organization admin approves dhikr');
with w as (select (public.save_wird(null,'10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Today Wird','Current assignment',100,now()-interval '1 hour',now()+interval '23 hours','scheduled')).id)
insert into created_ids select 'wird_a', id from w;
with w as (select (public.save_wird((select id from created_ids where kind='wird_a'),'10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Today Wird','Current assignment',100,now()-interval '1 hour',now()+interval '23 hours','active')).id)
select stage4_test.assert_true((select id is not null from w),'scheduled wird activates');

-- All five assignment scopes materialize deterministically. Repeated audience overlap is deduplicated.
select * from public.create_wird_assignment((select id from created_ids where kind='wird_a'),'organization',null,null,null,null);
select * from public.create_wird_assignment((select id from created_ids where kind='wird_a'),'branch','20000000-0000-0000-0000-000000000001',null,null,null);
select * from public.create_wird_assignment((select id from created_ids where kind='wird_a'),'class','20000000-0000-0000-0000-000000000001','30000000-0000-0000-0000-000000000001',null,null);
select * from public.create_wird_assignment((select id from created_ids where kind='wird_a'),'role',null,null,'student',null);
select * from public.create_wird_assignment((select id from created_ids where kind='wird_a'),'user','20000000-0000-0000-0000-000000000001',null,null,'40000000-0000-0000-0000-000000000005');
select stage4_test.assert_true(
 (select count(*) = count(distinct user_id) from public.user_wird_instances where wird_id=(select id from created_ids where kind='wird_a')),
 'overlapping assignment scopes create one obligation per user and wird');
select stage4_test.assert_true(
 not exists(select 1 from public.user_wird_instances where user_id='40000000-0000-0000-0000-000000000008'),
 'disabled users receive no new instance');

-- Duplicate materialization stays idempotent.
select public.materialize_wird_assignment((select id from public.wird_assignments where wird_id=(select id from created_ids where kind='wird_a') order by created_at,id limit 1));
select stage4_test.assert_true(
 (select count(*) = count(distinct user_id) from public.user_wird_instances where wird_id=(select id from created_ids where kind='wird_a')),
 'manual rematerialization remains idempotent');

-- Atomic creation materializes before activation, while Today obeys lifecycle.
with w as (
  select * from public.create_wird_with_assignments(
    '10000000-0000-0000-0000-000000000001',
    (select id from created_ids where kind='dhikr_a'), 'Pre-activation', null, 25,
    (now() at time zone 'Asia/Damascus')::date, (now() at time zone 'Asia/Damascus')::date,
    '[{"scope_type":"user","branch_id":"20000000-0000-0000-0000-000000000001","user_id":"40000000-0000-0000-0000-000000000006"}]'::jsonb
  )
) insert into created_ids select 'pre_activation', wird_id from w;
select stage4_test.assert_true(exists(
 select 1 from public.user_wird_instances where wird_id=(select id from created_ids where kind='pre_activation')
   and user_id='40000000-0000-0000-0000-000000000006'
), 'assignment created before activation is materialized');
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000006',true);
select stage4_test.assert_true((select count(*)=1 from public.list_todays_wirds()), 'scheduled item is hidden while existing active item remains');
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000001',true);
select public.save_wird((select id from created_ids where kind='pre_activation'),'10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Pre-activation',null,25,now()-interval '1 hour',now()+interval '2 hours','active');
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000006',true);
select stage4_test.assert_true((select count(*)=2 from public.list_todays_wirds()), 'activated item appears using server time');
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000001',true);
select public.save_wird((select id from created_ids where kind='pre_activation'),'10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Pre-activation',null,25,now()-interval '1 hour',now()+interval '2 hours','cancelled');

-- Historical snapshots survive later content edits and assignment revocation.
create temporary table original_snapshot as select id, wird_title_snapshot, dhikr_text_snapshot, target_count, start_at, end_at
from public.user_wird_instances where user_id='40000000-0000-0000-0000-000000000005' and wird_id=(select id from created_ids where kind='wird_a');
select public.save_wird((select id from created_ids where kind='wird_a'),'10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Changed title','Changed',200,now()-interval '2 hours',now()+interval '22 hours','active');
select public.revoke_wird_assignment((select id from public.wird_assignments where wird_id=(select id from created_ids where kind='wird_a') and scope_type='user'));
select stage4_test.assert_true(exists(
 select 1 from public.user_wird_instances i join original_snapshot s on s.id=i.id
 where (i.wird_title_snapshot,i.dhikr_text_snapshot,i.target_count,i.start_at,i.end_at) =
       (s.wird_title_snapshot,s.dhikr_text_snapshot,s.target_count,s.start_at,s.end_at)
), 'historical instance snapshot remains stable after edits and revocation');
select stage4_test.expect_failure(
 $q$update public.user_wird_instances set target_count=999 where user_id='40000000-0000-0000-0000-000000000005'$q$,
 'historical instance rows are immutable');

-- Organization isolation and malicious foreign identifiers.
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000009',true);
with d as (select (public.save_dhikr_definition(null,'10000000-0000-0000-0000-000000000002','Org B Dhikr','Private B',null,10,'draft',null)).id)
insert into created_ids select 'dhikr_b', id from d;
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000001',true);
select stage4_test.assert_true((select count(*)=0 from public.dhikr_definitions where id=(select id from created_ids where kind='dhikr_b')), 'organization A cannot read organization B dhikr');
select stage4_test.expect_failure(
 $q$select public.save_dhikr_definition(null,'10000000-0000-0000-0000-000000000002','Cross tenant','No',null,10,'draft',null)$q$,
 'organization A cannot write organization B dhikr');
select stage4_test.expect_failure(
 format('select * from public.create_wird_assignment(%L,''branch'',%L,null,null,null)',(select id from created_ids where kind='wird_a'),'20000000-0000-0000-0000-000000000003'),
 'foreign organization branch ID must be rejected');
select stage4_test.expect_failure(
 format('select * from public.create_wird_assignment(%L,''class'',%L,%L,null,null)',(select id from created_ids where kind='wird_a'),'20000000-0000-0000-0000-000000000002','30000000-0000-0000-0000-000000000001'),
 'class cannot be attached under a different branch');
select stage4_test.expect_failure(
 format('select * from public.create_wird_assignment(%L,''user'',%L,null,null,%L)',(select id from created_ids where kind='wird_a'),'20000000-0000-0000-0000-000000000003','40000000-0000-0000-0000-000000000010'),
 'foreign organization user cannot be assigned');
select stage4_test.expect_failure(
 format('select * from public.create_wird_assignment(%L,''user'',%L,null,null,%L)',(select id from created_ids where kind='wird_a'),'20000000-0000-0000-0000-000000000001','40000000-0000-0000-0000-000000000008'),
 'inactive user cannot be directly assigned');

-- Branch manager stays inside own branch and cannot spoof role claims.
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000002',true);
select set_config('request.jwt.claim.role','organization_admin',true);
select stage4_test.expect_failure(
 format('select * from public.create_wird_assignment(%L,''branch'',%L,null,null,null)',(select id from created_ids where kind='wird_a'),'20000000-0000-0000-0000-000000000002'),
 'branch manager cannot assign a sibling branch even with spoofed claims');
select stage4_test.expect_failure(
 format('select * from public.create_wird_assignment(%L,''organization'',null,null,null,null)',(select id from created_ids where kind='wird_a')),
 'branch manager cannot create organization scope');
select stage4_test.assert_true((select count(*)=0 from public.profiles where branch_id='20000000-0000-0000-0000-000000000002'), 'branch manager cannot inspect sibling branch users');

-- Students can read only their instance, cannot enumerate audience/content, and cannot mutate.
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000005',true);
select stage4_test.assert_true((select count(*)=1 from public.user_wird_instances), 'student sees only own instance through RLS');
select stage4_test.assert_true((select count(*)=1 from public.list_todays_wirds()), 'today RPC returns own active current item');
select stage4_test.assert_true((select count(*)=0 from public.wird_assignments), 'student cannot enumerate assignment audiences');
select stage4_test.assert_true((select count(*)=0 from public.dhikr_definitions), 'student cannot enumerate content library');
select stage4_test.expect_failure(
 $q$select public.save_dhikr_definition(null,'10000000-0000-0000-0000-000000000001','Spoof','Spoof',null,1,'draft',null)$q$,
 'student cannot gain management through a direct RPC call');
reset role;
update public.classes set status='suspended' where id='30000000-0000-0000-0000-000000000001';
set local role authenticated;
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000005',true);
select stage4_test.assert_true((select count(*)=0 from public.user_wird_instances), 'suspended class removes current student instance access');
select stage4_test.assert_true((select count(*)=0 from public.list_todays_wirds()), 'suspended class removes Today access');
reset role;
update public.classes set status='active' where id='30000000-0000-0000-0000-000000000001';

-- Teacher has no unrelated branch/class exposure and only receives personal content.
set local role authenticated;
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000004',true);
select stage4_test.assert_true((select count(*)=1 from public.user_wird_instances), 'teacher sees only personal assigned instance');
select stage4_test.assert_true((select count(*)=0 from public.wird_assignments), 'teacher cannot enumerate assignment audience');
select stage4_test.assert_true((select count(*)=0 from public.classes where id='30000000-0000-0000-0000-000000000002'), 'teacher cannot read unrelated class');

-- Inactive membership immediately loses both table and RPC access.
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000008',true);
select stage4_test.assert_true((select count(*)=0 from public.user_wird_instances), 'inactive user has no Stage 4 table access');
select stage4_test.assert_true((select count(*)=0 from public.list_todays_wirds()), 'inactive user has no today items');

-- Future, expired, cancelled and inactive hierarchy items do not appear today.
reset role;
insert into public.wirds(id,organization_id,dhikr_id,title,target_count,start_at,end_at,status,created_by) values
 ('60000000-0000-0000-0000-000000000001','10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Future',10,now()+interval '1 day',now()+interval '2 days','active','40000000-0000-0000-0000-000000000001'),
 ('60000000-0000-0000-0000-000000000002','10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Expired',10,now()-interval '2 days',now()-interval '1 day','ended','40000000-0000-0000-0000-000000000001'),
 ('60000000-0000-0000-0000-000000000003','10000000-0000-0000-0000-000000000001',(select id from created_ids where kind='dhikr_a'),'Cancelled',10,now()-interval '1 hour',now()+interval '1 day','cancelled','40000000-0000-0000-0000-000000000001');
insert into public.wird_assignments(id,wird_id,organization_id,scope_type,branch_id,user_id,created_by) values
 ('70000000-0000-0000-0000-000000000001','60000000-0000-0000-0000-000000000001','10000000-0000-0000-0000-000000000001','user','20000000-0000-0000-0000-000000000001','40000000-0000-0000-0000-000000000005','40000000-0000-0000-0000-000000000001'),
 ('70000000-0000-0000-0000-000000000002','60000000-0000-0000-0000-000000000002','10000000-0000-0000-0000-000000000001','user','20000000-0000-0000-0000-000000000001','40000000-0000-0000-0000-000000000005','40000000-0000-0000-0000-000000000001'),
 ('70000000-0000-0000-0000-000000000003','60000000-0000-0000-0000-000000000003','10000000-0000-0000-0000-000000000001','user','20000000-0000-0000-0000-000000000001','40000000-0000-0000-0000-000000000005','40000000-0000-0000-0000-000000000001');
select app_private.materialize_wird_assignment('70000000-0000-0000-0000-000000000001');
select app_private.materialize_wird_assignment('70000000-0000-0000-0000-000000000002');
select app_private.materialize_wird_assignment('70000000-0000-0000-0000-000000000003');
set local role authenticated;
select set_config('request.jwt.claim.sub','40000000-0000-0000-0000-000000000005',true);
select stage4_test.assert_true((select count(*)=1 from public.list_todays_wirds()), 'future expired and cancelled wirds stay out of today');

rollback;
select 'STAGE_4_SECURITY_TESTS_PASS' as result;
