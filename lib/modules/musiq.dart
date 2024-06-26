import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Musiq extends StatefulWidget {
  @override
  _MusiqState createState() => _MusiqState();
}

class _MusiqState extends State<Musiq> {
  late FirebaseFirestore _firestore;
  late CollectionReference _musiqCollection;
  Map<String, String> favoriteItemsDetails = {};


  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _musiqCollection = _firestore.collection('musiq');
    _loadMusiqData();
  }

  List<String> itemNames = [];
  List<String> itemImages = [];
  List<String> itemVideos = [];
  List<String> itemDescriptions = [];


  Future<void> _loadMusiqData() async {
    try {
      QuerySnapshot musiqSnapshot = await _musiqCollection.get();

      if (musiqSnapshot.size > 0) {
        musiqSnapshot.docs.forEach((doc) {
          itemNames.add(doc['name']);
          itemImages.add(doc['image']);
          itemVideos.add(doc['videoUrl']);
          itemDescriptions.add(doc['description']);
        });

        setState(() {
          // Update state with fetched data
          this.itemNames = itemNames;
          this.itemImages = itemImages;
          this.itemVideos = itemVideos;
          this.itemDescriptions = itemDescriptions;
        });
      } else {
        print('No data available in Firestore.');
      }
    } catch (e) {
      print('Error loading musiq data: $e');
    }
  }


  void addPlaylist(String playlistName) {
    // Your existing addPlaylist logic
    print('تمت إضافة قائمة جديدة: $playlistName'.tr);
  }
  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      // يمكنك هنا تنفيذ الإجراءات الخاصة بالملف الصوتي المختار
      print('تم اختيار ملف صوتي: ${result.files.first.name}'.tr);
    } else {
      // المستخدم لم يقم بتحديد ملف صوتي
      print('لم يتم اختيار أي ملف صوتي.'.tr);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteItemsPage(
                              favoriteItemsDetails: favoriteItemsDetails,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "الموسيقى المفضلة لديك".tr,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: HexColor('06B4D8'),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoriteItemsPage(favoriteItemsDetails: {},

                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "استكشف".tr,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        buildItem(context, index),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: itemNames.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(context, int index) {
    // Your existing buildItem logic
    final String itemName = itemNames[index];
    final String imageUrl = itemImages[index];
    final bool isFavorite = favoriteItemsDetails.containsKey(itemName);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailPage(
              title: itemName,
              imagePath: imageUrl,
              description: itemDescriptions[index],
              videoUrl: itemVideos[index],
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(itemName, style: Theme.of(context).textTheme.headline6),
        contentPadding: EdgeInsets.all(0),
        leading: Container(
          width: 80,  // Set the width according to your preference
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              if (isFavorite) {
                favoriteItemsDetails.remove(itemName);
              } else {
                favoriteItemsDetails[itemName] =imageUrl ;
              }
            });
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: HexColor('06B4D8'),
          ),
        ),
      ),
    );
  }
}

class VideoDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final String videoUrl;

  const VideoDetailPage({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.videoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
        style: Theme.of(context).textTheme.bodyText1),
        centerTitle: true,
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
              style: Theme.of(context).textTheme.bodyText1,
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

  VideoPlayerScreen({required this.videoUrl});

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


class FavoriteItemsPage extends StatelessWidget {
  final Map<String, String> favoriteItemsDetails;

  const FavoriteItemsPage({Key? key, required this.favoriteItemsDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الموسيقى المفضلة لديك'.tr,
        style: Theme.of(context).textTheme.bodyText1),
      ),
      body: ListView.builder(
        itemCount: favoriteItemsDetails.length,
        itemBuilder: (context, index) {
          final itemName = favoriteItemsDetails.keys.elementAt(index);
          final imagePath = favoriteItemsDetails[itemName];

          return ListTile(
            title: Text(itemName),
              leading: Container(
                width: 80,  // Set the width according to your preference
                child: Image.network(
                  imagePath!,
                  fit: BoxFit.fill,
                ),
              )
            // إضافة تفاصيل إضافية إذا لزم الأمر
          );
        },
      ),
    );
  }
}


