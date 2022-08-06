import 'package:between_us/pages/completed_task_page.dart';
import 'package:between_us/pages/home_page.dart';
import 'package:between_us/pages/redeem_page.dart';
import 'package:between_us/pages/task_page.dart';
import 'package:between_us/provider/google_sign_in.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationControllerPage extends StatefulWidget {
  NavigationControllerPage({super.key});

  @override
  State<NavigationControllerPage> createState() =>
      _NavigationControllerPageState();
}

class _NavigationControllerPageState extends State<NavigationControllerPage> {
  CollectionReference Fdata = FirebaseFirestore.instance.collection('data');
  int selectedPos = 0;

  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", Colors.pink[400]!),
    TabItem(Icons.article_outlined, "Task", Colors.pink[400]!),
    TabItem(Icons.card_giftcard_outlined, "Redeem", Colors.pink[400]!),
    TabItem(Icons.history, "History", Colors.pink[400]!),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget page = HomePage();
    switch (selectedPos) {
      case 0:
        setState(() {
          page = HomePage();
        });
        break;
      case 1:
        page = ViewTaskPage();
        break;
      case 2:
        page = RedeemPage();
        break;
      case 3:
        page = CompletedTaskPage();
        break;
      default:
        break;
    }

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: const Text('Between Us'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: page,
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: 55,
      barBackgroundColor: Colors.white,
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
          print(_navigationController.value);
        });
      },
    );
  }

  saveData() {
    var data = 'data';

    return Fdata.add({
      'data': data, // John Doe
    })
        .then((value) => print("data Added"))
        .catchError((error) => print("Failed to add data: $error"));
  }
}
