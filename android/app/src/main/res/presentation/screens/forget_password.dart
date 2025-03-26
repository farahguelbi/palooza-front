import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/widget/custom_text_field.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController=TextEditingController();
final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size

    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button Section
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10.0), 
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                ),
              ),
              SizedBox(height: size.height * 0.05), // Spacing below the back button
              // Image Section
              Center(
                child: Image.asset(
                  'assets/images/forget.png', // Replace with your image path
                  height: size.height * 0.35, 
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: size.height * 0.03), // 3% vertical spacing
              // Title Section
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: size.width * 0.06, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: size.height * 0.015), // 1.5% vertical spacing
              // Subtitle Section
              Text(
                'Please enter your registered email address. We will get back to you with the reset password link and confirmation OTP. Thanks!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.04, // 4% of screen width
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: size.height * 0.05), // 5% vertical spacing
              // Email Input Field
              Form(
                key: _formKey,
                child: CustomTextField(
                  label: 'Enter email',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.05), // 5% vertical spacing
              // Submit Button
              GetBuilder<AuthenticationController>(
                init: AuthenticationController(),
                builder: (controller) {
                  return Center(
                    child: SizedBox(
                      width: size.width*0.45,
                      child: ElevatedButton(
                        onPressed: ()async {
                          if (_formKey.currentState!.validate()) {
                            await controller.sendFrogetPasswordRequest(
                            _emailController, _emailController.text, context);                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF790303),
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02, // 2% of screen height
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0), // Static radius
                          ),
                        ),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            fontSize: size.width * 0.045, // 4.5% of screen width
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: size.height * 0.02), // 2% vertical spacing
            ],
          ),
        ),
      ),
    );
  }
}