import 'package:flutter/material.dart';

class SpeedDisplayWidget extends StatelessWidget {
  final IconData cupertinoIcon;
  final String label;
  final IconData materialIcon;
  final String speed;
  final Color iconColor;
  final Color speedColor;

  const SpeedDisplayWidget({
    Key? key,
    required this.cupertinoIcon,
    required this.label,
    required this.materialIcon,
    required this.speed,
    this.iconColor = Colors.white,
    this.speedColor = Colors.greenAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 14, bottom: 14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 25, 49),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Icon(
                    cupertinoIcon,
                    color: Colors.amber,
                    size: 16,
                  ),
                ),
                Text(label,
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  speed,
                  style: TextStyle(color: speedColor, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
