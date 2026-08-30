# Gate Acceptance Matrix — Rawdat Wird G0–G12

الحالة: **OWNER APPROVED REVISED — OD-013/G0-OD-03**  
التسلسل محفوظ كما هو: `G0 → G1 → … → G12`. لا يفتح Gate إلا بعد اكتمال سابقه وموافقة بشرية مسجلة.

## قواعد عامة لكل البوابات

1. لا تكفي عبارة «تمت الميزة»؛ يلزم artifact ودليل تحقق محفوظ.
2. الفشل الأمني أو فقد التقدم يعيد العمل إلى البوابة صاحبة القرار.
3. `flutter analyze` و`flutter test` مطلوبان لكل بوابة برمجية من G1 فصاعدًا، إضافة إلى الاختبارات الخاصة.
4. لا يستخدم `service_role` في Flutter أو اختبارات عميل التطبيق.
5. لا تغير بوابة قرارًا frozen من G0 خفية؛ تسجل change decision ويعاد فتح G0 عند أثر بنيوي.
6. المالك، لا Codex، يوافق على الانتقال إلى البوابة التالية.

## G0 — Planning

- **الهدف:** توحيد الهدف والنطاق والهوية والأدوار والمنطق الأمني والبياني وعقود البوابات.
- **المتطلبات السابقة:** وثائق المنتج والمخطط والنموذج الأولي متاحة؛ حالة Gate معلنة G0.
- **المسموح:** قراءة ومقارنة وكتابة قرارات وخطوط أساس وخطة rebuild/migration ومعايير قبول.
- **الممنوع:** كود Flutter، حزم، SQL/migrations، اختبارات تنفيذ، إصدار، وفتح G1.
- **الآثار المطلوبة:** ملفات G0-GC-01 الأحد عشر، قرارات OD-001..OD-013، وثائق مصدرية متسقة.
- **التحقق:** كل مانع G0-B له قرار وأثر؛ لا تعارض سلطة مفتوح؛ checklist `G0_REVIEW.md J` مكتمل.
- **الخروج القابل للقياس:** جميع قرارات G0 مسجلة APPROVED/approved-with-edit؛ final logical model وrole/RLS matrix وscope وsync/platform/gates معتمدة؛ استراتيجية transition معتمدة؛ لا تناقض حرج.
- **الموافقة البشرية:** المالك يكتب `G0 CLOSED — G1 AUTHORIZED` صراحة.
- **التالي:** G1 فقط.

## G1 — Project Foundation

- **الهدف:** أساس Flutter/Android والحزم والبنية والإعدادات بلا ميزة منتج.
- **المتطلبات السابقة:** G0 مغلق؛ OD-014/OD-025 اللازمة للبدء محسومة؛ جرد prototype محفوظ؛ قيد OD-012 الهدام فعال.
- **المسموح:** تهيئة/مواءمة المشروع، الحزم المعتمدة، environments غير السرية، هيكل عملي أدنى، smoke test، وبيئات تطوير/اختبار معزولة لا تمس حالة محتملة authoritative.
- **الممنوع:** جداول/مصادقة/CRUD/عداد أو خصائص من G2+؛ أسرار؛ refactor prototype غير مرتبط؛ حذف/reset/overwrite لأي حالة قائمة أو مجهولة.
- **الآثار المطلوبة:** manifest dependency rationale، config template بلا أسرار، structure note، build/test instructions.
- **التحقق:** التطبيق الأساسي يبني ويعمل على Android emulator/device؛ `flutter analyze` و`flutter test` ينجحان؛ secret scan نظيف.
- **الخروج:** نتيجة أو سجل أوامر ناجح، لا warnings مانعة، package lock committed، ولا feature future gate.
- **الموافقة البشرية:** اعتماد foundation وفتح G2.
- **التالي:** G2.

## G2 — Database Foundation

