# Logical Data Model — Rawdat Wird MVP

الحالة: **OWNER-APPROVED LOGICAL BASELINE — OD-012 SAFETY CONSTRAINT ACTIVE**  
هذه وثيقة منطقية وليست SQL أو ترحيلًا. الأسماء والقواعد أدناه تصبح مرجع G2 بعد اعتماد المالك وتحديث `DATABASE_SCHEMA.md`.

## 1. قرارات الهوية والملكية

1. `auth.users` هو أصل اعتماد الهوية لدى Supabase.
2. `profiles.id` يساوي هوية Auth ويمثل **مستخدم التطبيق القابل للمصادقة** لجميع الأدوار، بمن فيهم الطالب.
3. `students` يمثل **بيانات الطفل في المجال** وله `profile_id` إلزامي وفريد في MVP؛ لا يوجد طالب قابل للدخول بلا Profile.
4. لا ينشأ جدول `users` موازٍ. كلمة User في المنتج تعني `profiles`، بينما بيانات الطالب الإضافية في `students`.
5. المعلم والموظف والإداري والمدير يمثلون بـ`profiles`; لا جدول `teachers` مستقل في MVP. علاقات المعلم بالصفوف في `teacher_classes`.
6. كل Profile ينتمي إلى مؤسسة واحدة في MVP. `organization_members` و`branch_users` من النموذج الأولي ليسا مصدر حقيقة نهائيًا.
7. كل FK اسمه `user_id` في نموذج MVP يشير إلى `profiles.id`. الحقول الخاصة بالطفل تستخدم `student_id` وتشير إلى `students.id` فقط عند الحاجة لبيانات الطفل.

## 2. قواعد tenant العامة

- كل سجل تشغيلي يحمل `organization_id` صريحًا.
- السجل الفرعي يحمل `branch_id` حيث يلزم العزل/التقرير، مع ضمان تطابقه مع المؤسسة.
- الطالب يحمل دائمًا `organization_id + branch_id + class_id`، وجميعها متطابقة عبر علاقات قابلة للفرض.
- موظف الفرع يحمل `organization_id + branch_id`; مدير المؤسسة يحمل `branch_id = null`.
- تكرار مفاتيح tenant مقصود للأمان والاستعلام، لكنه لا يقبل عدم الاتساق؛ يثبت G2 ذلك بقيود/آلية خادمية.

## 3. الكيانات الأساسية

| الكيان | الغرض والملكية | العلاقات وحقول tenant | قواعد حرجة | النطاق |
|---|---|---|---|---|
| `organizations` | جذر tenant | — | `code` عالمي وفريد بعد التطبيع؛ حالة وtimezone IANA إلزاميان | MVP |
| `branches` | فرع داخل مؤسسة | `organization_id → organizations` | `UNIQUE(organization_id, normalized_code)`؛ الاسم/المدينة ليست هوية أمنية | MVP |
| `classes` | صف داخل فرع | `organization_id`, `branch_id → branches` | المؤسسة تطابق مؤسسة الفرع؛ `UNIQUE(branch_id, normalized_code, academic_year)` | MVP |
| `profiles` | هوية مستخدم التطبيق وRole/Scope | `id → auth.users`; `organization_id`; `branch_id` حسب الدور | مؤسسة واحدة؛ role canonical؛ branch null فقط لـorganization_admin؛ لا تعديل ذاتي للدور | MVP |
| `students` | بيانات الطفل وانتماؤه للصف | `profile_id UNIQUE → profiles`; `organization_id`, `branch_id`, `class_id` | role profile=student؛ الرموز متطابقة tenant؛ `UNIQUE(organization_id, normalized_student_code)` | MVP |
| `teacher_classes` | تفويض المعلم لصفوف | `teacher_id → profiles`; `class_id → classes`; tenant مشتق/متحقق | PK مركب؛ role=teacher؛ الصف داخل فرع المعلم | MVP |
| `dhikr_definitions` | مكتبة ذكر مؤسسية مراجعة | `organization_id`; `created_by/reviewed_by → profiles` | title/display_text/source/status؛ لا يستخدم في ورد منشور إلا approved | MVP |
| `wirds` | تعريف تكليف زمني لذكر | `organization_id`; `dhikr_id`; `created_by` | target >0؛ start<end؛ snapshots للمحتوى/الهدف عند النشر؛ lifecycle مضبوط | MVP |
| `wird_assignments` | تعبير audience مطبع | `wird_id`, `organization_id`، ومحدد branch/class/role/user | صف لكل هدف ذري؛ لا مصفوفة IDs؛ جميع المحددات داخل المؤسسة؛ منع تكرار الصف المنطقي | MVP |
| `user_wird_instances` | تكليف فردي مادي مستقر | `organization_id`, `branch_id`, `user_id → profiles`, `wird_id` | unique للمستخدم/الورد/occurrence؛ snapshot للهدف والنص والتوقيت؛ لا تعيد تغييرات النطاق كتابة التاريخ | MVP |
| `user_wird_progress` | التجميع الخادمي canonical لكل instance | tenant + `user_id`, `user_wird_instance_id` | صف واحد لكل instance؛ count غير سالب ولا يتجاوز الهدف؛ إكمال أحادي الاتجاه إلا تصحيحًا مدققًا | MVP |
| `sync_events` | إيصالات idempotency لدفعات التقدم المقبولة | tenant + user + progress/instance + device | `event_uuid UNIQUE`; delta موجب؛ server timestamps؛ ليس نموذج القراءة الرئيسي | MVP |
| local outbox | مفهوم محلي في Drift للدفعات غير المعترف بها | user/instance/device/event UUID | يحذف فقط بعد acknowledgment؛ معزول حسب الحساب | MVP concept؛ تصميم G6/G7 |
| `point_rules` | قواعد التزام قابلة للتعديل | `organization_id` أو baseline مؤسسي منسوخ | rule key فريد، قيمة/حالة؛ لا تعدل الجوائز التاريخية | MVP |
| `point_awards` | دفتر النقاط ومصدر الحقيقة | tenant + `user_id`; rule; instance/day key | idempotency key فريد لكل استحقاق؛ points snapshot | MVP |
| `badges` | تعريفات الأوسمة | `organization_id`; rule metadata | اسم/نوع/قيمة/حالة؛ النص مراجع | MVP |
| `user_badges` | دفتر منح الأوسمة | tenant + `user_id`, `badge_id` | `UNIQUE(user_id, badge_id)`؛ لا منح مكرر | MVP |
| `audit_logs` | أثر إداري وأمني | `organization_id`, actor, entity | append-only منطقيًا؛ metadata منقحة؛ وصول محدود | MVP supporting |
| `integrity_flags` | علامة غير عقابية | tenant/branch/user/progress | لا تعدل التقدم أو المكافآت؛ مراجعة مدققة | MVP supporting |
| `campaigns`/contributions | هدف جماعي | tenant | لا تنشأ ضمن مخطط MVP | POST-MVP |

