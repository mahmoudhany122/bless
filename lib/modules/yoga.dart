import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Yoga extends StatefulWidget {
  const Yoga({Key? key});

  @override
  State<Yoga> createState() => _YogaState();
}

class _YogaState extends State<Yoga> {
  late FirebaseFirestore _firestore;
  late CollectionReference _imagineCollection;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _imagineCollection = _firestore.collection('imagine');
    _loadImagineData(); // Call the function here to load exercise data
  }

  Future<void> _loadImagineData() async {
    try {
      QuerySnapshot imagineSnapshot = await _imagineCollection.get();

      if (imagineSnapshot.size > 0) {
        // Clear previous exercise data
        itemNames.clear();
        itemImages.clear();
        itemVideoUrls.clear();
        itemDescriptions.clear();

        imagineSnapshot.docs.forEach((doc) {
          itemNames.add(doc['name']);
          itemImages.add(doc['image']);
          itemVideoUrls.add(doc['videoUrl']);
          itemDescriptions.add(doc['description']); // Add description to list
        });

        setState(() {
          // Update state with fetched data
        });
      } else {
        print('No exercise data available in Firestore.');
      }
    } catch (e) {
      print('Error loading imagine data: $e');
    }
  }

  List<String> itemNames = [];
  List<String> itemImages = [];
  List<String> itemVideoUrls = [];
  List<String> itemDescriptions = []; // List to hold descriptions

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
                'تمارين',
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
                'التمارين المتاحة',
                style: Theme.of(context).textTheme.headline6,
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
                  return buildImagineGridItem(context, index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImagineGridItem(BuildContext context, int index) {
    String itemName = itemNames[index];
    String imageUrl = itemImages[index];
    String videoUrl = itemVideoUrls[index];
    String description = itemDescriptions[index]; // Get description

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetailsScreen(
                name: itemName,
                image: imageUrl,
                description: description, // Pass description
                videoUrl: videoUrl,
              ),
            ),
          );
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
              maxLines: 2,
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
            VideoPlayerScreen(videoUrl: videoUrl),
            SizedBox(height: 20),
            Text(
              'ملخص:',
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
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    _initializeVideoPlayerFuture = _controller.initialize();
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
                      _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds + 10));
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
                      _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds - 10));
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
