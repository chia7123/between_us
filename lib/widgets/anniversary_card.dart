import 'package:between_us/services/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AnniversaryCard extends StatefulWidget {
  const AnniversaryCard(
      {super.key, required this.userData, required this.partnerData});
  final userData;
  final partnerData;

  @override
  State<AnniversaryCard> createState() => _AnniversaryCardState();
}

class _AnniversaryCardState extends State<AnniversaryCard> {
  CollectionReference coupleInfo =
      FirebaseFirestore.instance.collection('coupleInfo');

  addAnniversary() {
    DateTime? pickedDate;
    dynamic id;

    coupleInfo
        .where("id1",
            whereIn: [widget.userData['uid'], widget.partnerData['uid']])
        .get()
        .then((QuerySnapshot querySnapshot) {
          var data = querySnapshot.docs.first.data() as Map<String, dynamic>?;
          id = data!['docid'];
        });

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((value) {
      pickedDate = value;
      if (pickedDate != null) {
        var totalDays =
            Service().daysBetween(pickedDate!, DateTime.now()).toString();
        setState(() {
          coupleInfo.doc(id).update({
            'anniversaryDate': pickedDate,
            'totalDays': totalDays,
          });
          Fluttertoast.showToast(msg: 'Anniversary Date has Chosen.');
        });
        return;
      }
    });
  }

  updateTotalDays() {
    coupleInfo
        .where("id1",
            whereIn: [widget.userData['uid'], widget.partnerData['uid']])
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            var data = querySnapshot.docs.first.data() as Map<String, dynamic>?;
            var totalDays = Service()
                .daysBetween(data!['anniversaryDate'].toDate(), DateTime.now())
                .toString();
            setState(() {
              coupleInfo.doc(data['docid']).update({
                'totalDays': totalDays,
              });
            });
          }
        });
  }

  @override
  void initState() {
    updateTotalDays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: coupleInfo.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.docs.first;

            return Card(
              margin: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 106,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(children: [
                          WidgetSpan(
                            child: FaIcon(
                              FontAwesomeIcons.calendarDay,
                              size: 18,
                            ),
                          ),
                          TextSpan(
                            text: '    Anniversary Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    ),
                    const Divider(),
                    data['anniversaryDate'] == ""
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onPressed: () => addAnniversary(),
                            label: const Text(
                              'Anniversary Date',
                            ),
                            icon: const FaIcon(
                                FontAwesomeIcons.solidCalendarDays),
                          )
                        : Text(
                            '${widget.userData['name']} and ${widget.partnerData['name']} has been together ${data['totalDays']} days.')
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        });
  }
}
