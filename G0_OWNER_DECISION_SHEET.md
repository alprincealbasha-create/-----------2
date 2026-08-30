# G0 Owner Decision Sheet — G0-OD-01

الحالة: **HISTORICAL ADJUDICATION SHEET — SUPERSEDED BY G0-OD-02/G0-OD-03**  
تحفظ الأسئلة والتوصيات قبل القرار. لا تستخدم الخانات الفارغة أو أوصاف التعارض أدناه بوصفها حالة حالية؛ راجع `OWNER_DECISION_REGISTER.md`.

## OD-001 — تعريف MVP

Decision required: هل يعتمد MVP المؤسسي وحدوده في `MVP_SCOPE_BASELINE.md`؟

Recommended owner decision: APPROVE RECOMMENDATION — اعتماد MVP المؤسسي، وتأجيل الحملات والإشعارات وQR وiOS والتصدير، وإخراج القرآن الشخصي وERP من النطاق.

Rationale:
هذا القرار مطلوب قبل إغلاق G0 لأنه يحدد المنتج والكيانات ومسارات القبول ويمنع توسيعًا يغير كل البوابات. البدائل هي توسيع MVP مع مدة وبوابات إضافية، أو تغيير هدف المنتج بالكامل.

If approved: يصبح المسار المؤسسي في `MVP_SCOPE_BASELINE.md` مصدر النطاق وتزال المتطلبات الشخصية والمتعارضة من الوثائق المصدرية.

If rejected: يلزم تعريف بديل كامل للنطاق وإعادة تقييم النموذج المنطقي والبوابات والمدة والقبول قبل G1.

Affected documents: `MVP_SCOPE_BASELINE.md`, `PRODUCT_REQUIREMENTS.md`, `README.md`, `AGENTS.md`, `ARCHITECTURE.md`, `DATABASE_SCHEMA.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G0–G12، وبصورة مباشرة G1 وG5–G10.

Recommendation status:
CONSISTENT

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-002 — الأدوار والنطاق

Decision required: هل تعتمد الأدوار الستة ومصفوفة `ROLE_AND_SCOPE_MODEL.md`، وبخاصة معنى `admin` الفرعي؟

Recommended owner decision: RETURN FOR REVISION — يبقى الخيار المقترح هو الأدوار الستة و`admin` الفرعي وإدارة المنصة المنفصلة، لكن يجب أولًا تصحيح صلاحية إدارة `branch_manager` داخل المصفوفة.

Rationale:
الأدوار والنطاق لازمان قبل قيود G2 ومصادقة G3 وCRUD G4. البدائل هي دمج `admin` مع `branch_manager` أو تعديل صلاحيات بعينها. يوجد تعارض داخلي: خلية «إدارة المستخدمين» تمنح `branch_manager` إدارة الفرع عدا organization admin، بينما قسم Provisioning يقصر تغيير `branch_manager` على `organization_admin`.

If approved: بعد المصالحة تصبح القيم الست ومصفوفة CRUD/RLS مرجعًا واحدًا، ويظل platform administration خارج tenancy العادي.

If rejected: يجب اختيار قائمة أدوار ومصفوفة بديلة كاملة؛ أي دمج يغير فصل الواجبات واختبارات G2–G4.

Affected documents: `ROLE_AND_SCOPE_MODEL.md`, `MVP_SCOPE_BASELINE.md`, `LOGICAL_DATA_MODEL.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `README.md`, `AGENTS.md`.

Affected gates: G2, G3, G4, G5, G8, G10, G11.

Recommendation status:
INCONSISTENT

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-003 — الهوية والنموذج المنطقي

Decision required: هل كل مستخدم قابل للدخول له `profiles` مرتبط بـAuth، وكل حساب في مؤسسة واحدة، و`students.profile_id` إلزامي 1:1؟

Recommended owner decision: APPROVE RECOMMENDATION — اعتماد `auth.users ↔ profiles` وهوية مؤسسة واحدة، وكل `user_id → profiles`، دون جدول teachers مستقل.