## 4. دلالة نطاق التكليف

`multiple_branches` ليس قيمة مخزنة. يمثل بعدة صفوف `wird_assignments` من نوع `branch`.

المقترح لتلبية «أطفال فرع دمشق» دون قوائم غير مطبعة:

- المحدد الأساسي لكل صف هو واحد من `organization`, `branch`, `class`, `user`.
- يجوز `role` كمرشح إضافي مع `organization` أو `branch`، أو تكون قيمة النوع المنطقي `role` اختصارًا لـorganization + role.
- عدة أدوار/فروع تنتج صفوفًا ذرية متعددة؛ الاتحاد بين الصفوف، والتقاطع داخل الصف.
- عند النشر تُحل النطاقات إلى `user_wird_instances` مع إزالة التكرار بمفتاح فريد.
- إضافة مستخدم لاحقًا لا تمنحه وردًا تاريخيًا تلقائيًا إلا إذا نصت سياسة الورد المنشور على materialization دوري؛ المقترح للـMVP: materialize عند النشر فقط، مع زر إداري مدقق لإسناد الوافدين ضمن مدة الورد.

هذا القرار يحتاج قبول المالك لأنه يصحح تعارض «أنواع متبادلة الاستبعاد» مع مثال الدور داخل فرع.

## 5. Lifecycle والوقت

- الحالات الدنيا: الكيانات الإدارية `active/suspended/archived`; تعريف الذكر `draft/in_review/approved/archived`; الورد `draft/scheduled/active/ended/cancelled`؛ instance `assigned/in_progress/completed/expired/cancelled`.
- الحذف من MVP تعطيل/أرشفة، ولا تمسح السجلات التاريخية بتسلسل.
- كل مؤسسة تحمل `timezone` بصيغة IANA، والقيمة المقترحة الأولى `Asia/Damascus`.
- `progress_date` مشتق خادميًا من وقت الخادم ومنطقة المؤسسة، لا من ساعة العميل وحدها.
- `start_at/end_at` لحظات زمنية؛ snapshots تحفظ المنطقة/التاريخ التجاري اللازم لإعادة التقرير تاريخيًا.

## 6. المحتوى الديني والمكافآت

- المكتبة مؤسسية في MVP؛ لا مكتبة عالمية قابلة للتحرير من تطبيق المؤسسة.
- تعريف الذكر يحتاج مرجع مصدر ومراجعًا بشريًا قبل `approved`. تعديل النص المعتمد يعيده للمراجعة ولا يغير snapshots التاريخية.
- `point_awards` و`user_badges` هما مصدرا الحقيقة. أي إجمالي/ملخص مشتق قابل لإعادة البناء.
- أنواع القواعد الأولية تشمل إتمام ورد، وإتمام أوراد اليوم، والاستمرارية المعتمدة. القيم الرقمية النهائية مؤجلة إلى G9؛ لا تعتمد أي قاعدة على الضغطات الخام.

## 7. الانتقال من النموذج الأولي

غياب حالة الإنتاج **NOT VERIFIED**. لذلك يمنع أي clean/destructive rebuild أو reset أو overwrite أو حذف أو افتراض أن الحالة القائمة فارغة. يسمح بإنشاء مشروع/بيئة تطوير أو اختبار جديدة ومعزولة وبيانات اصطناعية فقط عندما لا يمكن أن تمس حالة محتملة authoritative. تبقى ملفات النموذج الأولي مرجعًا، وأي انتقال لحالة قائمة يحتاج جردًا وتحققًا وقرار migration/change-control منفصلًا قابلًا للعكس.

تصنف `organization_members`, `branch_users`, `managed_wirds`, `managed_wird_progress`, `dhikr_sessions`, `daily_items`, و`wird_programs` كـprototype legacy لأغراض التصميم الجديد، لكن لا يحذف أو يعدل أي مثيل قائم منها هدميًا ما دامت authoritative state مجهولة.

## 8. ما يؤجل إلى G2 دون فتح المنطق

أنواع PostgreSQL الدقيقة، أسماء القيود والفهارس، استراتيجية composite FK/trigger، partitioning، وسياسة تنفيذ RLS/RPC. لا يجوز لـG2 تغيير الهوية أو الملكية أو العلاقات أو التفرد أعلاه دون إعادة قرار G0.
