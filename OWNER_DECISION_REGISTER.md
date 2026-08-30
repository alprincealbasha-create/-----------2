# Owner Decision Register — G0-GC-01

الحالة: **القرارات OD-001–OD-013 محسومة؛ G0 معتمدة/مغلقة/مجمدة وG1 مفتوحة بقرار GD-G0-FINAL**  
يظل قيد السلامة في OD-012 فعالًا لأن غياب حالة الإنتاج غير متحقق. G2–G12 غير مفتوحة.

أسطر «السؤال/الموصى/البدائل» تحفظ عرض ما قبل الفصل. عند اختلافها عن «قرار المالك»، يكون قرار المالك وحالته هما المرجع النافذ؛ وبخاصة مدة grace window وقيم النقاط وتفاصيل lockout المؤجلة.

## A. قرارات مطلوبة لإغلاق G0

### OD-001 — تعريف MVP

- **السؤال:** هل يعتمد MVP المؤسسي وحدوده في `MVP_SCOPE_BASELINE.md`؟
- **الموصى:** نعم؛ حملات/إشعارات/QR/iOS/تصدير بعد MVP، والقرآن الشخصي/ERP خارج النطاق.
- **البدائل:** توسيع MVP مع تحديد الميزات والبوابات والمدة؛ أو تغيير هدف المنتج بالكامل.
- **الأثر:** يحسم G0-B001 ويحدد كل artifacts اللاحقة.
- **قرار المالك:** `APPROVE` — Adopt the limited institutional MVP baseline.
- **الحالة:** `OWNER APPROVED — G0-OD-02`.

### OD-002 — الأدوار والنطاق

- **السؤال:** هل تعتمد الأدوار الستة ومصفوفة `ROLE_AND_SCOPE_MODEL.md`، وبخاصة معنى `admin` الفرعي؟
- **الموصى:** اعتمادها كما هي؛ platform administration منفصل.
- **البدائل:** دمج admin مع branch_manager؛ أو تعديل صلاحيات محددة مع توثيقها.
- **الأثر:** يحسم role values وRLS واختبارات G2–G4.
- **قرار المالك:** `APPROVE REVISED` — `branch_manager` belongs to exactly one organization and one branch; may perform approved branch-level management operations only there; may not access, administer, query, or mutate sibling branches or exercise organization-wide authority; teacher/class constraints remain separate; backend/database authorization independently enforces scope and UI visibility is not authorization.
- **الحالة:** `APPROVED REVISED — G0-OD-03`.

### OD-003 — الهوية والنموذج المنطقي

- **السؤال:** هل كل مستخدم قابل للدخول له `profiles` مرتبط بـAuth، وكل حساب في مؤسسة واحدة، و`students.profile_id` إلزامي 1:1؟
- **الموصى:** نعم؛ كل `user_id` يشير إلى profiles ولا جدول teachers مستقل.
- **البدائل:** عضوية متعددة المؤسسات؛ student identity منفصلة؛ teachers table. كل بديل يحتاج إعادة RLS/model.
- **الأثر:** يحسم G0-B003/B006/B015 ويمنع polymorphic FK.
- **قرار المالك:** `APPROVE` — Adopt unified authenticated Profile identity, one organization membership in MVP, and a Student domain record linked 1:1 to the authenticated profile.
- **الحالة:** `OWNER APPROVED — G0-OD-02`.

### OD-004 — سياسة دخول الطالب وخصوصيته

