# Role and Scope Model — Rawdat Wird

الحالة: **OWNER APPROVED REVISED — OD-002/G0-OD-03**  
الغرض: تثبيت الأدوار العادية وحدود النطاق التي يجب أن تفرضها PostgreSQL RLS وRPC، لا الواجهة فقط.

## 1. المبدأ

- **Role** يحدد نوع الصلاحية: ماذا يجوز للمستخدم أن يفعل.
- **Scope** يحدد حدود البيانات: أين وعلى من يجوز تنفيذ الصلاحية.
- مثال: `branch_manager` هو Role، و`organization_id + branch_id` هما Scope.
- كل حساب MVP عضو في مؤسسة واحدة فقط. لا تمثل عضوية منصات متعددة داخل حساب التطبيق العادي.
- إدارة المنصة العليا، إن احتاجها المشغل مستقبلًا، هوية خدمة/بوابة منفصلة خارج أدوار المؤسسة وتطبيق الهاتف، وليست قيمة إضافية في `profiles.role`.

## 2. الأدوار العادية النهائية المقترحة

| الدور | النطاق الإلزامي | المعنى في MVP |
|---|---|---|
| `organization_admin` | `organization_id`, و`branch_id = null` | يدير المؤسسة وكل فروعها، ويعتمد المحتوى ويرى التقارير والتدقيق المؤسسي |
| `branch_manager` | `organization_id + branch_id` | يدير البيانات التشغيلية لفرع واحد فقط؛ لا ينشئ مؤسسة، ولا يعبر لفرع شقيق، ولا يعيّن أو يغير `branch_manager` أو`organization_admin` |
| `admin` | `organization_id + branch_id` | إداري تشغيلي للفرع: يدير الصفوف والمستخدمين العاديين والأوراد والتقارير، ولا يغير مدير الفرع أو أدوار الإدارة العليا ولا يصل إلى سجل الأمن الكامل |
| `teacher` | `organization_id + branch_id` و0..n صفوف مفوضة | ينفذ ورده، ويرى الصفوف والطلاب المفوضين له بالقدر اللازم؛ لا يدير البنية أو الأدوار |
| `staff` | `organization_id + branch_id` | موظف غير تعليمي؛ ينفذ ورده ويرى تقدمه، بلا إدارة افتراضيًا |
| `student` | `organization_id + branch_id + class_id` عبر سجل الطالب | ينفذ أوراده ويرى تقدمه ونقاطه وأوسمته فقط |

`admin` لا يعني platform admin ولا organization admin، ولا يجوز منحه صلاحية رفع نفسه أو غيره إلى `branch_manager` أو `organization_admin`.

## 3. مصفوفة التفويض

الرموز: `M` إدارة، `R` قراءة، `O` بياناته فقط، `C` الصفوف المفوضة، `B` الفرع، `Org` المؤسسة، `—` ممنوع. كل خلية مقيدة أيضًا بالمؤسسة.

| المورد/العملية | organization_admin | branch_manager | admin | teacher | staff | student |
|---|---|---|---|---|---|---|
| المؤسسة | M(Org) | R(Org basics) | R(Org basics) | R(Org basics) | R(Org basics) | R(name/code only) |
| الفروع | M(Org) | R(B) | R(B) | R(B) | R(B) | R(B basics) |
| الصفوف | M(Org) | M(B) | M(B) | R(C) | — | R(own) |
| إدارة المستخدمين | M(Org) | M(B للطالب/teacher/staff/admin؛ بلا تعيين أو تغيير branch_manager/org admin) | M(B للطالب/teacher/staff؛ بلا ترقية إدارية) | — | — | — |
| بيانات الطلاب | M/R(Org) | M/R(B) | M/R(B) | R(C، الحد الأدنى) | — | R(O) |
| بيانات المعلمين | M/R(Org) | M/R(B) | M/R(B دون تغيير دور إداري) | R(O) | — | — |
| تعريفات الأذكار | M/approve(Org) | create/edit draft + R approved(B) | create/edit draft + R approved(B) | R approved | R approved | R assigned snapshot |
| إنشاء/إدارة الورد | M(Org) | M(B scopes) | M(B scopes) | — | — | — |
| إنشاء التكليف | M(Org) | M(B only) | M(B only) | — | — | — |
| عرض التقدم | R(Org) | R(B) | R(B) | R(C) | R(O) | R(O) |
| المكافآت | rules/definitions M(Org) | R(B)+manual badge allowed | R(B), بلا قواعد أو منح يدوي | R(C summary only) | R(O) | R(O) |
| التقارير | R(Org) | R(B) | R(B) | R(C limited) | R(O history) | R(O history) |
| سجل التدقيق | R(Org) | R(B operational) | — | — | — | — |
| مؤشرات الأمن/النزاهة | R/review(Org) | R/review(B) | — | — | — | — |

