import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';

class Musiq extends StatefulWidget {
  @override
  _MusiqState createState() => _MusiqState();
}

class _MusiqState extends State<Musiq> {
  final List<String> itemNames = [
    'Meditation et Relaxation',
    'The Sound of Rain',
    'A Gentle Sunlight',
    'Dandelions',
    'Chasing Clouds',
  ];

  final List<String> itemImages = [
    'assets/musiq/img.png',
    'assets/musiq/img_1.png',
    'assets/musiq/img_2.png',
    'assets/musiq/img_6.png',
    'assets/musiq/img.png',
  ];

  final List<String> itemVideos = [
    'assets/videos/VID_20231124_232251_830.mp4',
    'assets/videos/VID_20231124_232251_830.mp4',
    'assets/videos/VID_20231124_232251_830.mp4',
    'assets/videos/VID_20231124_232251_830.mp4',
    'assets/videos/VID_20231124_232251_830.mp4',
  ];

  final List<String> itemDescriptions = [
    'وصف الفيديو 1 يأتي هنا...',
    'وصف الفيديو 2 يأتي هنا...',
    'وصف الفيديو 3 يأتي هنا...',
    'وصف الفيديو 4 يأتي هنا...',
    'وصف الفيديو 5 يأتي هنا...',
  ];

  Map<String, String> favoriteItemsDetails = {};

  void addPlaylist(String playlistName) {
    // يمكنك هنا تنفيذ الإجراءات الخاصة بإضافة القائمة الجديدة
    print('تمت إضافة قائمة جديدة: $playlistName');
  }

  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      // يمكنك هنا تنفيذ الإجراءات الخاصة بالملف الصوتي المختار
      print('تم اختيار ملف صوتي: ${result.files.first.name}');
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "اضافة قائمة تشغيل جديدة".tr,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: HexColor('06B4D8'),
                  child: TextButton(
                    onPressed: () {
                      // عند الضغط على زرار الإضافة قائمة جديدة
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('إضافة قائمة جديدة'.tr),
                            content: TextField(
                              onChanged: (value) {
                                // يمكنك استخدام القيمة المدخلة هنا
                              },
                              decoration: InputDecoration(
                                hintText: 'اسم القائمة'.tr,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('إلغاء'.tr),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // استخدم القيمة المدخلة لإضافة القائمة
                                  addPlaylist('اسم القائمة'.tr);
                                },
                                child: Text('إضافة'.tr),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                          builder: (context) => FavoriteItemsPage(
                            favoriteItemsDetails: favoriteItemsDetails,
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
    ));
  }

  Widget buildItem(context, int index) {
    final String itemName = itemNames[index];
    final String imagePath = itemImages[index];
    final bool isFavorite = favoriteItemsDetails.containsKey(itemName);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailPage(
              title: itemName,
              imagePath: imagePath,
              description: itemDescriptions[index],
              videoUrl: itemVideos[index],
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(itemName, style: Theme.of(context).textTheme.headline6),
        leading: Image.asset(
          imagePath,
          height: 50,
          width: 50,
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              if (isFavorite) {
                favoriteItemsDetails.remove(itemName);
              } else {
                favoriteItemsDetails[itemName] = imagePath;
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

  void _showAddPlaylistDialog(BuildContext context) async {
    TextEditingController playlistNameController = TextEditingController();
    String? filePath;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("إضافة قائمة تشغيل جديدة".tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: playlistNameController,
                decoration: InputDecoration(
                  hintText: "اسم القائمة".tr,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.audio);

                  if (result != null) {
                    setState(() {
                      filePath = result.files.single.path;
                    });
                  }
                },
                child: Text("اختيار ملف صوتي".tr),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("إلغاء".tr),
            ),
            TextButton(
              onPressed: () {
                String playlistName = playlistNameController.text;
                // قم بتنفيذ الخطوات اللازمة لحفظ القائمة والملف الصوتي (filePath)
                // TODO: يجب تحقيق ذلك في طبقة إدارة الحالة أو بواسطة مدير حالة إذا كنت تستخدمه
                // يمكنك استخدام filePath و playlistName للقيام باللازم
                Navigator.pop(context);
              },
              child: Text("إضافة".tr),
            ),
          ],
        );
      },
    );
  }
}

class VideoDetailPage extends StatefulWidget {
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
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        // تأكد من عرض الإطار الأول بعد تهيئة الفيديو.
        setState(() {});
      });

    // استخدم البرنامج التحكم لتكرار الفيديو.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
              SizedBox(height: 16),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "لمحة عامة".tr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    widget.description,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Text(_controller.value.isPlaying ? 'إيقاف'.tr : 'تشغيل'.tr),
              ),
            ],
          ),
        ),
      ),
    );
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
        title: Text('الموسيقى المفضلة لديك'.tr),
      ),
      body: ListView.builder(
        itemCount: favoriteItemsDetails.length,
        itemBuilder: (context, index) {
          final itemName = favoriteItemsDetails.keys.elementAt(index);
          final imagePath = favoriteItemsDetails[itemName];

          return ListTile(
            title: Text(itemName),
            leading: Image.asset(
              imagePath!,
              height: 50,
              width: 50,
            ),
            // إضافة تفاصيل إضافية إذا لزم الأمر
          );
        },
      ),
    );
  }
}
