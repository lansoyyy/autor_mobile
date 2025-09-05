import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/utils/populate_firebase_data.dart';

class AdminPopulateDataScreen extends StatefulWidget {
  const AdminPopulateDataScreen({super.key});

  @override
  State<AdminPopulateDataScreen> createState() =>
      _AdminPopulateDataScreenState();
}

class _AdminPopulateDataScreenState extends State<AdminPopulateDataScreen> {
  bool _isPopulating = false;
  bool _isClearing = false;
  String _statusMessage = '';

  Future<void> _populateData() async {
    setState(() {
      _isPopulating = true;
      _statusMessage = 'Populating data...';
    });

    try {
      await FirebaseDataPopulator.populateAllData();
      setState(() {
        _statusMessage = 'Data populated successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isPopulating = false;
      });
    }
  }

  Future<void> _clearData() async {
    setState(() {
      _isClearing = true;
      _statusMessage = 'Clearing data...';
    });

    try {
      await FirebaseDataPopulator.clearAllData();
      setState(() {
        _statusMessage = 'Data cleared successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isClearing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Admin Data Population',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Populate Travel Planner Data',
                fontSize: 20,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 8),
              TextWidget(
                text:
                    'Use this screen to populate or clear Firebase data for the travel planner feature.',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
              ),
              const SizedBox(height: 30),
              TextWidget(
                text: 'Actions',
                fontSize: 18,
                color: primary,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 16),
              ButtonWidget(
                label: _isPopulating ? 'Populating...' : 'Populate Data',
                onPressed: _isPopulating ? () {} : _populateData,
                color: primary,
                textColor: white,
                width: double.infinity,
                height: 50,
                radius: 10,
                fontSize: 16,
              ),
              const SizedBox(height: 16),
              ButtonWidget(
                label: _isClearing ? 'Clearing...' : 'Clear All Data',
                onPressed: _isClearing ? () {} : _clearData,
                color: Colors.red,
                textColor: white,
                width: double.infinity,
                height: 50,
                radius: 10,
                fontSize: 16,
              ),
              const SizedBox(height: 30),
              TextWidget(
                text: 'Status',
                fontSize: 18,
                color: primary,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: grey.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextWidget(
                  text: _statusMessage.isEmpty ? 'Ready' : _statusMessage,
                  fontSize: 14,
                  color: black,
                  fontFamily: 'Regular',
                ),
              ),
              const SizedBox(height: 30),
              TextWidget(
                text: 'Data Overview',
                fontSize: 18,
                color: primary,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 16),
              _buildDataInfoCard('Destinations', '10 sample destinations'),
              const SizedBox(height: 8),
              _buildDataInfoCard('Activities', '10 sample activities'),
              const SizedBox(height: 8),
              _buildDataInfoCard('Tips', '10 sample travel tips'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataInfoCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: title,
            fontSize: 16,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: description,
            fontSize: 14,
            color: black,
            fontFamily: 'Regular',
          ),
        ],
      ),
    );
  }
}
