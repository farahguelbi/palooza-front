import 'package:flutter/material.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/screens/edit_profile_screen.dart';
import 'package:front/presentation/widget/profile_input.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ViewProfileScreen extends StatelessWidget {
 

  const ViewProfileScreen({Key? key}) : super(key: key);
   String formatDateTime(DateTime? date) {
    if (date == null) {
      return 'Not provided'; // Default text if date is null
    }
    return DateFormat('dd MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
          final AuthenticationController authenticationController = Get.find();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF790303),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: const Text(
              'View Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sora',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      body:GetBuilder<AuthenticationController>(
        builder: (controller){
          final currentUser = controller.currentUser;
       return  Column(
        children: [
          // Profile Header Section
          Container(
            height: size.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF790303),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              CircleAvatar(
                          radius: 50,
                          backgroundImage:  controller.currentUser.imageUrl == ''
                          ? Image.asset('assets/images/userImage.jpg').image
                          : NetworkImage(controller.currentUser.imageUrl!),
                        ),
                const SizedBox(height: 10),
                Text(
                      '${currentUser.firstName} ${currentUser.lastName}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Profile Details Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ProfileDetailRow(
                      label: 'Phone Number',
                      value: currentUser.phone ?? '',
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 20),
                    ProfileDetailRow(
                      label: 'Address',
                      value: currentUser.address ?? '',
                      icon: Icons.home,
                    ),
                    const SizedBox(height: 20),
                    ProfileDetailRow(
                      label: 'Gender',
                      value: currentUser.gender ?? '',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    ProfileDetailRow(
                      label: 'Birthdate',
                      value:formatDateTime(currentUser.birthDate),
                      icon: Icons.calendar_today,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Edit Profile Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(), // Navigate to EditProfileScreen
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF790303), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              child: const Text(
                'Edit ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
       
       );
       
        
        }

      ),
    );
  }
}