Rationale:
يلزم أصل هوية واحد لفرض FK وRLS ومنع polymorphic user references. البدائل هي عضوية متعددة المؤسسات، أو هوية طالب مستقلة، أو جدول teachers؛ وكل منها يعيد تشكيل المخطط وسياسات التفويض.

If approved: يحسم الفرق بين user/profile/student وتصنف `organization_members` و`branch_users` legacy، ويمكن بناء G2/G3 على مرجع موحد.

If rejected: يلزم نموذج عضوية/هوية بديل ومصفوفة RLS جديدة وخريطة انتقال قبل أي schema work.

Affected documents: `LOGICAL_DATA_MODEL.md`, `ROLE_AND_SCOPE_MODEL.md`, `STUDENT_AUTH_POLICY.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `PRODUCT_REQUIREMENTS.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G2–G7, G9–G11.

Recommendation status:
CONSISTENT

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-004 — سياسة دخول الطالب وخصوصيته

Decision required: هل تعتمد `organization_code + student_code + 6-digit PIN`، 5 محاولات، قفل 15 دقيقة، وQR بعد MVP؟

Recommended owner decision: APPROVE RECOMMENDATION — مع تفسير «المسح/العزل» بأنه يمنع الحساب التالي من قراءة البيانات دون حذف تقدم معلق صالح.

Rationale:
طريقة تعريف الطالب وحدود PIN وQR مطلوبة قبل G3 حتى تنتج جلسة موثوقة لـRLS. البدائل هي بريد/كلمة مرور، أو QR+PIN داخل MVP، أو سياسة قفل مختلفة. **CANDIDATE FOR DEFERRAL جزئيًا:** معاملات hash والتنفيذ مؤجلة أصلًا؛ يمكن تأجيل الأرقام التشغيلية 5/15 إلى G3 فقط إذا أبقى المالك مبدأ rate limit والقفل ثابتًا.

If approved: يعتمد معرف الطالب داخل المؤسسة وسياسة lockout وshared-device isolation، مع تأجيل التنفيذ الأمني التفصيلي إلى G3.

If rejected: يلزم بديل موثوق يربط الطالب بـ`auth.uid()` ويعيد تقييم البيانات المطلوبة وRLS وتجربة الجهاز المشترك.

Affected documents: `STUDENT_AUTH_POLICY.md`, `ROLE_AND_SCOPE_MODEL.md`, `LOGICAL_DATA_MODEL.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G2, G3, G6, G7, G11, G12.

Recommendation status:
CONSISTENT WITH CONDITION

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-005 — الورد والنطاق والتكليف الفردي

Decision required: هل تعتمد السلسلة `wirds → wird_assignments → user_wird_instances → user_wird_progress` ودلالة intersection داخل صف/union بين الصفوف؟

Recommended owner decision: APPROVE RECOMMENDATION — مع اعتماد `role` مرشحًا/اختصارًا منضبطًا، وليس قائمة IDs أو scope متعارضًا، واعتماد materialization عند النشر مع dedupe.

Rationale:
السلسلة ودلالة الجمهور تمنع مصادر تقدم مزدوجة وتكليف مستخدمين خطأ. البدائل هي الأنواع المتبادلة فقط، التي لا تعبّر «أطفال دمشق»، أو expression model عام زائد التعقيد. الشرط: يجب توحيد وصف `role scope` في MVP baseline مع دلالته كمرشح في logical model، وتثبيت سياسة الوافدين بعد النشر.

If approved: تتحدد مصادر الحقيقة والفواصل بين تعريف الورد والجمهور والنسخة الفردية والتقدم، ويمكن تصميم G2/G5 بلا إعادة بناء.

If rejected: يلزم نموذج audience بديل يعرّف union/intersection والتاريخ وإزالة التكرار ويفرض tenant قبل G2/G5.

Affected documents: `LOGICAL_DATA_MODEL.md`, `MVP_SCOPE_BASELINE.md`, `ROLE_AND_SCOPE_MODEL.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G2, G5, G6, G7, G8, G10.

Recommendation status:
CONSISTENT WITH CONDITION

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-006 — حوكمة الأذكار

