import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BirthdayButton extends StatefulWidget {
  BirthdayButton({super.key, required this.uid, required this.isDob, this.dob});

  final String uid;
  final bool isDob;
  DateTime? dob;

  @override
  State<BirthdayButton> createState() => _BirthdayButtonState();
}

class _BirthdayButtonState extends State<BirthdayButton> {
  CollectionReference userInfo = FirebaseFirestore.instance.collection('users');

  updateDob([DateTime? dob]) {
    DateTime? pickedDate;
    showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    ).then((value) {
      pickedDate = value;
      if (pickedDate != null) {
        setState(() async {
          await userInfo.doc(widget.uid).update({'dob': pickedDate});
          Fluttertoast.showToast(msg: 'Birthday Set.');
        });
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDob
        ? TextButton.icon(
            onPressed: () => updateDob(widget.dob),
            icon: const FaIcon(FontAwesomeIcons.cakeCandles),
            label: Text(
              DateFormat('yyyy-MM-dd').format(widget.dob!),
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => updateDob(),
            child: const Text(
              'Set Your Birthday',
              style: TextStyle(fontSize: 12),
            ),
          );
  }
}
