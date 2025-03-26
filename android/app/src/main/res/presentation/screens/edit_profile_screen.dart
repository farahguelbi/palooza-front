import 'package:flutter/material.dart';
import 'package:front/core/utils/string_const.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/widget/change_profil_image_dialog.dart';
import 'package:front/presentation/widget/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _FirstnameController = TextEditingController();
  final TextEditingController _LastnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _selectedGender;

  String? _birthDate;
  DateTime? _selectedBirthdate;
  final format = DateFormat("yyyy-MM-dd");

  void _pickBirthdate(BuildContext context) async {
    DateTime initialDate = _selectedBirthdate ?? DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        _birthDate = format.format(_selectedBirthdate!);
      });
    }
  }

  @override
  void initState() {
    final AuthenticationController authenticationController = Get.find();
    _FirstnameController.text = authenticationController.currentUser.firstName;
    _LastnameController.text = authenticationController.currentUser.lastName;
    _addressController.text = authenticationController.currentUser.address!;
    _phoneNumberController.text = authenticationController.currentUser.phone!;
    if (authenticationController.currentUser.birthDate != null) {
      _birthDate =
          format.format(authenticationController.currentUser.birthDate!);
    } else {
      _birthDate = null;
    }
    if (['Male', 'Female', 'Other']
        .contains(authenticationController.currentUser.gender)) {
      _selectedGender = authenticationController.currentUser.gender;
    } else {
      _selectedGender = null; // Si le genre n'est pas défini ou non valide
    }
    super.initState();
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
      ),
      body: Column(
        children: [
          // Profile Header Section
          Container(
            height: size.height * 0.2,
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
                GetBuilder(
                  // id: ControllerID.UPDATE_USER_IMAGE,
                  init: AuthenticationController(),
                  builder: (controller) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:  controller.currentUser.imageUrl == ''
                          ? Image.asset('assets/images/userImage.jpg').image
                          : NetworkImage(controller.currentUser.imageUrl!),
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () async{
                               await showDialog(
                        context: context,
                        builder: (_) => const ProfileImageDialog());
                              print("Edit Profile Picture");
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),
                const SizedBox(height: 10),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Input Fields Section
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: 'First Name',
                          icon: Icons.person_3,
                          controller: _FirstnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your first name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: 'Last Name',
                          icon: Icons.person_3,
                          controller: _LastnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your Last name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          label: 'Address',
                          icon: Icons.home,
                          controller: _addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          label: 'Phone Number',
                          icon: Icons.phone,
                          controller: _phoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your Phone";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Gender Dropdown
                        InputDecorator(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Colors.black),
                            labelText: 'Gender',
                            filled: true,
                            fillColor: const Color(0xFFFFF1E6).withOpacity(0.4),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 10.0), // Reduced padding
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedGender,
                              isExpanded: true,
                              hint: const Text("Select Gender"),
                              items: ['Male', 'Female', 'Other']
                                  .map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(
                                          gender,
                                          style: const TextStyle(
                                              fontSize: 14), // Adjust text size
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Birthdate Picker
                        GestureDetector(
                          onTap: () => _pickBirthdate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller:
                                  TextEditingController(text: _birthDate),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.calendar_today,
                                    color: Colors.black),
                                labelText: "Birthdate",
                                filled: true,
                                fillColor:
                                    const Color(0xFFFFF1E6).withOpacity(0.4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (_selectedBirthdate == null) {
                                  return "Please select your birthdate";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:()async{
                             
                                await authenticationController.updateUser(
                                  id: authenticationController.currentUser.id??'', 
                                  address: _addressController.text,
                                  firstName: _FirstnameController,
                                  lastName: _LastnameController,
                                  phone: _phoneNumberController.text,
                                  birthDate: _selectedBirthdate??DateTime.now(),
                                  gender: _selectedGender!,
                                     context: context);

                                  
                          
                      
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF790303),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
        ],
      ),
    );
  }

                      

  @override
  void dispose() {
    _FirstnameController.dispose();
    _LastnameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
