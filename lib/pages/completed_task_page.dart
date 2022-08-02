import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({super.key});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('completed task page'));
    
  }
}