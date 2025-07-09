import 'package:flutter/material.dart';
import 'package:autour_mobile/screens/auth/login_screen.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyNumberController =
      TextEditingController();
  final TextEditingController medicalConditionsController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? selectedPreferences;
  String? selectedSustainability;

  bool isObscure = true;

  final List<String> preferencesOptions = [
    'Beaches',
    'Hiking',
    'Food',
    'History',
    'Eco-Tourism',
    'Festivals',
  ];

  final List<String> sustainabilityOptions = [
    'Low Carbon Travel',
    'Local Businesses',
    'Zero Waste',
    'Eco Lodging',
  ];

  @override
  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    nationalityController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    emergencyNameController.dispose();
    emergencyNumberController.dispose();
    medicalConditionsController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: TextWidget(
        text: title,
        fontSize: 18,
        color: primary,
        fontFamily: 'Bold',
        align: TextAlign.left,
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Placeholder
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: 'Logo',
                      fontSize: 24,
                      color: primary,
                      fontFamily: 'Bold',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Title
                TextWidget(
                  text: 'Join AuTour',
                  fontSize: 22,
                  color: primary,
                  fontFamily: 'Bold',
                  align: TextAlign.center,
                ),
                const SizedBox(height: 6),
                TextWidget(
                  text: 'Explore Aurora Province',
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                  align: TextAlign.center,
                ),
                const SizedBox(height: 12),
                // Personal Information Section
                _buildSectionHeader('Personal Information'),
                _buildSection([
                  TextFieldWidget(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: fullNameController,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFieldWidget(
                    label: 'Date of Birth',
                    hint: 'MM/DD/YYYY',
                    controller: dobController,
                    inputType: TextInputType.datetime,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                        return 'Please use MM/DD/YYYY format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFieldWidget(
                    label: 'Nationality',
                    hint: 'Enter your nationality',
                    controller: nationalityController,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your nationality';
                      }
                      return null;
                    },
                  ),
                ]),
                // Login & Authentication Details Section
                _buildSectionHeader('Login & Authentication'),
                _buildSection([
                  TextFieldWidget(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFieldWidget(
                    label: 'Mobile Number',
                    hint: 'Enter your mobile number',
                    controller: mobileController,
                    inputType: TextInputType.phone,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFieldWidget(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: passwordController,
                    isObscure: isObscure,
                    showEye: true,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
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
                ]),
                // Emergency & Safety Information Section
                _buildSectionHeader('Emergency & Safety Information'),
                _buildSection([
                  TextFieldWidget(
                    label: 'Emergency Contact Name',
                    hint: 'Enter contact name',
                    controller: emergencyNameController,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter emergency contact name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFieldWidget(
                    label: 'Emergency Contact Number',
                    hint: 'Enter contact number',
                    controller: emergencyNumberController,
                    inputType: TextInputType.phone,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter emergency contact number';
                      }
                      if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                        return 'Please enter a valid contact number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFieldWidget(
                    label: 'Medical Conditions (Optional)',
                    hint: 'Enter any medical conditions',
                    controller: medicalConditionsController,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    hasValidator: false,
                    maxLine: 2,
                  ),
                  const SizedBox(height: 6),
                  TextFieldWidget(
                    label: 'Address',
                    hint: 'Enter your address',
                    controller: addressController,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    maxLine: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ]),
                // Tourist Preferences & Interests Section
                _buildSectionHeader('Tourist Preferences & Interests'),
                _buildSection([
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      label: TextWidget(
                        text: 'Preferred Destinations & Activities',
                        fontSize: 16,
                        color: black,
                        fontFamily: 'Medium',
                      ),
                      hintText: 'Select your preferences',
                      hintStyle: const TextStyle(
                        fontFamily: 'Regular',
                        color: grey,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: selectedPreferences,
                    items: preferencesOptions
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: TextWidget(
                                text: option,
                                fontSize: 16,
                                color: black,
                                fontFamily: 'Regular',
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPreferences = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your preferences';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      label: TextWidget(
                        text: 'Sustainability Preferences',
                        fontSize: 16,
                        color: black,
                        fontFamily: 'Medium',
                      ),
                      hintText: 'Select your sustainability preferences',
                      hintStyle: const TextStyle(
                        fontFamily: 'Regular',
                        color: grey,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: selectedSustainability,
                    items: sustainabilityOptions
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: TextWidget(
                                text: option,
                                fontSize: 16,
                                color: black,
                                fontFamily: 'Regular',
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSustainability = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your sustainability preferences';
                      }
                      return null;
                    },
                  ),
                ]),
                const SizedBox(height: 12),
                // Sign Up Button
                ButtonWidget(
                  label: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle signup logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: 'Sign Up pressed',
                            fontSize: 14,
                            color: white,
                          ),
                          backgroundColor: primary,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  color: primary,
                  textColor: white,
                  width: double.infinity,
                  height: 50,
                  radius: 8,
                  fontSize: 16,
                ),
                const SizedBox(height: 12),
                // Back to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: "Already have an account?",
                      fontSize: 14,
                      color: black,
                      fontFamily: 'Regular',
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: TextWidget(
                        text: "Log in",
                        fontSize: 14,
                        color: secondary,
                        fontFamily: 'Bold',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
