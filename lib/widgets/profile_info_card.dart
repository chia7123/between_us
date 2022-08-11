import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileInfoCard extends StatefulWidget {
  const ProfileInfoCard({super.key, required this.newInfo, this.userData});

  final Function(String, DateTime, bool) newInfo;
  final userData;

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  late DateTime newDob;
  late String newName;
  late bool newButtonDisable;

  newInfo() {
    newName = _name.text;
    newButtonDisable = false;
    widget.newInfo(newName, newDob, newButtonDisable);
  }

  updateDob(DateTime dob) {
    DateTime? pickedDate;
    showDatePicker(
      context: context,
      initialDate: dob,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    ).then((value) {
      pickedDate = value;
      if (pickedDate != null) {
        setState(() {
          newDob = pickedDate!;
          _dob.value =
              TextEditingValue(text: DateFormat('yyyy-MM-dd').format(newDob));
          newInfo();
        });
      }
      return;
    });
  }

  @override
  void initState() {
    newDob = widget.userData['dob'].toDate();
    _name.value = TextEditingValue(text: widget.userData['name']);
    _dob.value = TextEditingValue(
        text: DateFormat('yyyy-MM-dd').format(newDob).toString());
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name',
            style: TextStyle(fontSize: 15),
          ),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              isDense: true,
            ),
            autocorrect: false,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) => newInfo(),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Date of Birth',
            style: TextStyle(fontSize: 15),
          ),
          TextField(
            controller: _dob,
            decoration: InputDecoration(
                isDense: true,
                icon: IconButton(
                  onPressed: () => updateDob(newDob),
                  icon: Icon(
                    Icons.calendar_month,
                    size: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
