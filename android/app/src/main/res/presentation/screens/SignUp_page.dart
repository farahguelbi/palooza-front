import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/screens/login_page.dart';
import 'package:front/presentation/widget/custom_text_field.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value) =>
      value == null || value.isEmpty ? 'This field is required' : null;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm password is required';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {

                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                          },
                          // => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: 'ABeeZee',
                                fontStyle: FontStyle.italic,
                                fontSize: 48,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF790303),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'create your account',
                                style: TextStyle(
                                  fontFamily: 'Yellowtail',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'First name',
                              icon: Icons.person,
                              controller: _firstNameController,
                              validator: _validateNotEmpty,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: CustomTextField(
                              label: 'Last name',
                              icon: Icons.person,
                              controller: _lastNameController,
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextField(
                        label: 'Email',
                        icon: Icons.email,
                        controller: _emailController,
                        validator: _validateEmail,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextField(
                        label: 'Password',
                        icon: Icons.lock,
                        controller: _passwordController,
                        validator: _validatePassword,
                        obscureText: !_isPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextField(
                        label: 'Confirm Password',
                        icon: Icons.lock_outline,
                        controller: _confirmPasswordController,
                        validator: _validateConfirmPassword,
                        obscureText: !_isConfirmPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      const Text(
                        'By registering, you are agreeing to our terms of use\nand Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Center(
                        child: GetBuilder<AuthenticationController>(
                          init: AuthenticationController(),
                          builder: (controller) {
                            return ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await controller.registerUser(
                                      cpassword: _confirmPasswordController,
                                      email: TextEditingController.fromValue(
                                        TextEditingValue(text: _emailController.text),
                                      ),
                                      firstName: TextEditingController.fromValue(
                                        TextEditingValue(text: _firstNameController.text),
                                      ),
                                      lastName: TextEditingController.fromValue(
                                        TextEditingValue(text: _lastNameController.text),
                                      ),
                                      password: _passwordController,
                                      context: context,
                                    );
                                  } catch (e) {
                                    Fluttertoast.showToast(
                                      msg: 'Registration failed: $e',
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Please fill in all required fields',
                                    backgroundColor: Colors.black,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD8CAB8),
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.02,
                                  horizontal: size.width * 0.2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontFamily: 'Abril Fatface',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFC86F16),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Or Connect With',
                          style: TextStyle(
                            fontFamily: 'Wendy One',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF790303),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
            width: double.infinity,
            height: size.height * 0.1,
            padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/FACEBOOK.jpg',
                    width: size.width * 0.15,
                    height: size.height * 0.08,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: size.width * 0.05),
                IconButton(
                  icon: Image.asset(
                    'assets/images/google.jpg',
                    width: size.width * 0.1,
                    height: size.height * 0.08,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: size.width * 0.05),
                IconButton(
                  icon: Image.asset(
                    'assets/images/apple.jpg',
                    width: size.width * 0.1,
                    height: size.height * 0.08,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