Decision required: هل مكتبة MVP لكل مؤسسة ومسارها draft→in_review→approved مع مصدر ومراجع بشري؟

Recommended owner decision: APPROVE RECOMMENDATION — مكتبة مؤسسية، مراجعة بشرية ومصدر إلزاميان، وتعديل المحتوى المعتمد يعيده للمراجعة مع إبقاء snapshots التاريخية.

Rationale:
الملكية ومسار الاعتماد يحددان tenant وRLS ومن يملك النشر ويمنعان نصًا دينيًا غير موثق. البدائل مكتبة منصة عامة تحتاج حوكمة منصة، أو محتوى يكتبه المستخدم وهو خارج MVP.

If approved: يمكن لـG2/G5 تثبيت ownership وlifecycle ومنع استخدام غير approved دون كيان platform إضافي.

If rejected: يجب تحديد مالك بديل للمحتوى، مراجعته وصلاحياته وتصحيحه التاريخي قبل schema/feature work.

Affected documents: `MVP_SCOPE_BASELINE.md`, `LOGICAL_DATA_MODEL.md`, `ROLE_AND_SCOPE_MODEL.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `README.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G2, G5, G8, G10, G11.

Recommendation status:
CONSISTENT

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-007 — المنطقة الزمنية واليوم

Decision required: هل timezone المؤسسة IANA هو المرجع ويبدأ بـ`Asia/Damascus`، ويشتق اليوم خادميًا؟

Recommended owner decision: APPROVE RECOMMENDATION — منطقة IANA على المؤسسة، `Asia/Damascus` قيمة البداية، واشتقاق اليوم من وقت الخادم والمنطقة المحفوظة.

Rationale:
مستوى ملكية المنطقة وقاعدة اليوم يؤثران في التواريخ والاستمرارية وصلاحية الورد والتقارير. البدائل timezone لكل فرع، الذي يزيد تعقيد الانتقال، أو جهاز المستخدم، وهو قابل للتلاعب.

If approved: تتوحد `progress_date` والمدة والمكافآت والتقارير، وتؤجل التفاصيل الفنية فقط إلى G2/G7.

If rejected: يجب اختيار مصدر يوم بديل وتحديد أثره على الفروع والتاريخ والأجهزة قبل G2.

Affected documents: `LOGICAL_DATA_MODEL.md`, `OFFLINE_SYNC_CONTRACT.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G2, G5, G7, G8, G9, G10.

Recommendation status:
CONSISTENT

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-008 — عقد المزامنة والأحداث المتأخرة

Decision required: هل يعتمد `OFFLINE_SYNC_CONTRACT.md`، بما فيه batching/idempotency وتعدد الأجهزة ونافذة تسليم 72 ساعة مقترحة؟

Recommended owner decision: SELECT ALTERNATIVE — اعتماد invariants والعقد كاملًا الآن، وتأجيل الرقم الدقيق لنافذة السماح إلى G7 مع اشتراط سياسة حتمية واختبار للأحداث المتأخرة قبل خروج G7.

Rationale:
البنية acknowledged+pending والـbatch UUID وتعدد الأجهزة ضرورية لمنع إعادة بناء G6/G7. أما مدة 72 ساعة فهي سياسة تشغيلية لا تغير النموذج إذا ظل وجود نافذة محددة ثابتًا. **CANDIDATE FOR DEFERRAL جزئيًا:** مدة 72 ساعة فقط؛ لا يؤجل مبدأ النافذة ولا سلوك عدم الفقد.

If approved: يتجمد عقد السلامة وعدم التكرار، وتحدد مدة النافذة ودليل «أنشئ قبل النهاية» في G7 قبل التنفيذ النهائي.

If rejected: يلزم عقد بديل يفسر فقد الرد والجهازين والأحداث المتأخرة والمكافآت الذرية؛ رفض batching يعارض AGENTS وMVP offline-first.

Affected documents: `OFFLINE_SYNC_CONTRACT.md`, `LOGICAL_DATA_MODEL.md`, `MVP_SCOPE_BASELINE.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `MVP_ACCEPTANCE.md`, `AGENTS.md`.

