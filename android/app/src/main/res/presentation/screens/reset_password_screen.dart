import 'package:flutter/material.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/widget/custom_text_field.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isNewPasswordVisible = false; 
  bool _isConfirmPasswordVisible = false; 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 3),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Navigate back
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                // Title
                Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Yellowtail',
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                // Image
                Center(
                  child: Image.asset(
                    'assets/images/reset.png',
                    height: size.height * 0.35,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: size.height * 0.001),
                // Subtitle
                Text(
                  'Enter your new password and confirm it below.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sora',
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                // Input Fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // New Password Field
                      CustomTextField(
                        label: 'New Password',
                        icon: Icons.lock_outline,
                        controller: _newPasswordController,
                        obscureText: !_isNewPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isNewPasswordVisible = !_isNewPasswordVisible;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.03), // Spacing between fields
                      // Confirm New Password Field
                      CustomTextField(
                        label: 'Confirm New Password',
                        icon: Icons.lock_outline,
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          } else if (value != _newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                // Submit Button
                Center(
                  child: SizedBox(
                    width: size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          final AuthenticationController controller=Get.find();
                          await controller.resetPassword(_newPasswordController, _confirmPasswordController, context);
                          
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF790303),
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: Text(
                        'RESET PASSWORD',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
