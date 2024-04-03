import 'package:blessmate/modules/signindoctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'logres.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoardingModel {
  final String image;
  final String title;
  final String title1;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.title1,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/img_3.png',
        title1: 'Bliss Mate',
        title: "لماذا".tr,
        body: ""),
    BoardingModel(
        image: 'assets/images/img_4.png',
        title1: 'Bliss Mate',
        title: "تولي مسؤولية رفاهيتك".tr,
        body:
            'Bliss Mate موجود هنا لدعمك في رحلتك نحو تحسين الصحة العقلية والرفاهية. بفضل مجموعة من الميزات والموارد، نساعدك على إعطاء الأولوية للرعاية الذاتية وإدارة التوتر وتعزيز التوازن العاطفي.'.tr),
    BoardingModel(
        image: 'assets/images/img_5.png',
        title1: 'Bliss Mate',
        title: "ابحث عن السلام مع".tr,
        body:
            'استكشف مكتبتنا من جلسات التأمل الموجهة المصممة لتقليل التوتر وتحسين التركيز وتعزيز الاسترخاء من خلال التقنيات التي يمكن أن تساعدك على تنمية الوعي باللحظة الحالية والعثور على الهدوء الداخلي وتعزيز'.tr),
    BoardingModel(
        image: 'assets/images/img_6.png',
        title1: 'Bliss Mate',
        title: "تواصل مع دكاتره متخصصين في".tr,
        body:
            'انضم إلى المناقشات، واطلب المشورة، معًا، يمكننا تقديم الدعم والتشجيع والإلهام في طريقك إلى العافية. أنـت لست وحيدا في هذا.'.tr),
  ];

  var boardController = PageController();
  bool Islast = false;

  double get radius => 20;

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (!isFirstTime) {
      // المستخدم قد شاهد صفحات Onboarding من قبل، قم بتوجيهه إلى الشاشة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInDoc(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => BuildBoardingItem(
                  boarding[index],
                ),
                physics: const RangeMaintainingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      Islast = true;
                    });
                    print('last index');
                  } else {
                    setState(() {
                      Islast = false;
                    });
                    print("is not last");
                  }
                },
                controller: boardController,
                itemCount: boarding.length,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInDoc(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(radius),
                  color: HexColor('00B4D8'),
                ),
                child: Center(
                  child: Text(
                    " تخطى ".tr,
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SmoothPageIndicator(
              controller: boardController,
              effect: ExpandingDotsEffect(
                dotColor: Colors.black26,
                activeDotColor: HexColor('00B4D8'),
                dotHeight: 12,
                strokeWidth: 9,
                radius: 8,
                expansionFactor: 1.5,
                dotWidth: 10,
                spacing: 10,
              ),
              count: boarding.length,
            ),
            Row(
              children: [
                const Spacer(),
                FloatingActionButton(
                  onPressed: () async {
                    if (Islast) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isFirstTime', false);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInDoc(),
                        ),
                      );
                    } else {
                      boardController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInToLinear,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              '${model.title}',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              '${model.title1}',
              style: TextStyle(
                color: HexColor('00B4D8'),
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${model.body}',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      );
}