- **الهدف:** تنفيذ hierarchy والهوية المنطقية وعلاقات tenant عبر migrations حتمية وRLS أساسي.
- **المتطلبات السابقة:** G1 مغلق؛ `LOGICAL_DATA_MODEL.md` وOD-003/005/007/010/012 معتمدة؛ بيئة اختبار معزولة.
- **المسموح:** migrations/seed آمن/اختبارات DB للـorganizations, branches, classes, profiles, students, teacher_classes والأسس المشتركة.
- **الممنوع:** UI، دخول PIN، counter/sync، جداول POST-MVP، تعديل إنتاج يدوي.
- **الآثار المطلوبة:** migrations قابلة للإعادة، schema diagram، seed fixtures لمؤسستين/فروع متعددة، RLS test suite، rollback/rebuild record.
- **التحقق:** تطبيق نظيف من الصفر مرتين؛ القيود ترفض student/employee tenant mismatch؛ اختبارات SELECT/INSERT/UPDATE/DELETE تعزل مؤسستين ودمشق/حلب.
- **الخروج:** صفر اختبار DB فاشل، schema يطابق logical baseline، لا جدول legacy canonical موازٍ، ودليل أن service role غير مستخدم من العميل.
- **الموافقة البشرية:** اعتماد schema evidence وفتح G3.
- **التالي:** G3.

## G3 — Authentication and Roles

- **الهدف:** جلسات موثوقة وربط Profile والأدوار ودخول الموظف/الطالب وسياسة shared device.
- **المتطلبات السابقة:** G2 مغلق؛ role/auth policies معتمدة؛ قرارات تنفيذ OD-016 محسومة.
- **المسموح:** Supabase Auth/session restore/logout، trusted student PIN exchange، role-aware routing، auth/RLS tests.
- **الممنوع:** الاعتماد على UI guard، client role assignment، service_role في Flutter، CRUD الإداري الكامل.
- **الآثار المطلوبة:** auth flow diagram، threat cases، provisioning/reset procedure، session tests، secrets inventory.
- **التحقق:** دخول/خروج/استعادة لكل role؛ 5 failures→15-minute lockout؛ QR وحده مرفوض؛ تغيير client tenant/role لا ينتحل؛ logout يعزل local child state.
- **الخروج:** جميع role/session negative tests ناجحة، unknown/suspended role fail closed، `auth.uid()` يطابق profile/student الصحيح.
- **الموافقة البشرية:** اعتماد auth evidence وفتح G4.
- **التالي:** G4.

## G4 — Organizations, Branches, Classes and Users

- **الهدف:** CRUD إداري مصرح للبنية والمستخدمين وعلاقات المعلم.
- **المتطلبات السابقة:** G3 مغلق؛ DB/RLS للأصول جاهزة.
- **المسموح:** شاشات/مستودعات/عمليات CRUD ضمن matrix، lifecycle، teacher_classes.
- **الممنوع:** dhikr/wird/counter، offline admin conflicts، حقول طفل خارج baseline.
- **الآثار المطلوبة:** CRUD implementation، authorization tests، audit events، user lifecycle documentation.
- **التحقق:** إنشاء مؤسسة→دمشق→صف→طالب؛ معلم متعدد الصفوف داخل فرعه؛ رفض cross-branch/cross-org عبر استدعاء DB مباشر؛ `admin` لا يرفع الأدوار العليا؛ `branch_manager` لا يقرأ أو يدير فرعًا شقيقًا ولا يعيّن أو يغير `branch_manager` أو`organization_admin`.
- **الخروج:** السيناريو ناجح، جميع العمليات الأربع مغطاة حسب role matrix، لا inconsistent orphan/tenant row، analyze/tests ناجحة.
- **الموافقة البشرية:** قبول الرحلة والعزل وفتح G5.
- **التالي:** G5.

## G5 — Dhikr and Wird

- **الهدف:** مكتبة مراجعة، ورد، نطاق مطبع، وmaterialized user instances.
- **المتطلبات السابقة:** G4 مغلق؛ content governance وassignment semantics معتمدة.
- **المسموح:** dhikr lifecycle، wird lifecycle، scope rows، materialization/snapshots، CRUD المصرح.
- **الممنوع:** counter implementation، sync، campaigns، user-authored personal dhikr.
- **الآثار المطلوبة:** schema migrations لهذا Gate، domain rules، review workflow، scope/materialization tests.
- **التحقق:** approved-only publication؛ أطفال دمشق يحلون دون مستخدمي حلب؛ عدة الفروع صفوف منفصلة؛ dedupe instance؛ cross-tenant IDs مرفوضة؛ التاريخ لا يتغير بعد تعديل المصدر.
- **الخروج:** إنشاء ذكر→اعتماد→ورد→تكليف فردي صحيح ونتائج الحالات/المدد مؤكدة، analyze/tests/DB tests ناجحة.
- **الموافقة البشرية:** اعتماد lifecycle/content/scope وفتح G6.
- **التالي:** G6.

