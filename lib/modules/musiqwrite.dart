import 'package:flutter/material.dart';

class MusicTherapyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('النغمات العلاجية'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'فوائد الموسيقى وأثرها على الإنسان',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'اُكتشف تأثير الموسيقى العلاجي منذ قرون، فقد كانت جزءاً من كل شيء، ابتداءً من الطقوس القديمة وانتهاءً بالأنواع المعاصرة للعلاج بالصوت، وتنطوي العلاقة الوثيقة بين الموسيقى والصحة النفسية على العديد من الجوانب النفسية، والعاطفية، والفسيولوجية المختلفة.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'ولا يحدد نوع الموسيقى ما إذا كان لها تأثير علاجي أم لا، بل ما يهم هو الصدى العاطفي. فيما يلي بعض أبرز الطرق التي يمكن من خلالها للموسيقى أن تعزز الصحة النفسية:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'الاسترخاء والتقليل من التوتر',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'يمكن أن يساعد الاستماع إلى الموسيقى الجسم على الاسترخاء، حيث تعمل المقطوعات الموسيقية البطيئة والمتناغمة على خفض معدل ضربات القلب وضغط الدم، وتقلل من توتر العضلات. وتُعرف الموسيقى بقدرتها الكبيرة على تحفيز الاسترخاء، وأظهرت الدراسات أن الاستماع إلى الموسيقى يمكن أن يقلل مستويات هرمونات التوتر مثل الكورتيزول، والمساعدة على تهدئة المشاعر.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'تنظيم المزاج',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'هل سبق لك أن لاحظت كيف يمكن للأغنية المثالية أن ترفع معنوياتك وتجعلك تشعر بالأمل؟ تساعد الموسيقى على إفراز مادة الدوبامين، وهي المادة الكيميائية المسؤولة عن الشعور بالسعادة في الدماغ، مما يؤدي إلى تحسين الحالة المزاجية والشعور بالإيجابية. في بعض الأحيان، يمكن حتى للموسيقى الحزينة أن تحسن من شعورك، ويرجع السبب في ذلك إلى أن دخولك في حالة من الحزن يمكن أن يساعدك على التعبير عن مشاعر اليأس لديك لتتخلص منها وتتغلب على المزاج السيء.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'اليقظة والتأمل',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'يمكن لبعض أنواع الموسيقى أن تساعد في ممارسة اليقظة الذهنية والتأمل، حيث تخلق الإيقاعات المتكررة والألحان الهادئة بيئة مناسبة للتأمل الداخلي والاسترخاء ويمكن أن تريح العقل وتضعه في حالة تأملية.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'التدخل العلاجي',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'يعد العلاج بالموسيقى تدخلاً علاجياً معترفاً به وفعالاً لمشاكل الصحة النفسية، ويستخدم المعالجون الموسيقى لتخطي التحديات العاطفية والنفسية المختلفة، بدءاً من القلق والاكتئاب وحتى الصدمات النفسية والمشكلات السلوكية.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'ملاحظات أخيرة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'إن العناية بالصحة النفسية هي رحلة معقدة ومستمرة، ولكن الموسيقى قد تكون رفيقاً مؤنساً يمكن الاعتماد عليه خلال هذه الرحلة. لا يمكننا التغاضي عن تأثير الموسيقى على الصحة النفسية، بغض النظر عن الطريقة التي تتبعها سواء كنت مهتماً بصناعة الموسيقى أو تحب الاستماع لها كوسيلة لتخطي المشاعر السلبية، أو زيادة التركيز، أو التحسين من المزاج، أو التواصل مع الآخرين.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
