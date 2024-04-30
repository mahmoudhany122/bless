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
            crossAxisSpacing: 8.0,
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
          Image.asset(imageUrl, height: 140, width: 140),
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
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/${widget.item['imageFileName']}',
                  height: 110,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "لمحه عامه".tr,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline1,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      _isExpanded
                          ? ' ${widget.item['description']}'
                          : '${widget.item['description'].substring(0, min<int>(50, widget.item['description'].length))}...',
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
                        child: Text("قراءة المزيد"),
                      ),
                  ],
                ),
              ],
            ),
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
    'description': 'لاضطراب الاكتئابي (المعروف أيضاً باسم الاكتئاب) هو اضطراب نفسي شائع يسبب شعوراً بالحزن وفقدان الاهتمام بالأشياء التي كانت ممتعة مرة واحدة، وقد يؤدي إلى مجموعة من المشاكل النفسية والفسيولوجية. قد يؤثر الاكتئاب بشكل كبير على الأداء اليومي والعلاقات الشخصية. من المهم البحث عن العلاج المناسب للتعامل مع الاكتئاب وتحسين الجودة العامة للحياة. لاضطراب الاكتئابي (المعروف أيضاً باسم الاكتئاب) هو اضطراب نفسي شائع يسبب شعوراً بالحزن وفقدان الاهتمام بالأشياء التي كانت ممتعة مرة واحدة، وقد يؤدي إلى مجموعة من المشاكل النفسية والفسيولوجية. قد يؤثر الاكتئاب بشكل كبير على الأداء اليومي والعلاقات الشخصية. من المهم البحث عن العلاج المناسب للتعامل مع الاكتئاب وتحسين الجودة العامة للحياة. لاضطراب الاكتئابي (المعروف أيضاً باسم الاكتئاب) هو اضطراب نفسي شائع يسبب شعوراً بالحزن وفقدان الاهتمام بالأشياء التي كانت ممتعة مرة واحدة، وقد يؤدي إلى مجموعة من المشاكل النفسية والفسيولوجية. قد يؤثر الاكتئاب بشكل كبير على الأداء اليومي والعلاقات الشخصية. من المهم البحث عن العلاج المناسب للتعامل مع الاكتئاب وتحسين الجودة العامة للحياة.',
  },
  {
    'name': 'قلق'.tr,
    'imageFileName': 'explore/img_5.png',
    'description': 'عندما يصبح القلق مفرطاً أو غير مسيطر عليه، يمكن أن يؤثر على الحياة اليومية بشكل كبير. يمكن أن يتسبب القلق المستمر في مشاكل في العمل، والعلاقات الشخصية، والصحة العامة. يجب أن يتم التعامل مع القلق المفرط بجدية، وقد يتطلب الأمر العلاج الاحترافي للتغلب عليه. عندما يصبح القلق مفرطاً أو غير مسيطر عليه، يمكن أن يؤثر على الحياة اليومية بشكل كبير. يمكن أن يتسبب القلق المستمر في مشاكل في العمل، والعلاقات الشخصية، والصحة العامة. يجب أن يتم التعامل مع القلق المفرط بجدية، وقد يتطلب الأمر العلاج الاحترافي للتغلب عليه. عندما يصبح القلق مفرطاً أو غير مسيطر عليه، يمكن أن يؤثر على الحياة اليومية بشكل كبير. يمكن أن يتسبب القلق المستمر في مشاكل في العمل، والعلاقات الشخصية، والصحة العامة. يجب أن يتم التعامل مع القلق المفرط بجدية، وقد يتطلب الأمر العلاج الاحترافي للتغلب عليه.',
  },
  {
    'name': "إختلال النوم".tr,
    'imageFileName': 'explore/img_13.png',
    'description': 'يعتبر اضطراب النوم من الأمراض الشائعة التي يعاني منها الكثير من الأشخاص. قد يتسبب اضطراب النوم في مشاكل في الأداء اليومي، والتعب الشديد، وعدم القدرة على التركيز. يجب البحث عن الأسباب المحتملة لاضطراب النوم واتخاذ الإجراءات اللازمة للتعامل معه بفعالية. يعتبر اضطراب النوم من الأمراض الشائعة التي يعاني منها الكثير من الأشخاص. قد يتسبب اضطراب النوم في مشاكل في الأداء اليومي، والتعب الشديد، وعدم القدرة على التركيز. يجب البحث عن الأسباب المحتملة لاضطراب النوم واتخاذ الإجراءات اللازمة للتعامل معه بفعالية. يعتبر اضطراب النوم من الأمراض الشائعة التي يعاني منها الكثير من الأشخاص. قد يتسبب اضطراب النوم في مشاكل في الأداء اليومي، والتعب الشديد، وعدم القدرة على التركيز. يجب البحث عن الأسباب المحتملة لاضطراب النوم واتخاذ الإجراءات اللازمة للتعامل معه بفعالية.',
  },
  {
    'name': 'ضغط'.tr,
    'imageFileName': 'explore/img_7.png',
    'description': 'الضغط هو حالة يمكن أن تحدث عندما يكون هناك تفاعل سلبي بين الفرد والبيئة المحيطة به. يمكن أن يسبب الضغط تأثيرات سلبية على الصحة العامة، بما في ذلك زيادة مستويات الإجهاد والقلق وحتى المشاكل الصحية الجسدية مثل الصداع والامتناع عن الأكل. للتعامل مع الضغط بشكل فعال، يجب تحديد مصادر الضغط وتطبيق استراتيجيات لإدارته بشكل صحيح.',
  },
  {
    'name': 'رهاب'.tr,
    'imageFileName': 'explore/img_4.png',
    'description': 'يُعرف رهاب بأنه خوف شديد من شيء معين أو موقف معين يمكن أن يكون غير منطقي. قد يؤثر الرهاب على الحياة اليومية للشخص وقد يؤدي إلى تجنب الأماكن أو الأشياء التي تسبب الخوف، مما يؤثر على الحياة الاجتماعية والمهنية. يجب البحث عن العلاج المناسب للتعامل مع الرهاب وتحسين الجودة العامة للحياة.',
  },
  {
    'name': 'اضطراب في الشخصية'.tr,
    'imageFileName': 'explore/img_9.png',
    'description': 'يتسم اضطراب الشخصية بتشوه في النظرة الذاتية وطريقة تفكير الشخص وتصرفاته. يمكن أن يؤدي اضطراب الشخصية إلى مشاكل في العلاقات الشخصية والعمل والتعليم. يمكن أن يكون العلاج النفسي مفيدًا للأشخاص الذين يعانون من اضطراب الشخصية لتحسين جودة حياتهم وعلاقاتهم.',
  },
  // Add more items with different data
];
