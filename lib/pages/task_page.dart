import 'package:between_us/pages/add_task_page.dart';
import 'package:flutter/material.dart';
import 'package:between_us/pages/hero_dialog_route.dart';

class ViewTaskPage extends StatefulWidget {
  const ViewTaskPage({super.key});

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.green,
        child: ListView(
          children: const <Widget>[
            Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(title: Text('Important'))),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 72.0),
                title: Text('Three-line ListTile'),
                subtitle:
                    Text('A sufficiently long subtitle warrants three lines.'),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 72.0),
                title: Text('Three-line ListTile'),
                subtitle:
                    Text('A sufficiently long subtitle warrants three lines.'),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(title: Text('Your tasks'))),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 72.0),
                title: Text('Three-line ListTile'),
                subtitle:
                    Text('A sufficiently long subtitle warrants three lines.'),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 252, 179, 248),
        hoverColor: Colors.purple,
        heroTag: 'add-task-hero',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const AddTaskPage();
          }));
        },
      ),
    );
  }
}
