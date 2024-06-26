import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 9.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(item: items[index]),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor('00B4D8'), width: 2.0),

                ),
                child: GridItem(item: items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const GridItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String itemName = item['name'];
    String imageUrl = 'assets/${item['imageFileName']}';

    return Card(
      child: Column(
        children: [
          Image.asset(imageUrl, height: 115, width: 140),
          SizedBox(height: 8),
          Text(
            itemName,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}



class DetailPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/${widget.item['imageFileName']}',
                height: 124,
                width: 110,
              ),
              SizedBox(height: 16),
              Text(
                ' ${widget.item['name']}',
                style: Theme.of(context).textTheme.bodyText1,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "لمحه عامه".tr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline1,
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    _isExpanded
                        ? '${widget.item['description']}'
                        : '${widget.item['description'].split(' ').take(25).join(' ')}...',
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  if (!_isExpanded)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                      child: Text("قراءة المزيد".tr),
                    ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> items = [

  {
    'name': 'الاكتئاب'.tr,
    'imageFileName': 'explore/img.png',
    'description': 'الاضطراب الاكتئابي (المعروف أيضاً باسم الاكتئاب) هو اضطراب نفسي شائع، وينطوي على تكدّر المزاج أو فقدان الاستمتاع أو الاهتمام بالأنشطة لفترات طويلة من الزمن.ويختلف الاكتئاب عن التقلبات المزاجية المعتادة والانفعالات العابرة إزاء تحديات الحياة اليومية. ويمكن أن يؤثر على جميع جوانب الحياة، بما في ذلك العلاقات مع أفراد الأسرة والأصدقاء والمجتمع. ويمكن أن ينتج عن مشكلات في المدرسة وفي العمل، أو أن يؤدي إليها '.tr,
  },
  {
    'name': 'قلق'.tr,
    'imageFileName': 'explore/img_5.png',
    'description': ' عندما يصبح القلق مفرطاً أو غير مسيطر عليه، يمكن أن يؤثر على الحياة اليومية بشكل كبير. يمكن أن يتسبب القلق المستمر في مشاكل في العمل، والعلاقات الشخصية، والصحة العامة. يجب أن يتم التعامل مع القلق المفرط بجدية، وقد يتطلب الأمر العلاج الاحترافي للتغلب عليه.'.tr,
  },
  {
    'name': "إختلال النوم".tr,
    'imageFileName': 'explore/img_13.png',
    'description': 'يعتبر اضطراب النوم من الأمراض الشائعة التي يعاني منها الكثير من الأشخاص. قد يتسبب اضطراب النوم في مشاكل في الأداء اليومي، والتعب الشديد، وعدم القدرة على التركيز. يجب البحث عن الأسباب المحتملة لاضطراب النوم واتخاذ الإجراءات اللازمة للتعامل معه بفعالية.شخاص. قد يتسبب اضطراب النوم في مشاكل في الأداء اليومي، والتعب الشديد، وعدم القدرة على التركيز. يجب البحث عن الأسباب المحتملة لاضطراب النوم واتخاذ الإجراءات اللازمة للتعامل معه بفعالية.'.tr,
  },
  {
    'name': 'ضغط'.tr,
    'imageFileName': 'explore/img_7.png',
    'description': 'الضغط هو حالة يمكن أن تحدث عندما يكون هناك تفاعل سلبي بين الفرد والبيئة المحيطة به. يمكن أن يسبب الضغط تأثيرات سلبية على الصحة العامة، بما في ذلك زيادة مستويات الإجهاد والقلق وحتى المشاكل الصحية الجسدية مثل الصداع والامتناع عن الأكل. للتعامل مع الضغط بشكل فعال، يجب تحديد مصادر الضغط وتطبيق استراتيجيات لإدارته بشكل صحيح.'.tr,
  },
  {
    'name': 'رهاب'.tr,
    'imageFileName': 'explore/img_4.png',
    'description': 'يُعرف رهاب بأنه خوف شديد من شيء معين أو موقف معين يمكن أن يكون غير منطقي. قد يؤثر الرهاب على الحياة اليومية للشخص وقد يؤدي إلى تجنب الأماكن أو الأشياء التي تسبب الخوف، مما يؤثر على الحياة الاجتماعية والمهنية. يجب البحث عن العلاج المناسب للتعامل مع الرهاب وتحسين الجودة العامة للحياة.'.tr,
  },
  {
    'name': 'اضطراب في الشخصية'.tr,
    'imageFileName': 'explore/img_9.png',
    'description': 'يتسم اضطراب الشخصية بتشوه في النظرة الذاتية وطريقة تفكير الشخص وتصرفاته. يمكن أن يؤدي اضطراب الشخصية إلى مشاكل في العلاقات الشخصية والعمل والتعليم. يمكن أن يكون العلاج النفسي مفيدًا للأشخاص الذين يعانون من اضطراب الشخصية لتحسين جودة حياتهم وعلاقاتهم.'.tr,
  },
  // Add more items with different data
];