Affected gates: G2, G5, G6, G7, G8, G9, G11, G12.

Recommendation status:
CONSISTENT WITH CONDITION

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-009 — النقاط والأوسمة

Decision required: هل تعتمد قواعد +10/+10/+10/+30/+100، ledger مصدر الحقيقة، ووسام واحد لكل مستخدم/تعريف؟

Recommended owner decision: APPROVE RECOMMENDATION — ledger ومفاتيح الاستحقاق والتفرد إلزامية، والقيم المذكورة هي baseline الأولي القابل للتعديل من قاعدة البيانات.

Rationale:
مصدر الحقيقة وعدم التكرار ضروريان قبل progress/reward design. البدائل +1 أو قيم أخرى، أو أوسمة عالمية. **CANDIDATE FOR DEFERRAL جزئيًا:** القيم الرقمية وحدها يمكن اعتمادها في G9 دون rework لأن القواعد data-driven؛ لا يمكن تأجيل ledger أو rule types أو uniqueness.

If approved: يزال تعارض +1، وتصبح الملخصات مشتقة والجوائز التاريخية ثابتة، وتعرف اختبارات G9 القيم الأولية.

If rejected: يجب تحديد قيم/ملكية بديلة؛ رفض ledger أو uniqueness يعيد تصميم المزامنة والمكافآت ولا يجوز تأجيله.

Affected documents: `LOGICAL_DATA_MODEL.md`, `MVP_SCOPE_BASELINE.md`, `OFFLINE_SYNC_CONTRACT.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `README.md`.

Affected gates: G2, G7, G9, G10, G11.

Recommendation status:
CONSISTENT WITH CONDITION

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-010 — lifecycle وتقليل البيانات والاحتفاظ

Decision required: هل تعتمد active/suspended/archived، الأرشفة بدل الحذف التاريخي، والحد الأدنى لبيانات الطفل دون father_name/gender/DOB افتراضيًا؟

Recommended owner decision: APPROVE RECOMMENDATION — مع السماح بحالات domain إضافية موثقة مثل `invited` للهوية وdraft/approved للمحتوى، وتأجيل مدد الاحتفاظ الرقمية إلى G11 قبل الإنتاج.

Rationale:
مبدأ lifecycle والحد الأدنى للبيانات يمنع schema وإجراءات حذف خطرة. البدائل هي حقول إضافية ذات غرض ومدة، أو hard delete منسق بعد سياسة قانونية. الشرط: `active/suspended/archived` ليست قائمة موحدة لكل الكيانات؛ Role model يضيف `invited` وLogical model يحدد حالات خاصة. **CANDIDATE FOR DEFERRAL جزئيًا:** مدد الاحتفاظ الرقمية، لا فئات البيانات أو الأرشفة أو تقليل البيانات.

If approved: تثبت حالات الأساس وعدم cascade التاريخي، ولا تجمع حقول الطفل الإضافية بلا قرار غرض واحتفاظ.

If rejected: يلزم lifecycle كامل لكل كيان وسياسة حذف/خصوصية بديلة قبل G2، وإلا قد تفقد السجلات أو تجمع بيانات زائدة.

Affected documents: `LOGICAL_DATA_MODEL.md`, `ROLE_AND_SCOPE_MODEL.md`, `STUDENT_AUTH_POLICY.md`, `MVP_SCOPE_BASELINE.md`, `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`.

Affected gates: G2, G3, G4, G5, G7, G9, G10, G11.

Recommendation status:
CONSISTENT WITH CONDITION

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-011 — منصة MVP

Decision required: هل Android first وAPK موقع في G12، مع iOS وPlay Store بعد MVP؟

Recommended owner decision: APPROVE RECOMMENDATION — Android first، APK إصدار موقع في G12، وiOS وPlay Store بعد MVP.

Rationale:
المنصة تؤثر في إعداد G1 وتعريف إصدار G12 والتوقيع والاختبار. البدائل Android+iOS، أو Play Store ضمن MVP، أو APK غير موقع؛ وكلها تغير النطاق أو قابلية التسليم.

If approved: تتوحد وثائق المنصة ويصبح جهاز Android حقيقي والتثبيت والترقية دليل G12.

If rejected: يجب تعديل platform baseline وGate artifacts وتخصيص اختبارات وتوقيع ونشر للمنصات المختارة قبل G1.

Affected documents: `PLATFORM_BASELINE.md`, `MVP_SCOPE_BASELINE.md`, `GATE_ACCEPTANCE_MATRIX.md`, `CODEX_PLAN.md`, `PRODUCT_REQUIREMENTS.md`, `README.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G1, G3, G6, G11, G12.

