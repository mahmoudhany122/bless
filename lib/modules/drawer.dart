
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'add_after_signu.dart';

class NavBarList extends StatefulWidget {
  @override
  State<NavBarList> createState() => _NavBarListState();
}

class _NavBarListState extends State<NavBarList> {
  File? imageSelect;

  final _imagePicker = ImagePicker();

  Future<void> pickImageCamera() async {
    final pickedImage =
    await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        imageSelect = File(pickedImage.path);
      }
    });
  }

  Future<void> pickImageGallery() async {
    final pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        imageSelect = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('mahmoud'),
              accountEmail: Text("mhoi9uiorujewuj"),
              currentAccountPicture:
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      child: imageSelect != null
                          ? Image.file(
                        imageSelect!,
                        width: 500,
                        height: 500,
                        fit: BoxFit.fill,
                      )
                          : Image.asset("assets/images/R.jpg"),
                      radius: 70,
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        pickImageCamera();
                        pickImageGallery();
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 15,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    radius: 13,
                    backgroundColor: Colors.grey[400],
                  ),
                ],
              ),
              onDetailsPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>AddInSignUp() ,));
              },
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.facebook, color: Colors.white),
              title: Text('Facebook Account'),
              textColor: Colors.white,
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.announcement_rounded),
              title: Text(
                "About the App",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.white),
              title: Text('Location'),
              textColor: Colors.white,
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share_rounded, color: Colors.white),
              title: Text("Share the App"),
              textColor: Colors.white,
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.developer_mode, color: Colors.white),
              title: Text("Developers"),
              textColor: Colors.white,
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.login_outlined, color: Colors.white),
              title: Text("Exit from the App"),
              textColor: Colors.white,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}