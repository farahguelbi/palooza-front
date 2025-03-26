import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/screens/SignUp_page.dart';
import 'package:front/presentation/screens/forget_password.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Red Container at the top
            Container(
              color: const Color(0xFF790303),
              height: 450,
              child: Stack(
                children: [
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  // Content of the container
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/pit1.png',
                          height: 250,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Welcome back! Your next pizza adventure\nis just a tap away!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Aclonica',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Login to your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Yellowtail',
                            fontSize: 20,
                            color: Color(0xFFC86F16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Form with validation
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFF790303)),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Color(0xFF8B4513)),
                        filled: true,
                        fillColor: const Color(0xFFFFF1E6).withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: const Color(0xFF8B4513).withOpacity(0.4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xFFC86F16)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF790303)),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF8B4513)),
                        filled: true,
                        fillColor: const Color(0xFFFFF1E6).withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: const Color(0xFF8B4513).withOpacity(0.4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xFFC86F16)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF8B4513),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Remember Me and Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value) {
                                // Handle Remember Me
                              },
                              activeColor: const Color(0xFF790303),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(color: Color(0xFF8B4513)),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                                                              Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ForgetPassword(),
                                    ),
                                  );

                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
        GetBuilder<AuthenticationController>(
  init: AuthenticationController(),
  builder: (controller) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD8CAB8),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 5,
      ),
      onPressed: () async {
        // Validation du formulaire
        if (_formKey.currentState!.validate()) {
          try {
            // Appel de la méthode `login` dans le contrôleur
            await controller.login(
              email: emailController,
              password: passwordController,
              context: context,
            );
          } catch (e) {
            // Afficher un toast pour les erreurs
            Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          // Afficher un toast si les champs sont invalides
          Fluttertoast.showToast(
            msg: "Please fill in all required fields.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: controller.isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : const Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Abril Fatface',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC86F16),
              ),
            ),
    );
  },
),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),

            // Sign Up Text
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                    
                         Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignupPage()
                                    ),
                                  );

                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