- **السؤال:** هل تعتمد `organization_code + student_code + 6-digit PIN`، 5 محاولات، قفل 15 دقيقة، وQR بعد MVP؟
- **الموصى:** نعم، مع مسح/عزل بيانات الحساب عند logout المشترك.
- **البدائل:** بريد/كلمة مرور؛ QR+PIN في MVP؛ سياسة قفل مختلفة مع تبرير أمني.
- **الأثر:** يحسم G0-B005/B016 ويحدد عقد G3.
- **قرار المالك:** `APPROVE WITH DEFERRED IMPLEMENTATION DETAIL` — Approve `organization_code + student_code + PIN`, organization-scoped student code, shared-device isolation, clearing child-specific local state on logout, and QR not being a standalone factor. Technical lockout implementation details are deferred to G3 without weakening the policy.
- **الحالة:** `OWNER APPROVED — IMPLEMENTATION DETAIL DEFERRED TO G3`.

### OD-005 — الورد والنطاق والتكليف الفردي

- **السؤال:** هل تعتمد السلسلة `wirds → wird_assignments → user_wird_instances → user_wird_progress` ودلالة intersection داخل صف/union بين الصفوف؟
- **الموصى:** نعم؛ عدة الفروع صفوف مستقلة، role مرشح اختياري، وmaterialization عند النشر مع dedupe.
- **البدائل:** أنواع متبادلة فقط؛ أو expression model عام. الأول لا يغطي أطفال فرع، والثاني زائد التعقيد للـMVP.
- **الأثر:** يحسم G0-B006/B008/B009 ويحدد G5–G8.
- **قرار المالك:** `APPROVE` — Adopt the proposed Wird lifecycle, assignment scope model, and materialized user-assignment concept.
- **الحالة:** `OWNER APPROVED — G0-OD-02`.

### OD-006 — حوكمة الأذكار

- **السؤال:** هل مكتبة MVP لكل مؤسسة ومسارها draft→in_review→approved مع مصدر ومراجع بشري؟
- **الموصى:** نعم؛ تعديل approved يعيد المراجعة ويحافظ على snapshots.
- **البدائل:** مكتبة منصة عامة؛ أو محتوى يكتبه المستخدم. تحتاج الأولى platform governance والثانية خارج MVP.
- **الأثر:** يحسم G0-B013 ويحدد G5.
- **قرار المالك:** `APPROVE` — Adopt an organization-managed Dhikr catalog with explicit human review/approval for official content.
- **الحالة:** `OWNER APPROVED — G0-OD-02`.

### OD-007 — المنطقة الزمنية واليوم

- **السؤال:** هل timezone المؤسسة IANA هو المرجع ويبدأ بـ`Asia/Damascus`، ويشتق اليوم خادميًا؟
- **الموصى:** نعم.
- **البدائل:** timezone لكل فرع؛ أو جهاز المستخدم. جهاز المستخدم غير موصى به أمنيًا.
- **الأثر:** يحسم G0-B010 ويؤثر في المدة والاستمرارية والتقارير.
- **قرار المالك:** `APPROVE` — Adopt an organization-level timezone; business days, streaks, and server-side dates use it rather than trusting the device clock.
- **الحالة:** `OWNER APPROVED — G0-OD-02`.

### OD-008 — عقد المزامنة والأحداث المتأخرة

- **السؤال:** هل يعتمد `OFFLINE_SYNC_CONTRACT.md`، بما فيه batching/idempotency وتعدد الأجهزة ونافذة تسليم 72 ساعة مقترحة؟
- **الموصى:** اعتماد العقد و72 ساعة للحدث المؤهل المنشأ قبل نهاية الورد.
- **البدائل:** لا نافذة؛ نافذة أخرى؛ أو قبول بلا حد. يجب اختيار نتيجة حتمية قابلة للتدقيق.
- **الأثر:** يحسم G0-B007 ويحدد قبول G6/G7.
- **قرار المالك:** `APPROVE WITH DEFERRED PARAMETER` — Approve `OFFLINE_SYNC_CONTRACT.md`; defer only the exact grace-window duration to G7. Not deferred: immediate local counter update; persistence across restart; no request per tap; locally persisted pending progress; idempotent synchronization; retries must not double-count; accepted progress must not be silently lost; canonical reconciliation with server state; completion/reward idempotency; recoverable failed synchronization; device time is not sole authority.
- **الحالة:** `OWNER APPROVED — GRACE-WINDOW PARAMETER DEFERRED TO G7`.

