import 'package:flutter/material.dart';

class CountryPingWidget extends StatelessWidget {
  final String countryName;
  final int ping;

  const CountryPingWidget({
    Key? key,
    required this.countryName,
    required this.ping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getNetworkLevel(int ping) {
      if (ping >= 1 && ping <= 10) {
        return 'bar_level_4.png';
      } else if (ping >= 11 && ping <= 35) {
        return 'bar_level_3.png';
      } else if (ping >= 36 && ping <= 100) {
        return 'bar_level_2.png';
      } else {
        return 'bar_level_1.png';
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Country Name
        Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black, // Black background
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow for depth
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              countryName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )),

        // Ping Indicator
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black, // Black background
            borderRadius: BorderRadius.circular(12), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow for depth
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5), // Position of shadow
              ),
            ],
          ),
          child: Row(children: [
            Image.asset(
                height: 21,
                width: 22,
                "assets/network_icon/${getNetworkLevel(ping)}"),
            Text(" ${ping} ms",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.greenAccent, // Same green as icon
                ))
          ]),
        ),
      ],
    );
  }
}
