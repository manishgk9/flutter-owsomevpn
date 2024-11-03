import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:owsomevpn/addmob/controller/add_controller.dart';

class RateUsPage extends StatelessWidget {
  final InAppReview _inAppReview = InAppReview.instance;
  final AdController adController = Get.find<AdController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Get.back();
          },
        ),
        title: const Text(
          'Rate Us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 18, 62),
      ),
      backgroundColor: const Color(0xFF0A0E21),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Padding for responsiveness
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'We value your feedback!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for visibility
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Space between text and button
              ElevatedButton(
                onPressed: () async {
                  if (await _inAppReview.isAvailable()) {
                    await _inAppReview
                        .requestReview(); // Open in-app rating dialog
                  } else {
                    // Redirect to the app store
                    await _inAppReview.openStoreListing(
                      appStoreId: 'your_app_store_id',
                      microsoftStoreId: 'your_microsoft_store_id',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 34, 47, 87), // Green button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Rate Us',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold), // White text for button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
