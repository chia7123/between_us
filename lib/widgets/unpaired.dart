import 'package:between_us/widgets/enter_code_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnpairedWidget extends StatefulWidget {
  const UnpairedWidget({super.key, this.data});

  final data;

  @override
  State<UnpairedWidget> createState() => _UnpairedWidgetState();
}

class _UnpairedWidgetState extends State<UnpairedWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showDialogBox() {
    showDialog(context: context, builder: (_) => const EnterCodeDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(color: Colors.black45, blurRadius: 15.0),
                  ],
                ),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 3,
                      ),
                      Text(
                        widget.data['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Text.rich(
                            TextSpan(children: [
                              WidgetSpan(
                                child: FaIcon(
                                  FontAwesomeIcons.linkSlash,
                                  size: 18,
                                ),
                              ),
                              TextSpan(
                                text: '    Not connected',
                              ),
                            ]),
                          ),
                          const Spacer(),
                          Container(
                            height: 20,
                            width: 2,
                            color: Colors.black45,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Text(
                                'Pair Code : ',
                              ),
                              Text(
                                '${widget.data['pairCode']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(constraints.maxWidth * 0.9, 45),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () => showDialogBox(),
                        label: const Text(
                          'Pair with Him/Her',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        icon: const FaIcon(FontAwesomeIcons.solidHeart,
                            color: Colors.white),
                      ),
                      const Spacer(),
                    ],
                  );
                }),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.data['photoUrl']),
                radius: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
