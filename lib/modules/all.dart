import 'package:blessmate/modules/yogawrites.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/main_text_form.dart';
import '../widgets/progress_button.dart';
import 'appointment_view.dart';
import 'breathewrites.dart';
import 'gem.dart';
import 'imagine.dart';
import 'musiq.dart';
import 'musiqwrite.dart';
import 'yoga.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  late FirebaseFirestore _firestore;
  late CollectionReference _itemsCollection;

  List<Widget> pages = [Gym(), Yoga(), Musiq(), ExerciseScreen()];
  List<Widget> Writes = [ DeepBreathingBenefitsPage(), YogaBenefitsPage(), MusicTherapyPage()];

  TextEditingController searchController = TextEditingController();

  List<String> itemNames = [];
  List<String> itemImages = [];
  List<String> displayNames = [];
  List<String> displayImages = [];


  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _itemsCollection = _firestore.collection('items');
    _loadItemsData();
    getSavedTherapistData();
  }
// تعريف المتغيرات لحفظ بيانات المعالج
  String therapistFirstName = 'Unknown';
  String therapistLastName = 'Therapist';
  String therapistSpeciality = 'speciliaty un known';
  String therapistYearsExperience = '5 years';
  String therapistPhotoUrl = '';



  void getSavedTherapistData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // استرجاع البيانات من SharedPreferences
    setState(() {
      therapistFirstName = prefs.getString('therapistFirstName') ?? '';
      therapistLastName = prefs.getString('therapistLastName') ?? '';
      therapistPhotoUrl = prefs.getString('therapistPhotoUrl') ?? '';
      therapistSpeciality = prefs.getString('therapistSpeciality') ?? '';
      therapistYearsExperience = prefs.getString('therapistYearsExperience') ?? '';

    });
  }

  Future<void> _loadItemsData() async {
    try {
      QuerySnapshot itemsSnapshot = await _itemsCollection.get();

      if (itemsSnapshot.size > 0) {
        List<String> names = [];
        List<String> images = [];

        itemsSnapshot.docs.forEach((doc) {
          names.add(doc['name']);
          images.add(doc['image']);
        });

        setState(() {
          itemNames = names;
          itemImages = images;
          displayNames = List.from(itemNames);
          displayImages = List.from(itemImages);
        });
      } else {
        print('No items data available in Firestore.');
      }
    } catch (e) {
      print('Error loading items data: $e');
    }
  }

  void searchItems(String searchText) {
    List<String> searchResultsNames = [];
    List<String> searchResultsImages = [];

    for (int i = 0; i < itemNames.length; i++) {
      if (itemNames[i].toLowerCase().contains(searchText.toLowerCase())) {
        searchResultsNames.add(itemNames[i]);
        searchResultsImages.add(itemImages[i]);
      }
    }

    setState(() {
      displayNames = searchResultsNames;
      displayImages = searchResultsImages;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: MainTextField(
                        controller: searchController,
                        fillColor:Theme.of(context).backgroundColor,
                        borderRadius: 21,
                        hint: "بحث".tr,

                        prefixIcon: Icon(
                          Iconsax.search_normal,
                          color: Colors.cyan,
                        ),
                        suffixIcon: Icon(
                          Iconsax.sort,
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AppProgressButton(
                      height: 38,
                      width: 75,
                      fontSize: 13,
                      text: "بحث".tr,
                      onPressed: (anim) {
                        searchItems(searchController.text);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CarouselSlider(
                items: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentView()));
                    },
                    child: Image.asset(
                      "assets/images/baner1.jpg",
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentView()));
                    },
                    child: Image.asset(
                      "assets/images/banner2.jpg",
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentView()));
                    },
                    child: Image.asset(
                      "assets/images/baner3.jpg",
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 130,
                  initialPage: 0,
                  reverse: false,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 8),
                  autoPlayAnimationDuration: Duration(seconds: 4),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "افضل اطباء النفس".tr,
                style: Theme.of(context).textTheme.bodyText1,
              ),
// إضافة حقل لعرض بيانات المعالج
              Container(
                width: 220,
                height: 100,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).backgroundColor!,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 50,
                          height: 90,
                          color: Colors.grey[300], // لون الخلفية للصورة إذا لم تكن متاحة
                          child: therapistPhotoUrl != null
                              ? Image.network(
                            therapistPhotoUrl,
                            fit: BoxFit.cover,
                          )
                              : Icon(Icons.person, size: 30, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ' $therapistLastName $therapistFirstName',
                            style: Theme.of(context).textTheme.headline6,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '$therapistSpeciality',
                            style: Theme.of(context).textTheme.button,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "$therapistYearsExperience",
                            style: Theme.of(context).textTheme.headline6,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),
              Text(
                "المساعدات النفسية".tr,
                style:  Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: itemNames.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the appropriate page when the item is tapped
                        Get.to(() => Writes[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                itemImages[index],
                                height: 200,
                                width: 250, // Adjust width as needed
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              child: Text(
                                itemNames[index],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
