import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class EnterCodeDialog extends StatefulWidget {
  const EnterCodeDialog({super.key});

  @override
  State<EnterCodeDialog> createState() => _EnterCodeDialogState();
}

class _EnterCodeDialogState extends State<EnterCodeDialog> {
  late TextEditingController _char1;
  late TextEditingController _char2;
  late TextEditingController _char3;
  late TextEditingController _char4;
  late TextEditingController _char5;
  late TextEditingController _char6;

  @override
  void initState() {
    _char1 = TextEditingController();
    _char2 = TextEditingController();
    _char3 = TextEditingController();
    _char4 = TextEditingController();
    _char5 = TextEditingController();
    _char6 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _char1.dispose();
    _char2.dispose();
    _char3.dispose();
    _char4.dispose();
    _char5.dispose();
    _char6.dispose();
    super.dispose();
  }

  pasteCode() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      final text = value!.text;
      _char1.value = TextEditingValue(text: text![0]);
      _char2.value = TextEditingValue(text: text[1]);
      _char3.value = TextEditingValue(text: text[2]);
      _char4.value = TextEditingValue(text: text[3]);
      _char5.value = TextEditingValue(text: text[4]);
      _char6.value = TextEditingValue(text: text[5]);
    });

    FocusScope.of(context).unfocus();
  }

  pairPartner() async {
    Map<String, dynamic>? data;
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    CollectionReference coupleInfo =
        FirebaseFirestore.instance.collection('coupleInfo');
    User userData = FirebaseAuth.instance.currentUser!;

    //get the code enter in the textfield
    String code = _char1.text +
        _char2.text +
        _char3.text +
        _char4.text +
        _char5.text +
        _char6.text;

    //get the partner information
    await user
        .where('pairCode', isEqualTo: code)
        .get()
        .then((QuerySnapshot querySnapshot) {
      data = querySnapshot.docs.first.data() as Map<String, dynamic>?;
      print(data);
    });

    await coupleInfo.get().then((QuerySnapshot snapshot) {
      //update self partner id and connection status
      user
          .doc(userData.uid)
          .update({'connectedId': data!['uid'], 'connected': true});

      //update partner's id and connection status
      user
          .doc(data!['uid'])
          .update({'connectedId': userData.uid, 'connected': true});

      //create a new collection for store the information related to this two accounts
      coupleInfo.doc('couple${snapshot.docs.length + 1}').set({
        'docid': 'couple${snapshot.docs.length + 1}',
        'id1': userData.uid,
        'id2': data!['uid'],
        'anniversaryDate': '',
        'totalDays': '',
      });
      coupleInfo
          .doc('couple${snapshot.docs.length + 1}')
          .collection('task')
          .doc(userData.uid + data!['uid'])
          .set({
        'id1': userData.uid,
        'id2': data!['uid'],
      });
      coupleInfo
          .doc('couple${snapshot.docs.length + 1}')
          .collection('task')
          .doc(data!['uid'] + userData.uid)
          .set({
        'id1': data!['uid'],
        'id2': userData.uid,
      });
    });

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetAnimationDuration: const Duration(milliseconds: 500),
      elevation: 10,
      child: Container(
        width: double.infinity,
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Please Enter Your Partner Code',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: TextField(
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          UpperCaseTextFormatter(),
                        ],
                        controller: _char1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          UpperCaseTextFormatter(),
                        ],
                        controller: _char2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          UpperCaseTextFormatter(),
                        ],
                        controller: _char3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          UpperCaseTextFormatter(),
                        ],
                        controller: _char4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          UpperCaseTextFormatter(),
                        ],
                        controller: _char5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).unfocus();
                          }
                        }),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          UpperCaseTextFormatter(),
                        ],
                        controller: _char6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () => pasteCode(),
                  icon: const Icon(
                    Icons.paste,
                    size: 22,
                  ),
                  label: const Text(
                    'Paste Code',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        fixedSize: Size(constraints.maxWidth * 0.48, 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(constraints.maxWidth * 0.48, 20),
                      ),
                      onPressed: () => pairPartner(),
                      child: const Text('Confirm'),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
