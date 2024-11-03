import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/app_pref/apppreferences.dart';
import 'package:owsomevpn/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background for the whole screen
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: [
                  // First page
                  _buildOnboardingPage(
                    'Enjoy fast and stable connection anywhere',
                    'assets/boarding/rocket_icon.png',
                    'Going online doesn’t have to mean being exposed.',
                  ),
                  // Second page
                  _buildOnboardingPage(
                    'Get secure and private access to the internet',
                    'assets/boarding/shield_icon.png',
                    'A VPN service provides you a secure, encrypted tunnel.',
                  ),
                  // Third page
                  _buildOnboardingPage(
                    'All-access pass to global content',
                    'assets/boarding/globle_icon.png',
                    'Get your favorite shows and apps wherever you are.',
                  ),
                ],
              ),
            ),
            // Progress Dots and Button
            Column(
              children: [
                _buildProgressDots(),
                SizedBox(height: 20),
                _buildNextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to build each onboarding page
  Widget _buildOnboardingPage(
      String title, String imagePath, String description) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Image
          Image.asset(
            imagePath,
            height: 200, // Adjust size accordingly
            // color: Colors.white, // Use white or light colors for contrast
          ),
          SizedBox(height: 50),
          // Title Text
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // Description Text
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Method to build the progress dots at the bottom of the screen
  Widget _buildProgressDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: currentPage == index ? 12 : 8,
          height: currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? Color.fromARGB(255, 34, 47, 87)
                : Colors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
        );
      }),
    );
  }

  // Method to build the 'Next' or 'Get Started' button
  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          if (currentPage == 2) {
            print(AppPreferences.isIntrowed);
            // If it's the last page, navigate to the next screen
            AppPreferences.isIntrowed = true;
            Get.offAll(() => HomeScreen());
          } else {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 34, 47, 87), // Blue button color
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          currentPage == 2 ? 'Get Started' : 'Next',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