### OD-009 — النقاط والأوسمة

- **السؤال:** هل تعتمد قواعد +10/+10/+10/+30/+100، ledger مصدر الحقيقة، ووسام واحد لكل مستخدم/تعريف؟
- **الموصى:** نعم؛ الملخصات مشتقة والأوسمة مؤسسية.
- **البدائل:** +1 أو قيم أخرى؛ أوسمة عالمية. يلزم تحديث PRD/model والقبول.
- **الأثر:** يحسم G0-B011/B012 ويحدد G9.
- **قرار المالك:** `APPROVE WITH DEFERRED VALUES` — Approve an append-only points ledger, unique reward-event protection, completion/consistency-based rewards, and no duplicate grants. Final numerical values are deferred to G9.
- **الحالة:** `OWNER APPROVED — NUMERICAL VALUES DEFERRED TO G9`.

### OD-010 — lifecycle وتقليل البيانات والاحتفاظ

- **السؤال:** هل تعتمد active/suspended/archived، الأرشفة بدل الحذف التاريخي، والحد الأدنى لبيانات الطفل دون father_name/gender/DOB افتراضيًا؟
- **الموصى:** نعم؛ تعتمد فئات الاحتفاظ الآن والمدد التشغيلية قبل G11/الإنتاج.
- **البدائل:** حقول إضافية بغرض ومدة؛ hard delete منسق بعد سياسة قانونية.
- **الأثر:** يحسم G0-B014/B016 ويمنع إعادة تصميم الخصوصية.
- **قرار المالك:** `APPROVE WITH DEFERRED RETENTION PERIODS` — Approve data minimization, lifecycle-aware archival, preservation of required historical entities, and child-data minimization. Exact retention periods are deferred to G11.
- **الحالة:** `OWNER APPROVED — RETENTION PERIODS DEFERRED TO G11`.

### OD-011 — منصة MVP

- **السؤال:** هل Android first وAPK موقع في G12، مع iOS وPlay Store بعد MVP؟
- **الموصى:** نعم.
- **البدائل:** Android+iOS؛ Play Store ضمن MVP؛ APK داخلي غير موقع.
- **الأثر:** يحسم G0-B002 ويحدد G1/G12.
- **قرار المالك:** `APPROVE` — Android First; G12 produces a signed installable APK; iOS release and Play Store publication are POST-MVP unless separately approved, while iOS compatibility is not intentionally blocked.
- **الحالة:** `OWNER APPROVED — G0-OD-02`.

### OD-012 — استراتيجية الانتقال

- **السؤال:** هل يبدأ G2 بمخطط نظيف في مشروع تطوير/اختبار جديد مع إبقاء prototype مرجعًا، على أساس عدم وجود بيانات إنتاج؟
- **الموصى:** نعم، بشرط تأكيد المالك عدم وجود بيانات يجب حفظها.
- **البدائل:** migration متدرج قابل للعكس إذا توجد بيانات حقيقية.
- **الأثر:** يحسم G0-B017؛ اختيار خاطئ قد يفقد بيانات أو يورث نموذجًا متناقضًا.
- **قرار المالك:** `APPROVE WITH SAFETY CONSTRAINT` — Production-state absence remains `NOT VERIFIED`; destructive clean rebuild, deletion, reset, overwrite, or empty-state assumption is prohibited. Non-destructive G1 work and isolated development/test environments with synthetic data remain permissible only when they cannot destroy or overwrite potentially authoritative state.
- **هل توجد بيانات إنتاج يجب حفظها؟** `NOT VERIFIED — unknown state must be treated conservatively`.
- **الحالة:** `APPROVED — SAFETY CONSTRAINT ACTIVE — G0-OD-03`.

