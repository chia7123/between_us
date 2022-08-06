import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      'connected': false,
      'connectedId': null,
      'points': 0,
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
    print(userInfo);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userInfo.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else {
            final data = snapshot.data!.data();
            return Column(
              children: [
                Container(
                  height: 250,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45, blurRadius: 15.0),
                            ],
                          ),
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Positioned(
                                  top: 70,
                                  child: Text(
                                    data?['name'],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(data?['photoUrl']),
                          radius: 50,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        });
  }
}
