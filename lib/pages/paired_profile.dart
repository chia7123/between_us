import 'package:between_us/widgets/anniversary_card.dart';
import 'package:between_us/widgets/couple_info_card.dart';
import 'package:between_us/widgets/score_point.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PairedProfilePage extends StatefulWidget {
  const PairedProfilePage({super.key, this.data});

  final data;

  @override
  State<PairedProfilePage> createState() => _PairedProfilePageState();
}

class _PairedProfilePageState extends State<PairedProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.data['connectedId'])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          if (snapshot.data!.exists) {
            final partnerData = snapshot.data!.data();
            return Column(
              children: [
                CoupleInfoCard(data: widget.data, partnerData: partnerData),
                const SizedBox(
                  height: 20,
                ),
                AnniversaryCard(
                  userData: widget.data,
                  partnerData: partnerData,
                ),
                CouplePointCard(
                  userData: widget.data,
                  partnerData: partnerData,
                ),
              ],
            );
          }
          return const Center(
            child: Text("something went wrong"),
          );
        });
  }
}
