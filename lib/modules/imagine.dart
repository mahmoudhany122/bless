import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ExerciseScreen extends StatelessWidget {
  String _selectedLanguage = 'ar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:Directionality(
           textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تمارين'.tr,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 6),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: [
                  Image.asset('assets/images/img_14.png', fit: BoxFit.cover),
                  Image.asset('assets/images/img_14.png', fit: BoxFit.cover),
                  Image.asset('assets/images/img_14.png', fit: BoxFit.cover),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'التمارين المتاحة'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
                itemBuilder: (context, index) {
                  return buildExerciseGridItem(context, index);
                },
              ),
            ],
          ),
        ),
      ),)
    );
  }

  Widget buildExerciseGridItem(BuildContext context, int index) {
    String itemName = 'Exercise ${index + 1}';
    String imageUrl = 'https://example.com/exercise_image_$index.jpg';

    return Card(
      child: InkWell(
        onTap: () {
          print('Tapped on $itemName');
        },
        child: Column(
          children: [
            Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              itemName,
              textAlign: TextAlign.center,
              style:Theme.of(context).textTheme.headline6,

            ),
            
          ],
        ),
      ),
    );
  }
}
