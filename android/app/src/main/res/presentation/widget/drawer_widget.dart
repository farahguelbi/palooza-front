import 'package:flutter/material.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/screens/update_password.dart';
import 'package:front/presentation/screens/view_profile.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF5F5DC),// Light gray background
      child: Column(
        children: [
          // Drawer Header with Logo
          DrawerHeader(
            child: Image.asset(
              'assets/images/pit1.png'
            ),
          ),
          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(
              color: Colors.grey[800],
              thickness: 1,
            ),
          ),
          // Edit Profile Section
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: const Icon(
                Icons.person_pin_rounded,
                color: Color.fromARGB(255, 61, 60, 60),
              ),
              title: const Text(
                ' profil',
                style: TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
              ),
               onTap: () async {
                 Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>  const ViewProfileScreen(),
                  ),
                );
              },
            ),
          ),
          //edit password
           Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 61, 60, 60),
              ),
              title: const Text(
                'Edit Password',
                style: TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
              ),
               onTap: () async {
                 Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>   updatePasswordScreen(),
                  ),
                );
              },
              
            ),
          ),
          //notification 
           const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: Color.fromARGB(255, 61, 60, 60),
              ),
              title: Text(
                'Notifications',
                style: TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
              ),
            ),
          ),
          // FAQ Section
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Color.fromARGB(255, 61, 60, 60),
              ),
              title: Text(
                'FAQ',
                style: TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
              ),
            ),
          ),
          
          // Spacer to push the Logout button to the bottom
          const Spacer(),
          // Logout Button
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: const Color(0xFF800000),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color:const Color(0xFF800000),
                ),
              ),
              onTap: () async {
                final AuthenticationController authenticationController =
                      Get.find();
                  await authenticationController.logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
