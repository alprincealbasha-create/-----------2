# Document Authority Map — Rawdat Wird

الحالة: **OWNER-APPROVED G0 AUTHORITY BASELINE — G0-OD-03**  
النطاق: اتساق `CODEX_PLAN.md`, `AGENTS.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `README.md`, `ARCHITECTURE.md`, `MVP_ACCEPTANCE.md` ووثائق G0 الجديدة.

## 1. ترتيب السلطة المقترح

1. **قرارات المالك المسجلة صراحة** في `OWNER_DECISION_REGISTER.md` أو قرار تغيير لاحق موقع/مؤرخ.
2. **`CODEX_PLAN.md` وحالة Gate**: ما يجوز تنفيذه وتسلسل G0–G12.
3. **`PRODUCT_REQUIREMENTS.md`**: الهدف، نطاق المنتج، الرحلات، والقواعد القابلة للقبول.
4. **الخطوط الأساسية المعتمدة**: `MVP_SCOPE_BASELINE.md`, `ROLE_AND_SCOPE_MODEL.md`, `STUDENT_AUTH_POLICY.md`, `LOGICAL_DATA_MODEL.md`, `OFFLINE_SYNC_CONTRACT.md`, `PLATFORM_BASELINE.md`, `GATE_ACCEPTANCE_MATRIX.md`، ثم `DATABASE_SCHEMA.md` و`ARCHITECTURE.md` بعد مواءمتهما.
5. **`AGENTS.md`**: قواعد تنفيذ Codex/المساهمة والسلامة؛ لا يعرّف منتجًا منافسًا لقرار المالك أو PRD المعتمد.
6. **`MVP_ACCEPTANCE.md`**: سيناريو الإثبات الحي؛ يجب أن يشتق من PRD والخطوط الأساسية ولا يغيرها.
7. **`README.md`**: إرشاد وصفي وتشغيلي فقط؛ لا يثبت اكتمال Gate ولا يتقدم على وثيقة قرار.
8. **الكود والترحيلات الحالية**: prototype/evidence فقط حتى Gate المناسب؛ لا تنشئ متطلبًا لمجرد وجودها.

عند تعارض وثيقتين في الطبقة نفسها، يقدم القرار الأحدث الذي يحمل معرفًا وتاريخًا وموافقة مالك. إن لم يوجد، يتوقف العمل ويسجل التعارض بدل اختيار ملائم للتنفيذ.

## 2. سلطة وثائق G0-GC-01 بعد قرارات المالك

- اعتمد المالك OD-001..OD-013؛ أصبحت baselines مرجعًا ملزمًا وفق الترتيب أعلاه.
- أضيفت إشعارات سلطة صريحة إلى الوثائق المصدرية المختلطة لتصنيف نصوص prototype المتعارضة على أنها تاريخية/متجاوزة، دون تحويلها إلى تنفيذ معتمد.
- أصدر المالك `GD-G0-FINAL`: G0 معتمدة/مغلقة/مجمدة، وG1 مفتوحة، وG2–G12 غير مفتوحة.
- يظل قيد OD-012 نافذًا: غياب حالة الإنتاج `NOT VERIFIED` وأي انتقال هدّام ممنوع حتى تحقق لاحق وchange control.
- `G0_BLOCKER_REGISTER.md` سجل تتبع لا وثيقة تصميم.
- `OWNER_DECISION_REGISTER.md` هو سجل القرار الأعلى داخل الحزمة بعد توقيع المالك.
- `G0_CLOSURE_PACKAGE.md` ملخص حالة، لا يستبدل تفاصيل baselines.

## 3. التعارضات التاريخية ومصدر الحسم

يسجل الجدول أدناه التعارضات التي اكتشفت قبل قرارات المالك. حسمت سلطتها بقرارات OD-001–OD-013 والخطوط المعتمدة وإشعارات prototype في الوثائق المصدرية. عبارات «إعادة/استبدال/إزالة» تعني أن النص القديم غير نافذ عند التعارض؛ لا تجيز حذف بيانات أو تنفيذًا هدّامًا، ولا تجعل التفاصيل التاريخية مصدرًا منافسًا.

| الموضوع | النص الحالي المتعارض | المرجع المقترح بعد الاعتماد | الإجراء المطلوب قبل إغلاق G0 |
|---|---|---|---|
| هدف المنتج | PRD/README: خطط قرآن وذكر شخصي؛ AGENTS: مؤسسي | MVP Scope | إعادة كتابة الهدف والقبول وإزالة الشخصي/الضيف |
| حالة المشروع | README: مراحل مكتملة؛ CODEX_PLAN: G0/prototype | CODEX_PLAN | وسم التنفيذ Prototype وعدم ادعاء Gate completion |
| المنصات | PRD/README Android+iOS؛ G12 Android | Platform Baseline | توحيد MVP Android first |
| الأدوار | member/admin وowner/admin وأدوار متعددة | Role/Scope Model | استبدال القيم القديمة والمصفوفة |
| الهوية | organization_members/branch_users مقابل profiles/students | Logical Data Model | اختيار canonical وتصنيف legacy |
| الطالب | profile اختياري/PIN/QR مبهم | Student Auth Policy + Logical Model | profile إلزامي ودخول موثوق وQR post-MVP |
| الورد | managed_wirds/wird_programs/wirds | Logical Data Model | توحيد lifecycle والسلسلة |
| النطاق | multiple_branches/type-exclusive | Logical Data Model | صفوف ذرية ودلالة role filter/materialization |
| المزامنة | operation لكل tap مقابل no request per tap | Offline Sync Contract | استبدال وصف per-tap network بعقد batch delta |
| النقاط | +1 مقابل +10؛ total مقابل ledger | Logical Data Model/MVP Scope | حذف القاعدة القديمة وتثبيت ledger |
| الأوسمة | عامة/مؤسسية وتفرد مفتوح | Logical Data Model | مؤسسية وunique grant |
| المحتوى | user-authored مقابل approved catalog | MVP Scope/Logical Model | إزالة العداد الشخصي وتثبيت review flow |
| الوقت | device timezone/Asia-Damascus/DATE/TIMESTAMPTZ | Logical Data Model | timezone مؤسسة IANA واشتقاق خادمي |
| الحملات/الإشعارات | معروضة كمنجزة أو MVP بلا Gate | MVP Scope | وسم POST-MVP وإزالتها من قبول G0–G12 |
| القبول | MVP_ACCEPTANCE يعتمد member/branch_users/managed_wird | baselines + Gate Matrix | تحديث الحسابات والكيانات والـbatch evidence |
| gate evidence | CODEX_PLAN بمعايير عامة | Gate Acceptance Matrix | الإشارة للمصفوفة أو دمجها بعد الموافقة |

## 4. المتطلبات المكررة

- Offline first/idempotency مكرران في PRD وAGENTS وArchitecture/Schema؛ يصبح PRD مصدر السلوك و`OFFLINE_SYNC_CONTRACT.md` تفسيره المعماري، بينما AGENTS قاعدة تنفيذ مختصرة.
- hierarchy/RLS مكرران؛ يصبح Role/Scope + Logical Model المرجع التفصيلي، وAGENTS guardrail.
- سيناريو 20→50 وMVP end-to-end مكرران؛ يحفظ النص المعياري مرة في Acceptance ويشار إليه من البقية.
- قائمة الحزم مكررة في README/Architecture؛ يعتمد G1 manifest الفعلي بعد موافقته، وREADME يصف فقط.

## 5. نصوص قديمة لا يجوز تنفيذها قبل التصحيح

- `member/admin` والدور الافتراضي العام.
- `branch_users.profile_id` و`managed_wird` كمسار قبول canonical.
- إنشاء خطط قرآن أو ذكر شخصي أو وضع ضيف أو تذكيرات ضمن MVP.
- طلب/عملية شبكية لكل ضغطة.
- دعم iOS كمعيار إصدار أول.
- الحملات كميزة مكتملة أو لازمة قبل G12.
- تعليمات README التي تطلب تطبيق migrations الحالية بوصفها baseline معتمدًا.

## 6. آلية ضبط الاتساق

1. يسجل أي تغيير منتج/بنية في Owner Decision برقم.
2. يذكر القرار الوثائق المتأثرة.
3. تحدث الوثائق الأعلى أولًا، ثم schema/architecture/acceptance، ثم README/AGENTS إن لزم.
4. ينفذ فحص مصطلحات canonical (`organization_admin`, `user_wird_instances`, إلخ) قبل إغلاق G0 وكل Gate.
5. نص prototype الذي يحمل إشعارًا واضحًا بأنه متجاوز لا يخلق سلطة منافسة؛ لا يزال تحديثه التفصيلي مسموحًا فقط في Gate ذي الصلة ودون تغيير قرار G0.
