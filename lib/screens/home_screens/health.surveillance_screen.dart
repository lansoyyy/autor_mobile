import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';

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
  bool isSubmitted = false;

  @override
  void dispose() {
    temperatureController.dispose();
    symptomsController.dispose();
    exposureController.dispose();
    vaccinationController.dispose();
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

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: '$label: ',
            fontSize: 14,
            color: black,
            fontFamily: 'Medium',
          ),
          Expanded(
            child: TextWidget(
              text: value,
              fontSize: 14,
              color: grey,
              fontFamily: 'Regular',
              align: TextAlign.left,
            ),
          ),
        ],
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
                  const SizedBox(height: 6),
                  ButtonWidget(
                    label: 'Upload Vaccination Record',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: 'File upload placeholder',
                            fontSize: 14,
                            color: white,
                          ),
                          backgroundColor: primary,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    color: secondary,
                    textColor: black,
                    width: double.infinity,
                    height: 50,
                    radius: 8,
                    fontSize: 14,
                  ),
                ]),
                // Submit Button
                const SizedBox(height: 12),
                ButtonWidget(
                  label: 'Submit Health Declaration',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isSubmitted = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: 'Health declaration submitted',
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
                // Results Section
                if (isSubmitted) ...[
                  const SizedBox(height: 12),
                  _buildSectionHeader('Health Declaration Results'),
                  _buildSection([
                    _buildResultItem(
                        'Body Temperature', '${temperatureController.text} °C'),
                    _buildResultItem(
                        'Symptoms',
                        hasSymptoms
                            ? symptomsController.text.isEmpty
                                ? 'None reported'
                                : symptomsController.text
                            : 'None'),
                    _buildResultItem(
                        'Exposure',
                        hasExposure
                            ? exposureController.text.isEmpty
                                ? 'None reported'
                                : exposureController.text
                            : 'None'),
                    _buildResultItem(
                        'Vaccination Status',
                        vaccinationController.text.isEmpty
                            ? 'Not provided'
                            : vaccinationController.text),
                    const SizedBox(height: 8),
                    TextWidget(
                      text:
                          'AI Assessment: ${hasSymptoms || hasExposure ? 'Further Review Needed' : 'Low Risk'}',
                      fontSize: 14,
                      color: hasSymptoms || hasExposure
                          ? Colors.red
                          : Colors.green,
                      fontFamily: 'Bold',
                      align: TextAlign.left,
                    ),
                  ]),
                ],
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
