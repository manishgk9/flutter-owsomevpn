import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Text(
            'Share Content Vie',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor:
            const Color.fromARGB(255, 33, 18, 62), // Updated background color
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFF0A0E21), // Updated background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: screenSize.height * .03,
            ),
            // Share Options as Row Buttons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    buildShareWhatsappButton("W", 'WhatsApp', Colors.green),
                    buildShareButton(Icons.facebook, 'Facebook', Colors.blue),
                    buildShareButton(Icons.email, 'Email', Colors.red),
                    buildShareButton(Icons.message, 'Message', Colors.orange),
                  ],
                ),
              ),
            ),

            // Rounded Share Now Button at Bottom

            Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 30, right: 30),
              child: InkWell(
                onTap: () => Share.share(
                    "Hey share my Owsome Vpn app which very essay to use"),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 34, 47, 87),
                      borderRadius: BorderRadius.circular(18)),
                  child: Center(
                    child: const Text(
                      'Share Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for share buttons
  Widget buildShareButton(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        // Add functionality for sharing, e.g., specific platform sharing
        Share.share('Check out this awesome app via $label!');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildShareWhatsappButton(String logotext, String label, Color color) {
  return GestureDetector(
    onTap: () {
      // Add functionality for sharing, e.g., specific platform sharing
      Share.share('Check out this awesome app via $label!');
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 35,
            child: Text(
              logotext,
              style: const TextStyle(
                  fontSize: 30, // Make it large like an icon
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
