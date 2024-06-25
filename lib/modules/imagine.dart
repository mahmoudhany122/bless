import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late FirebaseFirestore _firestore;
  late CollectionReference _exerciseCollection;
  final RxList<String> itemNames = <String>[].obs;
  final RxList<String> itemImages = <String>[].obs;
  final RxList<String> itemDescriptions = <String>[].obs;
  final RxList<String> itemVideoUrls = <String>[].obs; // أضف هذا السطر

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _exerciseCollection = _firestore.collection('exercise');
    _loadExerciseData();
  }

  Future<void> _loadExerciseData() async {
    try {
      QuerySnapshot exercisesSnapshot = await _exerciseCollection.get();

      if (exercisesSnapshot.size > 0) {
        itemNames.clear();
        itemImages.clear();
        itemDescriptions.clear();
        itemVideoUrls.clear(); // أضف هذا السطر

        exercisesSnapshot.docs.forEach((doc) {
          itemNames.add(doc['name']);
          itemImages.add(doc['image']);
          itemDescriptions.add(doc['description']);
          itemVideoUrls.add(doc['videoUrl']); // استرجاع عناوين الفيديو
        });
      } else {
        print('No exercise data available in Firestore.');
      }
    } catch (e) {
      print('Error loading exercise data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                items: itemImages.map((imageUrl) {
                  return Image.network(imageUrl, fit: BoxFit.cover);
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'التمارين المتاحة'.tr,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 10),
              Obx(() => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.95,
                ),
                itemCount: itemNames.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildExerciseGridItem(context, index);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExerciseGridItem(BuildContext context, int index) {
    String itemName = itemNames[index];
    String imageUrl = itemImages[index];
    String description = itemDescriptions[index];
    String videoUrl = itemVideoUrls[index]; // استخراج عنوان الفيديو

    return Card(
      child: InkWell(
        onTap: () {
          Get.to(ExerciseDetailsScreen(
            name: itemName,
            image: imageUrl,
            description: description,
            videoUrl: videoUrl, // تمرير عنوان الفيديو
          ));
        },
        child: Column(
          children: [
            Image.network(
              imageUrl,
              width: 125,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              itemName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetailsScreen extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String videoUrl; // أضف هذا السطر

  ExerciseDetailsScreen({
    required this.name,
    required this.image,
    required this.description,
    required this.videoUrl, // أضف هذا السطر
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoPlayerScreen(videoUrl: videoUrl), // تمرير عنوان الفيديو
            SizedBox(
              height: 20,
            ),
            Text(
              'ملخص:'.tr,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl; // أضف هذا السطر

  const VideoPlayerScreen({required this.videoUrl}); // قم بتحديث الكونستراكتور

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width /
          _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.fullscreen, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.setLooping(true);
                      _controller.setVolume(2.0);
                      _controller.setPlaybackSpeed(1.0);
                      _controller.play();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fast_forward, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.seekTo(Duration(
                          seconds: _controller.value.position.inSeconds +
                              10));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.pause();
                      _controller.seekTo(Duration.zero);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fast_rewind, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.seekTo(Duration(
                          seconds: _controller.value.position.inSeconds -
                              10));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}