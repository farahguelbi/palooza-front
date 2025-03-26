import 'package:flutter/material.dart';
import 'package:front/di.dart';
import 'package:front/presentation/screens/SignUp_page.dart';
import 'package:front/presentation/screens/login_page.dart';
import 'package:get/get.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});
    @override
  _Page2State createState() => _Page2State();
}
class _Page2State extends State<Page2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB17C46), // Background color
      body: Column(
        children: [
          // Back button
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Return to the previous page
                },
              ),
            ),
          ),
          // Character image
          SizedBox(
            height: 320, // Significantly increased size for the image
            child: Image.asset(
              'assets/images/chef front.png', // Path to your image
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 30),
          // Descriptive text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Your perfect slice, everytime.\nA fresh adventure in every bite.\nStay hungry, stay cheesy!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Abril Fatface',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF790303), // Dark brown color
              ),
            ),
          ),
          // Add more space between text and red container
          Spacer(flex: 1), // Add flexible space
          // Red container with buttons
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF790303), // Dark red color
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD8CAB8), // Beige color
                        foregroundColor: Color(0xFF790303), // Dark brown text
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                                 LoginPage()), 
                        );
                      },
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Abril Fatface',
                            color: Color(0xFFC86F16),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Sign Up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD8CAB8), // Beige color
                        foregroundColor: Color(0xFF790303), // Dark brown text
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignupPage()), // Now valid
                        );
                      },
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'Abril Fatface',
                            color: Color(0xFFC86F16),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
