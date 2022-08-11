import 'package:between_us/pages/completed_task_page.dart';
import 'package:between_us/pages/home_page.dart';
import 'package:between_us/pages/profile_page.dart';
import 'package:between_us/pages/store_page.dart';
import 'package:between_us/pages/task_page.dart';
import 'package:between_us/provider/google_sign_in.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationControllerPage extends StatefulWidget {
  const NavigationControllerPage({super.key});

  @override
  State<NavigationControllerPage> createState() =>
      _NavigationControllerPageState();
}

class _NavigationControllerPageState extends State<NavigationControllerPage> {
  int selectedPos = 0;

  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", const Color.fromARGB(255, 252, 179, 248)),
    TabItem(Icons.article_outlined, "Task",
        const Color.fromARGB(255, 252, 179, 248)),
    TabItem(Icons.store, "Store", const Color.fromARGB(255, 252, 179, 248)),
    TabItem(Icons.history, "History", const Color.fromARGB(255, 252, 179, 248)),
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
    Widget page = const HomePage();
    switch (selectedPos) {
      case 0:
        setState(() {
          page = const HomePage();
        });
        break;
      case 1:
        page = const ViewTaskPage();
        break;
      case 2:
        page = const StorePage();
        break;
      case 3:
        page = const CompletedTaskPage();
        break;
      default:
        break;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        toolbarHeight: 45,
        title: const Text('Between Us'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
          },
          icon: const Icon(Icons.power_settings_new),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: Stack(
        children: [
          page,
          Positioned(
            bottom: 0,
            child: bottomNav(),
          ),
        ],
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      circleSize: 48,
      iconsSize: 22,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: 50,
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
}
