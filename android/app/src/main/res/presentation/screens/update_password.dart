import 'package:flutter/material.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/widget/custom_text_field.dart';
import 'package:get/get.dart';

class updatePasswordScreen extends StatelessWidget {
  updatePasswordScreen({super.key});

  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color(0xFFB17C46),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button Section
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 10.0),
                      child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(height: size.height * 0.001),
                    Center(
                      child: Text(
                        ' Update  Password',
                        style: TextStyle(
                          fontSize: size.width * 0.09,
                          fontFamily: 'Yesteryear',
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF790303),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.001),
                    Center(
                      child: Image.asset(
                        'assets/images/lock.png',
                        height: size.height * 0.35,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Form Section
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'Old Password',
                            icon: Icons.lock_outline,
                            controller: _oldpasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your old password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            label: 'New Password',
                            icon: Icons.lock_reset,
                            controller: _newpasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a new password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height * 0.05),
                          // Submit Button
                          SizedBox(width: size.width * 0.8),
                          GetBuilder<AuthenticationController>(
                              builder: (controller) {
                            return ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.updatePassword(
                                    _oldpasswordController,
                                    _newpasswordController,
                                    context,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF790303),
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.02,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
