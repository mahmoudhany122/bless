import 'package:blessmate/modules/yoga.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../widgets/main_text_form.dart';
import '../widgets/progress_button.dart';
import 'gem.dart';
import 'imagine.dart';
import 'musiq.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  late FirebaseFirestore _firestore;
  late CollectionReference _itemsCollection;

  List<Widget> pages = [Gym(), Yoga(), Musiq(), ExerciseScreen()];

  TextEditingController searchController = TextEditingController(); // إضافة تحكم لحقل البحث

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _itemsCollection = _firestore.collection('items');
    _loadItemsData(); // استدعاء الدالة هنا لتحميل البيانات
  }

  // دالة لتحميل البيانات من Firestore
  Future<void> _loadItemsData() async {
    try {
      QuerySnapshot itemsSnapshot = await _itemsCollection.get();

      if (itemsSnapshot.size > 0) {
        // مسح البيانات السابقة
        itemNames.clear();
        itemImages.clear();

        // استخراج البيانات من الوثائق وإضافتها إلى القوائم المحلية
        itemsSnapshot.docs.forEach((doc) {
          itemNames.add(doc['name']);
          itemImages.add(doc['image']);
        });

        setState(() {
          // تحديث الواجهة بعد جلب البيانات
        });
      } else {
        print('No items data available in Firestore.');
      }
    } catch (e) {
      print('Error loading items data: $e');
    }
  }

  List<String> itemNames = [];
  List<String> itemImages = [];

  // دالة للبحث وعرض النتائج
  void searchItems(String searchText) {
    List<String> searchResultsNames = [];
    List<String> searchResultsImages = [];

    for (int i = 0; i < itemNames.length; i++) {
      // يتم التحقق مما إذا كانت الكلمة المدخلة موجودة في اسم العنصر
      if (itemNames[i].toLowerCase().contains(searchText.toLowerCase())) {
        searchResultsNames.add(itemNames[i]);
        searchResultsImages.add(itemImages[i]);
      }
    }

    setState(() {
      // تحديث الواجهة لعرض النتائج
      itemNames = searchResultsNames;
      itemImages = searchResultsImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: MainTextField(
                    controller: searchController, // استخدام حقل التحكم لحقل البحث
                    fillColor: Colors.white,
                    borderRadius: 21,
                    hint: "بحث",
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
                  text: "Search",
                  onPressed: (anim) {
                    // استدعاء دالة البحث عند الضغط على زر البحث
                    searchItems(searchController.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: itemNames.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // انتقل إلى الصفحة المناسبة عند النقر على العنصر
                    Get.to(() => pages[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          itemImages[index],
                          width: 180,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          itemNames[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
    );
  }
}



