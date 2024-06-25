import 'package:flutter/material.dart';

class DeepBreathingBenefitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('فوائد التنفس العميق'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'فوائد عديدة يقدمها التنفس العميق للجسم',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'فيما يأتي توضيحٌ لأهم الفوائد الناجمة عن التنفس العميق:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '• قد يخلص التنفس العميق الجسم من السموم',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'يُعدّ التنفس العميق أحد الطرق التي تُساعد الجسم في التخلص من السموم، خاصةً للأفراد الذين يُعانون من مشاكل في الجهاز التنفسي وضعف في وظائف الرئتين، إذ يطرح جسم الإنسان ما يقارب 70% من السموم خلال عملية التنفس، ويعدّ ثاني أكسيد الكربون أحد المواد السامة التي يجب التخلص منها باستمرار.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '• قد يساعد التنفس العميق على التخلص من الآلام',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'قد يساعد التنفس العميق على استرخاء العضلات المتوترة، مما يقلل الشعور بالألم، وذلك لدوره في زيادة تركيز الجسم على عملية التنفس بحد ذاتها ليتم نسيان الألم، إضافة إلى أنه يحسّن من الدورة الدموية ويسهل تبادل الأكسجين وثاني الأكسيد الكربون بكفاءة وجهد أقل على الجسم، وذلك ما أشارت إليه دراسة سريرية نشرت في مجلة (PLOS one) عام 2017 م.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '• قد يقلل التنفس العميق من التوتر والقلق',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'يُعد التنفس العميق طريقة رائعة للتخلص من الطاقة السلبية وطرحها خارج الجسم، حيث إنّ التنفس العميق يسهل حدوث العمليات الحيوية في الجسم، ويساعد على الحفاظ على توازن الجهاز العصبي اللاإرادي الذي ينظم أغلبية وظائف الجسم اللاإرادية كالتحكم في درجة الحرارة وهذا يساعد في تخفيف أعراض الاضطرابات المرتبطة بالتوتر، والاكتئاب، والعصبية. وذلك ما أكدته نتائج دراسة سريرية نشرت في مجلة (International Journal of Applied Engineering Research) عام 2018 م.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '• قد يساعد التنفس العميق الأشخاص المصابين بالأمراض التنفسية',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'يُعدّ التنفس العميق أحد التمارين المهمة للأشخاص المصابين بالأمراض التنفسية كالربو والتهابات الشعب الهوائية المزمنة، وذلك لدوره في زيادة فاعلية الرئتين وقدرتها على العمل بشكل أفضل. ومن أشهر التمارين المستخدمة لذلك تمارين التبادل التنفسي (Pranayama) حسب نتائج دراسة سريرية نشرت في مجلة (International Journal of Physiology, Nutrition and Physical Education) عام 2020 م.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '• قد يحسن التنفس العميق من عمل الجهاز الهضمي',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'قد يُساعد التنفس العميق أيضًا على تحسين وظيفة الجهاز الهضميّ، لدوره في السيطرة على التوتر والإجهاد الذي يؤثر في وظيفة الجهاز الهضمي، ومن أشهر تمارين التنفس العميق تمارين اليوغا، كما تلعب دورًا في التقليل من فرصة الإصابة بالاضطرابات الهضمية، وفقًا لدراسة نشرت في مجلة (Environment Conservation Journal) عام 2017 م.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '• قد يقلل التنفس العميق من معدل ضربات القلب',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'قد يُساعد التنفس العميق على ضبط نبضات القلب، وذلك لدوره في التقليل من ضغط الدم وإجهاد عضلة القلب، الأمر الذي يُسهم بشكل عام في زيادة كفاءة عضلة القلب، وذلك ما أشارت إليه دراسة سريرية نشرت في مجلة (Integrative Medicine Research) عام 2020 م.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '• قد يحسن من قدرة الجسم على تحمل التمارين الشديدة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'قد تساعد تمارين التنفس العميق على زيادة قدرة الأفراد على تحمل التمارين الشديدة، كالجري والملاكمة، وذلك لدورها في تحسين وظيفة الرئة، الأمر الذي يسمح بدخول كميات كبيرة من الأكسجين للجسم مما يقوي العضلات. ومن أشهر التمارين التي تزيد من قدرة الجسم على التحمل تمارين اليوغا، وفقًا لدراسة سريرية نشرت في مجلة (International journal of exercise science) عام 2020 م.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
