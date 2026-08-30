# G0 Closure Package — G0-GC-01

تاريخ الإعداد: 2026-08-30  
الحالة: **HISTORICAL G0-GC-01 PACKAGE — SUPERSEDED BY G0-OD-03 AND FINAL G0 VERIFICATION**  
تحفظ هذه الوثيقة الموانع والمقترحات قبل قرارات المالك. لا تستخدم حالات `PENDING` الواردة أدناه بوصفها الحالة الحالية؛ المرجع الحالي `OWNER_DECISION_REGISTER.md` و`G0_OWNER_DECISION_STATUS.md`. هذه ليست موافقة G0 ولا تفتح G1.

## 1. الموانع الأصلية

صنّف `G0_REVIEW.md` الحالة `NOT READY / HOLD G0` بسبب ثمانية عشر موضوعًا ماديًا مجمعًا: هدف ونطاق المنتج، المنصة، الهوية، الأدوار، دخول الطفل، نماذج التقدم، عقد المزامنة، نموذج الورد، دلالة النطاق، الوقت، النقاط، الأوسمة، حوكمة المحتوى، lifecycle/الاحتفاظ، tenant/RLS، خصوصية الطفل، انتقال prototype، وعقود Gate.

التفصيل وربط المصدر والقرار في `G0_BLOCKER_REGISTER.md` من G0-B001 إلى G0-B018.

## 2. الحل المقترح لكل مجموعة

| الموانع | الحل المقترح | وثيقة الحل |
|---|---|---|
| B001 | MVP مؤسسي واحد وتصنيف MVP/POST/OUT | `MVP_SCOPE_BASELINE.md` |
| B002 | Android first وAPK موقع؛ iOS/Store لاحقًا | `PLATFORM_BASELINE.md` |
| B003/B006/B008/B009/B010/B012 | profile هوية موحدة، student domain، نموذج wird/instance/progress، scopes مطبعة، وقت مؤسسة | `LOGICAL_DATA_MODEL.md` |
| B004/B015 | ستة أدوار، admin فرعي، Role منفصل عن Scope، matrix موارد | `ROLE_AND_SCOPE_MODEL.md` |
| B005/B016 | organization+student code+6 PIN، lockout، shared-device privacy، QR لاحقًا | `STUDENT_AUTH_POLICY.md` |
| B007 | acknowledged + pending delta، batch event UUID، multi-device/recovery/reward idempotency | `OFFLINE_SYNC_CONTRACT.md` |
| B011/B012 | +10 ledger rules، summaries مشتقة، unique badges | `LOGICAL_DATA_MODEL.md` |
| B013 | مكتبة مؤسسية بمصدر ومراجعة وsnapshots | `LOGICAL_DATA_MODEL.md` وMVP baseline |
| B014 | حالات وأرشفة وتقليل بيانات؛ المدد قبل الإنتاج | logical/auth baselines + OD-010 |
| B017 | clean rebuild مقترح إذا لا بيانات إنتاج؛ prototype reference | logical model + OD-012 |
| B018 | عقود قابلة للقياس لكل G0–G12 | `GATE_ACCEPTANCE_MATRIX.md` |

## 3. الملفات المنشأة

1. `G0_BLOCKER_REGISTER.md`
2. `MVP_SCOPE_BASELINE.md`
3. `ROLE_AND_SCOPE_MODEL.md`
4. `STUDENT_AUTH_POLICY.md`
5. `LOGICAL_DATA_MODEL.md`
6. `OFFLINE_SYNC_CONTRACT.md`
7. `PLATFORM_BASELINE.md`
8. `GATE_ACCEPTANCE_MATRIX.md`
9. `OWNER_DECISION_REGISTER.md`
10. `DOCUMENT_AUTHORITY_MAP.md`
11. `G0_CLOSURE_PACKAGE.md`

ملاحظة: طلب المهمة سمّى هذه الآثار تباعًا، وعددها النهائي أحد عشر ملفًا بما فيها الحزمة والسجلان وخريطة السلطة.

## 4. قرارات المالك المتبقية لإغلاق G0

جميع OD-001..OD-013 ما تزال `PENDING`:

1. تعريف MVP.
2. الأدوار ومعنى admin.
3. الهوية وعضوية المؤسسة والنموذج المنطقي.
4. دخول الطالب والخصوصية.
5. الورد والنطاق وmaterialization.
6. حوكمة الأذكار.
7. المنطقة الزمنية.
8. عقد المزامنة ونافذة 72 ساعة.
9. النقاط والأوسمة.
10. lifecycle وتقليل البيانات والاحتفاظ.
11. Android first/G12.
12. clean rebuild وتأكيد عدم وجود بيانات إنتاج.
13. Gate Acceptance Matrix.

هذه أقل مجموعة عملية؛ دمج المزيد سيجعل قبول بديل جزئيًا غير قابل للتتبع.

## 5. قرارات مؤجلة بأمان

OD-014..OD-026 مؤجلة إلى Gate مناسب: إصدارات SDK والحزم، تفاصيل SQL والفهارس، تنفيذ PIN cryptography، UI، Drift/batch/backoff، عتبات النزاهة، performance tuning، visualization، pagination، مدد الاحتفاظ الرقمية والمراقبة، تفاصيل keystore/device، وكل ميزات POST-MVP.

التأجيل لا يسمح بتغيير invariants المعتمدة؛ أي أثر على tenant/identity/sync/security يعيد القرار إلى G0.

## 6. التناقضات غير المحسومة نصيًا

ما زالت الوثائق الأصلية تحتوي نصوصًا متعارضة حول:

- المنتج الشخصي/القرآن مقابل المنتج المؤسسي.
- Android+iOS مقابل Android first.
- member/admin/branch_users/managed_wirds مقابل النموذج المقترح.
- network event لكل tap مقابل batching.
- +1 مقابل قواعد +10.
- الحملات والتذكيرات كـMVP مقابل POST-MVP.
- README الذي يدعي اكتمال مراحل بينما Gate الحالي G0.

لم تُعد كتابة الوثائق الأصلية عمدًا امتثالًا لتعليم «لا تعيدها بصمت». `DOCUMENT_AUTHORITY_MAP.md` يحدد كل تصحيح مطلوب بعد قرار المالك. لذلك هذه التناقضات لا تمنع **عرض الحزمة للقرار** لكنها تمنع **إغلاق G0**.

## 7. الشروط الدقيقة لوسم G0 CLOSED

- [ ] يسجل المالك جوابًا صريحًا لـOD-001..OD-013.
- [ ] كل قرار إما APPROVED أو يستبدل ببديل مكتوب كامل الأثر؛ لا PENDING/NEEDS REVISION مانع.
- [ ] يؤكد المالك وجود/عدم وجود بيانات إنتاج ويعتمد rebuild أو migration قابلًا للعكس.
- [ ] تحدث `PRODUCT_REQUIREMENTS.md`, `DATABASE_SCHEMA.md`, `ARCHITECTURE.md`, `README.md`, `MVP_ACCEPTANCE.md`, و`CODEX_PLAN.md` لتتسق مع القرارات، دون كود/SQL.
- [ ] يراجع `AGENTS.md` فقط إذا احتاجت قواعد التنفيذ أو قائمة MVP تحديثًا.
- [ ] لا يبقى مصدر حقيقة قديم موازٍ أو مصطلح role/user/progress مبهم.
- [ ] تعتمد مصفوفة الأدوار/RLS والخريطة المنطقية وخطة الانتقال ومعايير G1–G12.
- [ ] يجرى فحص اتساق نهائي ويصبح كل G0-B001..B018 `CLOSED BY OWNER DECISION`.
- [ ] يوقع المالك عبارة صريحة: `G0 CLOSED — G1 AUTHORIZED`.

حتى تحقق آخر بند تبقى الحالة الرسمية في `CODEX_PLAN.md`: `G0 — Planning`.

## 8. التوصية

# READY FOR OWNER DECISION

الحزمة كاملة بما يكفي ليقبل المالك المقترحات أو يعدلها. لا توصي الحزمة ببدء G1 الآن، ولا تعتمد G0 تلقائيًا. إذا رفض المالك قرارًا يؤثر في الهوية أو النطاق أو المزامنة، تعدل baselines المتأثرة ويعاد فحص الاتساق قبل طلب الإغلاق.