## G6 — Offline-first Counter

- **الهدف:** عد محلي فوري دائم ومعزول دون شبكة.
- **المتطلبات السابقة:** G5 مغلق؛ instance snapshots متاحة؛ local contract معتمد.
- **المسموح:** Drift local model، atomic tap/outbox، restore، completion UI المحلي، account isolation.
- **الممنوع:** network per tap، خادم sync النهائي، rewards نهائية من local-only state.
- **الآثار المطلوبة:** local schema/migrations، counter code، crash/restart/account isolation tests، performance measurement.
- **التحقق:** سيناريو 20→+30 offline→إغلاق/فتح=50؛ target cap؛ crash بين خطوات المعاملة لا يفصل count/outbox؛ حساب ثانٍ لا يرى الأول؛ tap responsive وفق budget معتمد.
- **الخروج:** الاختبارات على DB ملف حقيقي لا in-memory فقط، restart/device simulation ناجح، لا فقد أو تجاوز، analyze/tests ناجحة.
- **الموافقة البشرية:** مشاهدة/قبول دليل offline وفتح G7.
- **التالي:** G7.

## G7 — Secure Synchronization

- **الهدف:** مزامنة مجمعة idempotent ومصالحة خادمية بلا فقد/تكرار.
- **المتطلبات السابقة:** G6 مغلق؛ server progress/events schema وRPC policy جاهزة؛ OD-018/019 اللازمة محسومة.
- **المسموح:** queue worker، batch RPC، retries/backoff، reconciliation، integrity flags غير العقابية.
- **الممنوع:** last-write-wins للتقدم، حذف pending قبل ack، client time authority، عقوبة آلية.
- **الآثار المطلوبة:** sync protocol note، DB/RPC migrations، fault-injection tests، operational recovery procedure.
- **التحقق:** lost-response retry بنفس event UUID؛ reordering؛ duplicate batch؛ two devices؛ auth expiry؛ سياسة grace-window/late events ذات المدة المعتمدة في G7؛ server reaches 50 exactly؛ completion event once.
- **الخروج:** zero loss/double count across test matrix، recoverable failures remain queued، server/local reconcile، live Supabase RLS/RPC test ناجح.
- **الموافقة البشرية:** اعتماد reliability evidence وفتح G8.
- **التالي:** G8.

## G8 — Dashboards

- **الهدف:** رحلات الطفل/الموظف ومؤشرات مدير الفرع والمؤسسة من source progress.
- **المتطلبات السابقة:** G7 مغلق؛ metrics definitions/denominators واليوم مثبتة.
- **المسموح:** dashboards والقراءات/RPC المجمعة role-scoped.
- **الممنوع:** ترتيب طفل سلبي، ranking بالعدد الخام، reports exports، campaigns.
- **الآثار المطلوبة:** metric dictionary، queries/RPC، UI tests، reconciliation fixtures.
- **التحقق:** ستة مؤشرات الفرع صحيحة؛ جدول الفروع completion/participation؛ child sees own only وثلاثة أقسام؛ staff journey؛ teacher class authorization؛ no-data denominator defined.
- **الخروج:** نتائج الفرع والمركزية تطابق fixtures/source rows، cross-scope tests ناجحة، accessibility/RTL/analyze/tests ناجحة.
- **الموافقة البشرية:** قبول المقاييس والرحلات وفتح G9.
- **التالي:** G9.

## G9 — Points and Badges

- **الهدف:** مكافآت ledger قائمة على الإكمال والاستمرارية وواجهة غير تنافسية.
- **المتطلبات السابقة:** G8 مغلق؛ completion/day events مستقرة؛ OD-009 معتمد.
- **المسموح:** point rules/awards، compliance days، badges/awards، derived summaries.
- **الممنوع:** نقاط لكل tap، mutable total فقط، duplicate grants، child ranking.
- **الآثار المطلوبة:** migrations، rule engine، idempotency tests، rebuild-summary test، child reward UI.
- **التحقق:** تطبق القيم الرقمية التي يعتمدها G9 على completion/all-day/streak rules؛ retries/device concurrency لا تكرر؛ تعديل rule لا يعيد كتابة التاريخ؛ unique badge.
- **الخروج:** ledger يطابق الملخص قابلًا لإعادة البناء، جميع boundary/streak/timezone tests ناجحة، لا ترتيب في child UI.
- **الموافقة البشرية:** اعتماد reward evidence وفتح G10.
- **التالي:** G10.

