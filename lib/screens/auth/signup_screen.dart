import 'package:flutter/material.dart';
import 'package:autour_mobile/screens/auth/login_screen.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
// import 'package:autour_mobile/widgets/button_widget.dart'; // unused
import 'package:autour_mobile/widgets/textfield_widget.dart';
import 'package:autour_mobile/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autour_mobile/screens/home_screen.dart';
import 'package:geolocator/geolocator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
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
  bool _isLoading = false;

  late AnimationController _logoAnimationController;
  late AnimationController _formAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<Offset> _formSlideAnimation;
  late Animation<double> _formFadeAnimation;

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
  void initState() {
    super.initState();

    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _formAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _formAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _formFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formAnimationController,
      curve: Curves.easeOut,
    ));

    _logoAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _formAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _formAnimationController.dispose();
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

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    // Enforce location services and permission before proceeding
    final allow = await _requireLocationServiceAndPermission();
    if (!allow) {
      await showToast('Please enable location services and grant permission.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Obtain current location (required)
    double? lat;
    double? lng;
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat = pos.latitude;
      lng = pos.longitude;
    } catch (_) {
      // If still failing, stop and inform user
      await showToast('Unable to get current location. Please try again.');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      return;
    }

    try {
      // 1) Create auth account
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final uid = cred.user!.uid;

      // 2) Create Firestore user profile with complete details
      final now = FieldValue.serverTimestamp();
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': fullNameController.text.trim(),
        'dob': dobController.text.trim(),
        'nationality': nationalityController.text.trim(),
        'email': emailController.text.trim(),
        'mobile': mobileController.text.trim(),
        'emergencyContactName': emergencyNameController.text.trim(),
        'emergencyContactNumber': emergencyNumberController.text.trim(),
        'medicalConditions': medicalConditionsController.text.trim(),
        'address': addressController.text.trim(),
        'latitude': lat,
        'longitude': lng,
        'preferences': selectedPreferences,
        'sustainability': selectedSustainability,
        'role': 'user',
        'createdAt': now,
        'updatedAt': now,
      }, SetOptions(merge: true));

      if (!mounted) return;
      // Navigate to Home after successful sign up
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      await showToast(e.message ?? 'Failed to create account');
    } catch (e) {
      await showToast('Unexpected error. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Force user to enable location services and grant permission
  Future<bool> _requireLocationServiceAndPermission() async {
    // Ensure services enabled (give multiple chances to open settings)
    for (int i = 0; i < 3; i++) {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (enabled) break;

      final proceed = await _showEnableLocationDialog();
      if (!proceed) return false;
      await Geolocator.openLocationSettings();
      await Future.delayed(const Duration(seconds: 2));
    }

    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    // Ensure permission granted
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      final opened = await _showOpenAppSettingsDialog();
      if (!opened) return false;
      await Geolocator.openAppSettings();
      await Future.delayed(const Duration(seconds: 2));
      permission = await Geolocator.checkPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _showEnableLocationDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: TextWidget(
                text: 'Enable Location',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              content: TextWidget(
                text:
                    'Location services are required to sign up. Please enable your phone\'s location.',
                fontSize: 14,
                color: black,
                fontFamily: 'Regular',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: TextWidget(
                    text: 'Cancel',
                    fontSize: 14,
                    color: grey,
                    fontFamily: 'Medium',
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: TextWidget(
                    text: 'Open Settings',
                    fontSize: 14,
                    color: primary,
                    fontFamily: 'Bold',
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _showOpenAppSettingsDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: TextWidget(
                text: 'Grant Location Permission',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              content: TextWidget(
                text:
                    'This app needs location permission to continue. Please enable it in Settings.',
                fontSize: 14,
                color: black,
                fontFamily: 'Regular',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: TextWidget(
                    text: 'Cancel',
                    fontSize: 14,
                    color: grey,
                    fontFamily: 'Medium',
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: TextWidget(
                    text: 'Open Settings',
                    fontSize: 14,
                    color: primary,
                    fontFamily: 'Bold',
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: TextWidget(
        text: title,
        fontSize: 20,
        color: primary,
        fontFamily: 'Bold',
        align: TextAlign.left,
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Animated Logo Placeholder
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('config')
                          .doc('asset')
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(data['logo']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                ),

                const SizedBox(height: 20),

                // Title
                SlideTransition(
                  position: _formSlideAnimation,
                  child: FadeTransition(
                    opacity: _formFadeAnimation,
                    child: Column(
                      children: [
                        TextWidget(
                          text: 'Join AuTour',
                          fontSize: 26,
                          color: primary,
                          fontFamily: 'Bold',
                          align: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        TextWidget(
                          text: 'Explore Aurora Province',
                          fontSize: 16,
                          color: grey,
                          fontFamily: 'Regular',
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Form Sections
                SlideTransition(
                  position: _formSlideAnimation,
                  child: FadeTransition(
                    opacity: _formFadeAnimation,
                    child: Column(
                      children: [
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
                            height: 55,
                            radius: 12,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            label: 'Date of Birth',
                            hint: 'MM/DD/YYYY',
                            controller: dobController,
                            inputType: TextInputType.datetime,
                            borderColor: primary,
                            hintColor: grey,
                            width: double.infinity,
                            height: 55,
                            radius: 12,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your date of birth';
                              }
                              if (!RegExp(r'^\d{2}/\d{2}/\d{4}$')
                                  .hasMatch(value)) {
                                return 'Please use MM/DD/YYYY format';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            label: 'Nationality',
                            hint: 'Enter your nationality',
                            controller: nationalityController,
                            borderColor: primary,
                            hintColor: grey,
                            width: double.infinity,
                            height: 55,
                            radius: 12,
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
                            height: 55,
                            radius: 12,
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
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            label: 'Mobile Number',
                            hint: 'Enter your mobile number',
                            controller: mobileController,
                            inputType: TextInputType.phone,
                            borderColor: primary,
                            hintColor: grey,
                            width: double.infinity,
                            height: 55,
                            radius: 12,
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
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: passwordController,
                            isObscure: isObscure,
                            showEye: true,
                            borderColor: primary,
                            hintColor: grey,
                            width: double.infinity,
                            height: 55,
                            radius: 12,
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
                            height: 55,
                            radius: 12,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter emergency contact name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            label: 'Emergency Contact Number',
                            hint: 'Enter contact number',
                            controller: emergencyNumberController,
                            inputType: TextInputType.phone,
                            borderColor: primary,
                            hintColor: grey,
                            width: double.infinity,
                            height: 55,
                            radius: 12,
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
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            label: 'Medical Conditions (Optional)',
                            hint: 'Enter any medical conditions',
                            controller: medicalConditionsController,
                            borderColor: primary,
                            hintColor: grey,
                            width: double.infinity,
                            height: 55,
                            radius: 12,
                            hasValidator: false,
                            maxLine: 2,
                          ),
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            label: 'Address',
                            hint: 'Enter your address',
                            controller: addressController,
                            borderColor: primary,
                            hintColor: grey,
                            width: double.infinity,
                            height: 55,
                            radius: 12,
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                label: TextWidget(
                                  text: 'Preferred Destinations & Activities',
                                  fontSize: 16,
                                  color: black,
                                  fontFamily: 'Medium',
                                ),
                                hintText: 'Select preferences',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Regular',
                                  color: grey,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
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
                                  return 'Please select preferences';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                label: TextWidget(
                                  text: 'Sustainability Preferences',
                                  fontSize: 16,
                                  color: black,
                                  fontFamily: 'Medium',
                                ),
                                hintText: 'Select sustainability preferences',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Regular',
                                  color: grey,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
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
                                  return 'Please select sustainability preferences';
                                }
                                return null;
                              },
                            ),
                          ),
                        ]),

                        const SizedBox(height: 24),

                        // Sign Up Button
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _isLoading ? null : _handleSignUp,
                              borderRadius: BorderRadius.circular(16),
                              child: Center(
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : TextWidget(
                                        text: 'Create Account',
                                        fontSize: 18,
                                        color: white,
                                        fontFamily: 'Bold',
                                      ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Back to Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: "Already have an account? ",
                              fontSize: 14,
                              color: black,
                              fontFamily: 'Regular',
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
                                text: "Sign in",
                                fontSize: 14,
                                color: secondary,
                                fontFamily: 'Bold',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