## 4. قواعد النطاق غير القابلة للتجاوز

1. الطالب يحمل دائمًا مؤسسة وفرعًا وصفًا متطابقة العلاقات.
2. أدوار `branch_manager`, `admin`, `teacher`, `staff` تحمل مؤسسة وفرعًا؛ لا تقبل `branch_id = null`.
3. `organization_admin` يحمل مؤسسة واحدة و`branch_id = null`.
4. كل صف في `teacher_classes` يجب أن ينتمي إلى فرع المعلم نفسه.
5. أي تغيير مؤسسة أو فرع للمستخدم عملية إدارية موثوقة تتحقق من التبعيات، وليست تحديثًا ذاتيًا.
6. لا تؤخذ `role`, `organization_id`, أو`branch_id` المرسلة من العميل دليلًا؛ تستخرج الصلاحية من هوية الجلسة والبيانات الخادمية.
7. GoRouter يخفي المسارات غير المناسبة لكنه ليس حدًا أمنيًا.
8. الوصول المجمّع والتقارير وRPC يخضع للمصفوفة نفسها مثل REST المباشر.
9. يدير `branch_manager` البيانات التشغيلية داخل `branch_id` الخاص به فقط، ومنها الصفوف والمستخدمون العاديون والأوراد والتكليفات والتقارير والمراجعات الفرعية المصرح بها.
10. لا يستطيع `branch_manager` إنشاء فرع شقيق أو قراءته أو إدارته، أو تغيير مؤسسة/فرع مستخدم إلى نطاق آخر، أو تعيين/تعديل/تعطيل `branch_manager` أو`organization_admin`.
11. تبقى إعدادات المؤسسة، والإجراءات العابرة للفروع، وتعيين الأدوار الإدارية العليا، والسلطات المؤسسية لدى `organization_admin` فقط.
12. يجب فرض البنود السابقة في RLS وRPC؛ إخفاء إجراء في UI لا يعد تفويضًا أو عزلًا.

## 5. Provisioning والحالات

- ينشئ `organization_admin` أو من يفوضه النظام حسابات الفرع من مسار موثوق.
- تغيير `organization_admin` و`branch_manager` محصور في `organization_admin` مع منع إزالة آخر مدير مؤسسة نشط.
- الحالات المقترحة للهوية: `invited`, `active`, `suspended`, `archived`. لا يستطيع `suspended/archived` بدء جلسة أو المزامنة، وتبقى السجلات التاريخية.
- الحذف في MVP أرشفة/تعطيل مع سياسة احتفاظ؛ لا حذف متسلسل للإنجازات.

## 6. إثبات لاحق مطلوب

ينبغي أن يحول G2/G3 هذه المصفوفة إلى RLS/RPC واختبارات سلبية. يجب إثبات أن مدير دمشق لا يقرأ أو يعدل حلب، وأن المعلم لا يتجاوز صفوفه، وأن الطالب لا يصل إلى طفل آخر، باستخدام جلسات حقيقية من دون `service_role`.
