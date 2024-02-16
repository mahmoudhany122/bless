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
                  borderRadius: BorderRadius.circular(20.0),
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

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/${item['imageFileName']}',
              height: 110,
              width: 110,
            ),
            SizedBox(height: 16),
            Text(
              ' ${item['name']}',
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
                  ' ${item['description']}',
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> items = [
  {
    'name': 'الاكتئاب'.tr,
    'imageFileName': 'explore/img.png',
    'description': 'لاضطراب الاكتئابي (المعروف أيضاً باسم الاكتئاب) هو اضطراب'.tr,
  },
  {
    'name': 'قلق'.tr,
    'imageFileName': 'explore/img_7.png',
    'description': 'عانوا من سوء المعاملة أو الخسائر الفا'.tr,
  },
  {
    'name': "إختلال النوم".tr,
    'imageFileName': 'explore/img_10.png',
    'description': 'عانوا من سوء المعاملة أو الخسائر الفا'.tr,
  },
  {
    'name': 'ضغط'.tr,
    'imageFileName': 'explore/img_8.png',
    'description': 'عانوا من سوء المعاملة أو الخسائر الفا'.tr,
  },
  {
    'name': 'رهاب'.tr,
    'imageFileName': 'explore/img_4.png',
    'description': 'عانوا من سوء المعاملة أو الخسائر الفا'.tr,
  },
  {
    'name': 'اضطراب في الشخصية'.tr,
    'imageFileName': 'explore/img_9.png',
    'description': 'عانوا من سوء المعاملة أو الخسائر الفا'.tr,
  },
  // Add more items with different data
];