### OD-013 — قبول عقود البوابات

- **السؤال:** هل يعتمد `GATE_ACCEPTANCE_MATRIX.md` دون تغيير تسلسل G0–G12؟
- **الموصى:** نعم، وتبقى موافقة المالك مطلوبة للانتقال بين كل بوابتين.
- **البدائل:** تعديل معيار بعينه؛ تغيير التسلسل يحتاج سببًا هيكليًا منفصلًا.
- **الأثر:** يحسم G0-B018 ومعيار خروج G0.
- **قرار المالك:** `APPROVE REVISED` — The authoritative G0-GC-01 artifact count is 11; references use the actual artifact set and no artifact is removed to fit an earlier count.
- **الحالة:** `APPROVED REVISED — G0-OD-03`.

## B. قرارات مؤجلة عمدًا إلى بوابات لاحقة

| Decision ID | السؤال المؤجل | الموعد/البوابة | القيد الثابت الآن | الحالة |
|---|---|---|---|---|
| OD-014 | إصدارات Flutter/Dart والحزم وapplicationId وAndroid min SDK | G1 | Android first ولا حزمة بلا مبرر | `DEFERRED` |
| OD-015 | SQL types، أسماء القيود، composite FK مقابل triggers، والفهارس | G2 | العلاقات والتفرد وtenant model لا تتغير | `DEFERRED` |
| OD-016 | تنفيذ خدمة PIN، hashing parameters، refresh rotation، rate limiter | G3 | سياسة الطالب وحدود الجلسة والقفل ثابتة | `DEFERRED` |
| OD-017 | تفاصيل CRUD UI وmicrocopy والوصول البصري | G4/G5 | الصلاحيات وRTL وWCAG للمسارات الأساسية ثابتة | `DEFERRED` |
| OD-018 | Drift tables، batch size، debounce، retry backoff | G6/G7 | contract وidempotency وعدم الفقد ثابتة | `DEFERRED` |
| OD-019 | حدود مؤشرات النزاهة الرقمية | G7/G11 | العلامة غير عقابية ولا تجمع موقعًا/جهازًا زائدًا | `DEFERRED` |
| OD-020 | فهارس وتحسينات الأداء المبنية على القياس | كل Gate ذات صلة | سلامة العلاقات قبل optimization | `DEFERRED` |
| OD-021 | تخطيط dashboard البصري وصياغة الرسوم | G8 | المقاييس والتصنيف غير السلبي ثابتان | `DEFERRED` |
| OD-022 | القيم المعدلة لقواعد النقاط مستقبلًا | G9 | ledger وقابلية التعديل وعدم retroactive rewrite ثابتة | `DEFERRED` |
| OD-023 | pagination وحدود أحجام التقرير | G10 | التقارير الثلاثة والفلاتر والعزل ثابتة | `DEFERRED` |
| OD-024 | مدد الاحتفاظ الرقمية، backup/restore، مزود monitoring | G11 قبل الإنتاج | الفئات والمسؤولية وتقليل البيانات ثابتة | `DEFERRED` |
| OD-025 | Android device floor، keystore custody، distribution/update channel | G1/G12 | APK موقع واختبار جهاز حقيقي ثابتان | `DEFERRED` |
| OD-026 | حملات، إشعارات، QR، iOS، PDF/Excel، أولياء الأمور | POST-MVP planning | لا artifacts لها داخل MVP | `DEFERRED` |

## شرط إغلاق G0

جميع OD-001..OD-013 لها قرار مالك نهائي، وقد أغلق المالك G0 وفتح G1 بقرار `GD-G0-FINAL`. لا يلزم إثبات غياب الإنتاج لإغلاق G0 ما دام قيد OD-012 الهدام محفوظًا؛ ولا يجوز إزالة هذا القيد دون تحقق وchange control لاحق. لا يفتح هذا السجل G2 أو أي بوابة لاحقة.
