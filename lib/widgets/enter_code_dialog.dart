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
                            FocusScope.of(context).nextFocus();
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
                      onPressed: () {},
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