## G10 — Basic Reports

- **الهدف:** تقرير يومي وفرع واحد ومستخدم واحد بفلاتر موحدة وعزل خادمي.
- **المتطلبات السابقة:** G9 مغلق؛ progress/reward sources مستقرة؛ filter semantics مثبتة.
- **المسموح:** Date Range/Branch/Class/Role/User/Wird/Dhikr/Completion filters، pagination المعتمدة، العروض الثلاثة.
- **الممنوع:** weekly/monthly comparisons وPDF/Excel، client-only filtering للأمان.
- **الآثار المطلوبة:** query/RPC contracts، filter matrix tests، reconciliation dataset، report UI.
- **التحقق:** single/combined filters؛ inclusive dates؛ invalid cross-branch combinations rejected؛ daily/branch/user totals equal source; RLS direct-call negatives.
- **الخروج:** all filter combinations representative pass، totals agree with dashboards/progress، performance budget met على حجم test معتمد.
- **الموافقة البشرية:** قبول التقارير وفتح G11.
- **التالي:** G11.

## G11 — Security and Privacy Review

- **الهدف:** إثبات least privilege والخصوصية والأسرار والتدقيق والتعافي قبل الإصدار.
- **المتطلبات السابقة:** G10 مغلق؛ كل migrations/features المرشحة موجودة؛ retention/backup decisions محسومة.
- **المسموح:** threat model، penetration-style functional tests، RLS/RPC audit، secret/privacy/log review، backup/restore drill، إصلاحات أمنية ضمن النطاق.
- **الممنوع:** ميزات جديدة، service_role client، قبول risk حرج تلقائيًا.
- **الآثار المطلوبة:** threat model، RLS matrix evidence، findings register، privacy/retention checklist، backup/restore result، SBOM/dependency review.
- **التحقق:** حسابات فعلية لكل role؛ REST/RPC bypass attempts؛ PIN enumeration/rate-limit; shared-device leakage; logs/secrets scan; restore test.
- **الخروج:** صفر finding Critical/High مفتوح؛ Medium له مالك وخطة؛ كل RLS cell مثبت؛ privacy/retention/incident ownership معتمد.
- **الموافقة البشرية:** security sign-off وفتح G12.
- **التالي:** G12.

## G12 — Android Release

- **الهدف:** APK Android موقع وقابل للتثبيت والترقية ينجح في سيناريو MVP الحي.
- **المتطلبات السابقة:** G11 مغلق؛ release config/keystore custody/distribution decisions معتمدة؛ staging/production values صحيحة.
- **المسموح:** signing/build flavors/release hardening، APK build، install/upgrade/rollback rehearsal، final acceptance.
- **الممنوع:** ميزات أو schema غير مراجعة، أسرار داخل APK، Play Store/iOS ما لم يغير المالك النطاق رسميًا.
- **الآثار المطلوبة:** signed APK + checksum، build provenance، install/upgrade evidence، release notes، rollback/support runbook، completed MVP acceptance record.
- **التحقق:** clean install وجولة upgrade على جهاز حقيقي؛ reverse/secret scan؛ login/offline 20→50/sync؛ full organization→100→manager visibility؛ production RLS negative tests الآمنة.
- **الخروج:** APK موقع يثبت ويعمل، الاختبارات والفحص نظيفة، السيناريو الحي كامل ومتطابق، لا config اختبار أو سر، تسليم checksum/runbooks.
- **الموافقة البشرية:** Release approval صريح. لا يعلن MVP ناجحًا قبله.
- **التالي:** إغلاق MVP؛ أعمال POST-MVP تحتاج خطة جديدة.

## خريطة التبعيات

`G1←G0`, `G2←G1+logical model`, `G3←G2+auth policy`, `G4←G3`, `G5←G4+content/scope`, `G6←G5+local contract`, `G7←G6+server progress`, `G8←G7`, `G9←G7/G8 completion semantics`, `G10←G8/G9 sources`, `G11←G2–G10`, `G12←G11`.