Recommendation status:
CONSISTENT

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-012 — استراتيجية الانتقال

Decision required: هل يبدأ G2 بمخطط نظيف في مشروع تطوير/اختبار جديد مع إبقاء prototype مرجعًا، على أساس عدم وجود بيانات إنتاج؟

Recommended owner decision: APPROVE RECOMMENDATION only if the owner confirms there is no production data requiring preservation; otherwise SELECT ALTERNATIVE — migration متدرج قابل للعكس.

Rationale:
لا يجوز لـG1/G2 حذف بيانات أو توريث مصادر حقيقة متنافسة. البديل هو migration بخريطة row-level وrollback إذا توجد بيانات حقيقية. الاتساق مشروط بصحة فرضية «لا توجد بيانات إنتاج» التي لا يستطيع Codex تقريرها.

If approved: يستخدم G2 مشروع تطوير/اختبار نظيفًا ويبقي prototype مرجعًا حتى إثبات التكافؤ، دون اعتبار الجداول القديمة canonical.

If rejected: يجب إعداد خطة migration قابلة للعكس وجرد بيانات ومطابقة وتحقق قبل G2.

Affected documents: `LOGICAL_DATA_MODEL.md`, `CODEX_PLAN.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `README.md`, `MVP_ACCEPTANCE.md`.

Affected gates: G0, G1, G2، وبشكل غير مباشر G3–G12.

Recommendation status:
CONSISTENT WITH CONDITION

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## OD-013 — قبول عقود البوابات

Decision required: هل يعتمد `GATE_ACCEPTANCE_MATRIX.md` دون تغيير تسلسل G0–G12؟

Recommended owner decision: RETURN FOR REVISION — صحح عدد آثار G0 من «التسعة» إلى «الأحد عشر» وراجع الإحالات، ثم اعتمد المصفوفة دون تغيير التسلسل.

Rationale:
معيار خروج G0 في `CODEX_PLAN.md` يتطلب قبول G1–G12 قابلًا للقياس. البدائل هي تعديل معيار محدد، أو اقتراح تغيير تسلسل بسبب هيكلي. المصفوفة متسقة في التسلسل والقياس، لكنها غير متسقة مع `G0_CLOSURE_PACKAGE.md`: قسم G0 يقول «ملفات G0-GC-01 التسعة» بينما الحزمة تسجل أحد عشر ملفًا.

If approved: بعد التصحيح تصبح prerequisites/artifacts/evidence/approval مرجعًا قابلًا للتحقق لكل Gate.

If rejected: يلزم matrix بديلة مكتملة؛ البقاء على عبارات «feature completed» لا يحقق خروج G0.

Affected documents: `GATE_ACCEPTANCE_MATRIX.md`, `G0_CLOSURE_PACKAGE.md`, `CODEX_PLAN.md`, `AGENTS.md`, `MVP_ACCEPTANCE.md`, `DOCUMENT_AUTHORITY_MAP.md`.

Affected gates: G0–G12.

Recommendation status:
INCONSISTENT

Owner decision:
[ ] APPROVE RECOMMENDATION
[ ] SELECT ALTERNATIVE
[ ] DEFER
[ ] RETURN FOR REVISION

Owner note:

---

## Adjudication guard

لا يطبق اختيار بوضع علامة في هذه النسخة تلقائيًا. بعد أن يصدر المالك قراراته صراحة، تنفذ مهمة حوكمة منفصلة لتسجيلها ومصالحة الوثائق. حتى ذلك الوقت: `G0 = OPEN`, `G1 = NOT OPENED`, `OWNER DECISION = PENDING`.
