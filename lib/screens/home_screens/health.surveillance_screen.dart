import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HealthSurveillanceScreen extends StatefulWidget {
  const HealthSurveillanceScreen({super.key});

  @override
  State<HealthSurveillanceScreen> createState() =>
      _HealthSurveillanceScreenState();
}

class _HealthSurveillanceScreenState extends State<HealthSurveillanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController exposureController = TextEditingController();
  final TextEditingController vaccinationController = TextEditingController();
  bool hasSymptoms = false;
  bool hasExposure = false;
  bool _submitting = false;
  String? _profileName;

  @override
  void dispose() {
    temperatureController.dispose();
    symptomsController.dispose();
    exposureController.dispose();
    vaccinationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProfileName();
  }

  Future<void> _loadProfileName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      // Try to read user's profile document
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();
      if (data != null) {
        final name = (data['fullName'] ?? data['name'] ?? '').toString();
        if (name.isNotEmpty) {
          setState(() => _profileName = name);
        }
      }
      // Fallback to auth displayName if profile has no name
      if (_profileName == null || _profileName!.isEmpty) {
        final dn = user.displayName;
        if (dn != null && dn.isNotEmpty) {
          setState(() => _profileName = dn);
        }
      }
    } catch (_) {
      // Non-fatal; keep name null
    }
  }

  Future<void> _submit() async {
    final scaffold = ScaffoldMessenger.of(context);
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      scaffold.showSnackBar(SnackBar(
        content: TextWidget(
            text: 'Please login to submit.', fontSize: 14, color: white),
        backgroundColor: Colors.red,
      ));
      return;
    }
    setState(() => _submitting = true);
    try {
      final uid = user.uid;
      final name = _profileName ?? uid;
      final tempStr = temperatureController.text.trim();
      final tempVal = double.tryParse(tempStr);
      // Convert comma-separated symptoms to a clean list, or save string if empty
      List<String>? symptomsList;
      String symptomsStr = 'None';
      if (hasSymptoms) {
        final raw = symptomsController.text.trim();
        if (raw.isNotEmpty) {
          final parts = raw.split(',');
          symptomsList =
              parts.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
          symptomsStr = symptomsList.isEmpty ? 'None' : symptomsList.join(', ');
        }
      }
      final exposure = hasExposure
          ? (exposureController.text.trim().isEmpty
              ? 'Exposure reported'
              : exposureController.text.trim())
          : 'None';
      final vaccination = vaccinationController.text.trim().isEmpty
          ? 'Not Provided'
          : vaccinationController.text.trim();

      final data = <String, dynamic>{
        'userId': uid,
        'name': name,
        'fullName': name,
        'temperature': tempStr,
        'temp': tempVal,
        'symptoms': symptomsList ?? symptomsStr,
        'exposure': exposure,
        'vaccination': vaccination,
        'createdAt': FieldValue.serverTimestamp(),
        'submittedAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('health_declarations')
          .add(data);

      scaffold.showSnackBar(SnackBar(
        content: TextWidget(
            text: 'Health declaration submitted', fontSize: 14, color: white),
        backgroundColor: primary,
        duration: const Duration(seconds: 2),
      ));

      // Optionally clear form
      temperatureController.clear();
      symptomsController.clear();
      exposureController.clear();
      vaccinationController.clear();
      setState(() {
        hasSymptoms = false;
        hasExposure = false;
      });
    } catch (e) {
      scaffold.showSnackBar(SnackBar(
        content: TextWidget(
            text: 'Failed to submit: $e', fontSize: 14, color: white),
        backgroundColor: Colors.red,
      ));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
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
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: 'Health Surveillance',
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                TextWidget(
                  text: 'Health & Safety',
                  fontSize: 22,
                  color: primary,
                  fontFamily: 'Bold',
                  align: TextAlign.left,
                ),
                const SizedBox(height: 6),
                TextWidget(
                  text:
                      'Complete your health declaration for safe travel in Aurora Province',
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                  align: TextAlign.left,
                ),
                const SizedBox(height: 12),
                // Health Declaration Section
                _buildSectionHeader('Health Declaration'),
                _buildSection([
                  TextFieldWidget(
                    label: 'Body Temperature (°C)',
                    hint: 'Enter your current body temperature',
                    controller: temperatureController,
                    inputType: TextInputType.number,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your body temperature';
                      }
                      final temp = double.tryParse(value);
                      if (temp == null || temp < 35 || temp > 42) {
                        return 'Please enter a valid temperature (35-42°C)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Experiencing Symptoms?',
                        fontSize: 14,
                        color: black,
                        fontFamily: 'Medium',
                      ),
                      const Spacer(),
                      Switch(
                        value: hasSymptoms,
                        onChanged: (value) {
                          setState(() {
                            hasSymptoms = value;
                          });
                        },
                        activeColor: primary,
                      ),
                    ],
                  ),
                  if (hasSymptoms)
                    TextFieldWidget(
                      label: 'Symptoms',
                      hint: 'E.g., Fever, Cough, Sore Throat',
                      controller: symptomsController,
                      borderColor: primary,
                      hintColor: grey,
                      width: double.infinity,
                      height: 50,
                      radius: 8,
                      maxLine: 2,
                      validator: (value) {
                        if (hasSymptoms && (value == null || value.isEmpty)) {
                          return 'Please specify your symptoms';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Recent Exposure to Illness?',
                        fontSize: 14,
                        color: black,
                        fontFamily: 'Medium',
                      ),
                      const Spacer(),
                      Switch(
                        value: hasExposure,
                        onChanged: (value) {
                          setState(() {
                            hasExposure = value;
                          });
                        },
                        activeColor: primary,
                      ),
                    ],
                  ),
                  if (hasExposure)
                    TextFieldWidget(
                      label: 'Exposure Details',
                      hint: 'E.g., Contact with confirmed case',
                      controller: exposureController,
                      borderColor: primary,
                      hintColor: grey,
                      width: double.infinity,
                      height: 50,
                      radius: 8,
                      maxLine: 2,
                      validator: (value) {
                        if (hasExposure && (value == null || value.isEmpty)) {
                          return 'Please specify exposure details';
                        }
                        return null;
                      },
                    ),
                ]),
                // Vaccination & Health Status Section
                _buildSectionHeader('Vaccination & Health Status (Optional)'),
                _buildSection([
                  TextFieldWidget(
                    label: 'Vaccination Record',
                    hint: 'Upload or describe your vaccination status',
                    controller: vaccinationController,
                    borderColor: primary,
                    hintColor: grey,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    hasValidator: false,
                    maxLine: 2,
                  ),
                ]),
                // Submit Button
                const SizedBox(height: 12),
                ButtonWidget(
                  label: 'Submit Health Declaration',
                  onPressed: () {
                    if (_submitting) return;
                    _submit();
                  },
                  isLoading: _submitting,
                  color: primary,
                  textColor: white,
                  width: double.infinity,
                  height: 50,
                  radius: 8,
                  fontSize: 16,
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
