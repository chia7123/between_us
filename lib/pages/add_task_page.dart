import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-task-hero';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'New Task Title',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Add detail',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Point'),
                        CustomNumberPicker(
                          initialValue: 5,
                          maxValue: 100,
                          minValue: 0,
                          step: 5,
                          onValue: (value) {},
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
