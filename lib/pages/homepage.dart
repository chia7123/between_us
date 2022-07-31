import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  CollectionReference Fdata = FirebaseFirestore.instance.collection('data');

  saveData() {
    var data = 'data';

    return Fdata.add({
      'data': data, // John Doe
    })
        .then((value) => print("data Added"))
        .catchError((error) => print("Failed to add data: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => saveData(), child: const Text('button'))
        ],
      ),
    );
  }
}
