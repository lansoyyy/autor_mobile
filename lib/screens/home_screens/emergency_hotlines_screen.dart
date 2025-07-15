import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyHotlinesScreen extends StatelessWidget {
  const EmergencyHotlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> emergencyContacts = [
      {
        'title': 'Police Emergency',
        'number': '117',
        'description': 'National emergency hotline for police assistance',
        'icon': Icons.local_police,
        'color': Colors.blue,
      },
      {
        'title': 'Fire Department',
        'number': '118',
        'description': 'Emergency fire response and rescue services',
        'icon': Icons.fire_truck,
        'color': Colors.red,
      },
      {
        'title': 'Ambulance & Medical',
        'number': '119',
        'description': 'Emergency medical services and ambulance',
        'icon': Icons.medical_services,
        'color': Colors.green,
      },
      {
        'title': 'Disaster Management',
        'number': '117',
        'description': 'National disaster risk reduction hotline',
        'icon': Icons.warning,
        'color': Colors.orange,
      },
      {
        'title': 'Aurora Provincial Police',
        'number': '+639123456789',
        'description': 'Local police station in Aurora province',
        'icon': Icons.phone,
        'color': Colors.indigo,
      },
      {
        'title': 'Aurora Provincial Hospital',
        'number': '+639123456790',
        'description': 'Main hospital in Aurora for medical emergencies',
        'icon': Icons.local_hospital,
        'color': Colors.teal,
      },
      {
        'title': 'Baler Municipal Police',
        'number': '+639123456791',
        'description': 'Local police station in Baler municipality',
        'icon': Icons.security,
        'color': Colors.purple,
      },
      {
        'title': 'Coast Guard Aurora',
        'number': '+639123456792',
        'description': 'Maritime safety and rescue operations',
        'icon': Icons.directions_boat,
        'color': Colors.cyan,
      },
      {
        'title': 'Tourism Assistance',
        'number': '+639123456793',
        'description': 'Tourist assistance and information hotline',
        'icon': Icons.travel_explore,
        'color': Colors.amber,
      },
      {
        'title': 'Weather Updates',
        'number': '+639123456794',
        'description': 'Local weather information and storm warnings',
        'icon': Icons.cloud,
        'color': Colors.lightBlue,
      },
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: 'Emergency Hotlines',
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Emergency Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(color: Colors.red.withOpacity(0.3)),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.emergency,
                  color: Colors.red,
                  size: 32,
                ),
                const SizedBox(height: 8),
                TextWidget(
                  text: 'Emergency Contacts',
                  fontSize: 18,
                  color: Colors.red,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 4),
                TextWidget(
                  text: 'Tap any number to call immediately',
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ],
            ),
          ),
          // Emergency Contacts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: emergencyContacts.length,
              itemBuilder: (context, index) {
                final contact = emergencyContacts[index];
                return _buildEmergencyContactCard(context, contact);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactCard(
      BuildContext context, Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: contact['color'].withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchPhoneNumber(contact['number'], context),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: contact['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    contact['icon'],
                    color: contact['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: contact['title'],
                        fontSize: 16,
                        color: black,
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        text: contact['description'],
                        fontSize: 12,
                        color: grey,
                        fontFamily: 'Regular',
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                // Phone Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(
                      text: contact['number'],
                      fontSize: 16,
                      color: contact['color'],
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(height: 4),
                    Icon(
                      Icons.phone,
                      color: contact['color'],
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchPhoneNumber(String phoneNumber, context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        // Fallback for web or if phone app is not available
        final Uri fallbackUri = Uri.parse('tel:$phoneNumber');
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri);
        } else {
          throw 'Could not launch phone number';
        }
      }
    } catch (e) {
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Unable to launch phone number: $phoneNumber',
              fontSize: 14,
              color: white,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
