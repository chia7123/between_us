
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'birthday_button.dart';
import 'circular_profile_image.dart';

class CoupleInfoCard extends StatefulWidget {
  const CoupleInfoCard({super.key, required this.data, required this.partnerData});
  final data;
  final partnerData;
  

  @override
  State<CoupleInfoCard> createState() => _CoupleInfoCardState();
}

class _CoupleInfoCardState extends State<CoupleInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Colors.black45, blurRadius: 15.0),
                ],
              ),
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                  children: [
                    const Spacer(
                      flex: 4,
                    ),
                    //self
                    Column(
                      children: [
                        const Spacer(
                          flex: 6,
                        ),
                        Text(
                          widget.data['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        widget.data['dob'] == ''
                            ? BirthdayButton(
                                uid: widget.data['uid'], isDob: false)
                            : BirthdayButton(
                                uid: widget.data['uid'],
                                isDob: true,
                                dob: widget.data['dob'].toDate(),
                              ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    //partner
                    Column(
                      children: [
                        const Spacer(
                          flex: 6,
                        ),
                        Text(
                          widget.partnerData!['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        widget.partnerData['dob'] == ''
                            ? BirthdayButton(
                                uid: widget.partnerData['uid'], isDob: false)
                            : BirthdayButton(
                                uid: widget.partnerData['uid'],
                                isDob: true,
                                dob: widget.partnerData['dob'].toDate(),
                              ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                  ],
                );
              }),
            ),
          ),
          Positioned(
            top: 8,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  const Spacer(flex: 4),
                  //self image
                  CircularProfileImage(
                    photoUrl: widget.data['photoUrl'],
                  ),
                  const Spacer(),
                  //heart icon
                  const FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Color.fromARGB(255, 255, 145, 182),
                    size: 30,
                  ),
                  const Spacer(),
                  //partner image
                  CircularProfileImage(
                    photoUrl: widget.partnerData!['photoUrl'],
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
