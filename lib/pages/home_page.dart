import 'package:between_us/pages/paired_profile.dart';
import 'package:between_us/widgets/unpaired_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User userInfo = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    Map<String, dynamic> data = {
      'uid': userInfo.uid,
      'name': userInfo.displayName,
      'email': userInfo.email,
      'photoUrl': userInfo.photoURL,
      'pairCode': userInfo.uid.substring(userInfo.uid.length - 6).toUpperCase(),
      'connected': false,
      'connectedId': null,
      'points': 0,
      'gender': 'unknown',
      'dob': '',
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userInfo.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userInfo.uid)
            .set(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userInfo.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else {
            if (snapshot.data!.exists) {
              final data = snapshot.data!.data();
              return data?['connected']
                  ? PairedProfilePage(
                      data: data,
                    )
                  : UnpairedProfileCard(
                      data: data,
                    );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          }
        });
  }
}
