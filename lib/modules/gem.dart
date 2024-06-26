import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Gym extends StatefulWidget {
  const Gym({Key? key}) : super(key: key);

  @override
  State<Gym> createState() => _GymState();
}

class _GymState extends State<Gym> {
  late FirebaseFirestore _firestore;
  late CollectionReference _exerciseCollection;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _exerciseCollection = _firestore.collection('gem');
    _loadExerciseData();
  }

  Future<void> _loadExerciseData() async {
    try {
      QuerySnapshot exercisesSnapshot = await _exerciseCollection.get();

      if (exercisesSnapshot.size > 0) {
        // Clear previous exercise data
        itemNames.clear();
        itemImages.clear();
        itemVideoUrls.clear();
        itemDescriptions.clear(); // Add this line

        exercisesSnapshot.docs.forEach((doc) {
          itemNames.add(doc['name']);
          itemImages.add(doc['image']);
          itemVideoUrls.add(doc['videoUrl']);
          itemDescriptions.add(doc['description']); // Store description
        });

        setState(() {
          // Update state with fetched data
        });
      } else {
        print('No exercise data available in Firestore.');
      }
    } catch (e) {
      print('Error loading exercise data: $e');
    }
  }

  List<String> itemNames = [];
  List<String> itemImages = [];
  List<String> itemVideoUrls = [];
  List<String> itemDescriptions = []; // Add this list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
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
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.95,
                ),
                itemCount: itemNames.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildExerciseGridItem(context, index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExerciseGridItem(BuildContext context, int index) {
    String itemName = itemNames[index];
    String imageUrl = itemImages[index];
    String description = itemDescriptions[index]; // Get description

    return Card(
      child: InkWell(
        onTap: () {
          String videoUrl = itemVideoUrls[index];
          String description = itemDescriptions[index]; // Pass description to details screen
          Get.to(ExerciseDetailsScreen(
            name: itemName,
            image: imageUrl,
            description: description, // Pass description
            videoUrl: videoUrl,
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
  final String videoUrl;

  ExerciseDetailsScreen({
    required this.name,
    required this.image,
    required this.description,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name,
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
            VideoPlayerScreen(videoUrl: videoUrl), // Pass videoUrl
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
  final String videoUrl;

  const VideoPlayerScreen({required this.videoUrl});

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
                  icon: Icon(Icons.fast_forward,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds + 10));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.pause();
                      _controller.seekTo(Duration.zero);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fast_rewind,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds - 10));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow,
                      color: Colors.white),
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
