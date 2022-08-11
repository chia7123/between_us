import 'dart:io';

import 'package:between_us/widgets/circular_profile_image.dart';
import 'package:between_us/widgets/profile_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

final uid = FirebaseAuth.instance.currentUser!.uid;
Stream<DocumentSnapshot> _userStream =
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

class _UserProfileState extends State<UserProfile> {
  late String name;
  late DateTime dob;
  late String photoUrl;
  late File newImage;
  bool isUpload = false;
  bool buttonDisable = true;

  getNewProfileInfo(String newName, DateTime newDate, bool newButtonDisable) {
    name = newName;
    dob = newDate;
    buttonDisable = newButtonDisable;
  }

  saveProfile() async {
    if (!buttonDisable) {
      if (isUpload) {
        await uploadPhoto();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'name': name, 'dob': dob, 'photoUrl': photoUrl});
        Fluttertoast.showToast(msg: 'Profile Updated');
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'name': name, 'dob': dob, 'photoUrl': photoUrl});
        Fluttertoast.showToast(msg: 'Profile Updated');
      }
    }
  }

  void _showdialog() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      elevation: 12,
      builder: (ctx) {
        return SizedBox(
          height: 115,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera')),
              const Divider(),
              TextButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.album),
                  label: const Text('Gallery')),
            ],
          ),
        );
      },
    );
  }

  pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: source,
        imageQuality: 100,
      );

      if (pickedImage == null) return;

      setState(() {
        newImage = File(pickedImage.path);
        isUpload = true;
        Navigator.pop(context);
      });
      buttonDisable = false;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to pick image :$e');
    }
  }

  Future uploadPhoto() async {
    final imageStorage = FirebaseStorage.instance
        .ref()
        .child('user_profile_image')
        .child('$uid.jpg');

    await imageStorage.putFile(newImage);
    photoUrl = await imageStorage.getDownloadURL();
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      var data = documentSnapshot.data() as Map<String, dynamic>?;
      name = data!['name'];
      dob = data['dob'].toDate();
      photoUrl = data['photoUrl'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final userData = snapshot.data;
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    toolbarHeight: 45,
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    actions: [
                      TextButton(
                        onPressed: () => buttonDisable ? null : saveProfile(),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  body: Container(
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isUpload
                            ? CircularProfileImage(
                                newImage: newImage,
                              )
                            : CircularProfileImage(
                                photoUrl: userData!['photoUrl']),
                        TextButton(
                          onPressed: () => _showdialog(),
                          child: const Text(
                            'Change Profile Photo',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        ProfileInfoCard(
                          newInfo: getNewProfileInfo,
                          userData: userData,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          return const Center(child: Text('Something went wrong.'));
        });
  }
}
