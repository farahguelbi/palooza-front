import 'package:flutter/material.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController=TextEditingController();
final _formKey=GlobalKey<FormState>();

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
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); 
                  }
                ),
              
              ),
              SizedBox(height: size.height * 0.05),
               Center(
                 child: Text(' Verification Code',
                  style: TextStyle(
                    fontSize: size.width * 0.05, 
                    fontFamily: 'Wendy One',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                 
                              ),
               ),
             SizedBox(height: size.height * 0.05),
             Center(
              child: Image.asset('assets/images/otp.png',
                  height: size.height * 0.35, 
                  fit: BoxFit.contain,
                  ),
                  
             ),
             SizedBox(height: size.height * 0.03),
            Center(
              child: Text(
                'Tap the code sent to your phone ',
                  style: TextStyle(
                   fontSize: size.width * 0.03, 
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sora',
                    color: Colors.black
                  ),
              ),
            ),
      SizedBox(height: size.height * 0.05),
      Form(
                  key: _formKey,
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,

                    maxLength: 4, // OTP is typically 4 or 6 digits
                    decoration: InputDecoration(
                      hintText: 'Enter OTP',
                      counterText: '', // Removes the character count indicator
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: size.width * 0.045),
                   
                    
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                // Submit Button
                Center(
                  child: SizedBox(
                    width: size.width*0.45,
                  
                    child: ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate())  {
                          final AuthenticationController controller=Get.find();
                          await controller.verifyOTP(otpController, context);
                        }
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
                        'Verify',
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
    )
    );
  }
}