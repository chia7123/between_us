import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CouplePointCard extends StatelessWidget {
  const CouplePointCard({
    super.key,
    this.userData,
    this.partnerData,
  });

  final userData;
  final partnerData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(children: [
                  WidgetSpan(
                    child: FaIcon(
                      FontAwesomeIcons.sackDollar,
                      size: 18,
                      color: Color.fromARGB(255, 255, 45, 245),
                    ),
                  ),
                  TextSpan(
                    text: '   Points',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ]),
              ),
            ),
            const Divider(),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: '${userData['name']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' : '),
                TextSpan(
                  text: '${userData['points']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' points.'),
              ]),
            ),
            const Divider(),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: '${partnerData['name']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' : '),
                TextSpan(
                  text: '${partnerData['points']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' points.'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
