import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';

class DisasterPreparednessScreen extends StatelessWidget {
  const DisasterPreparednessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Disaster Preparedness & Weather',
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weather Overview
              TextWidget(
                text: 'Current Weather',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 10),
              _buildWeatherCard(),

              const SizedBox(height: 20),

              // Disaster Alerts
              TextWidget(
                text: 'Disaster Alerts',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 10),
              _buildAlertBox('🌧️ Heavy Rainfall Advisory in Baler',
                  'Be alert for possible flash floods and landslides. Avoid unnecessary travel.'),

              const SizedBox(height: 20),

              // Safety Tips
              TextWidget(
                text: 'Preparedness Tips',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 10),
              _buildTipItem('🧰 Prepare an emergency go-bag.'),
              _buildTipItem(
                  '📢 Follow local government social media and announcements.'),
              _buildTipItem(
                  '📍 Know your evacuation route and nearest shelters.'),
              _buildTipItem('🔌 Charge mobile phones and power banks.'),
              _buildTipItem('💧 Store enough clean water and food.'),

              const SizedBox(height: 20),

              // Emergency Contacts
              TextWidget(
                text: 'Emergency Contacts',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 10),
              _buildContactItem('📞 Disaster Hotline', '911'),
              _buildContactItem(
                  '🚓 Baler Municipal Police Station', '(042) 209-1234'),
              _buildContactItem(
                  '🚑 Aurora Provincial Hospital', '(042) 209-5678'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.wb_sunny_outlined, size: 48, color: Colors.orange),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Baler, Aurora',
                fontSize: 16,
                color: black,
                fontFamily: 'Bold',
              ),
              TextWidget(
                text: '32°C | Partly Cloudy',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
              ),
              TextWidget(
                text: 'Humidity: 60%',
                fontSize: 12,
                color: grey,
                fontFamily: 'Regular',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertBox(String title, String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: title,
            fontSize: 14,
            color: Colors.red.shade700,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: message,
            fontSize: 12,
            color: black,
            fontFamily: 'Regular',
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextWidget(
        text: tip,
        fontSize: 14,
        color: black,
        fontFamily: 'Regular',
        align: TextAlign.start,
      ),
    );
  }

  Widget _buildContactItem(String label, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextWidget(
            text: label,
            fontSize: 14,
            color: black,
            fontFamily: 'Medium',
          ),
          Expanded(child: SizedBox()),
          TextWidget(
            text: number,
            fontSize: 14,
            color: primary,
            fontFamily: 'Bold',
          ),
        ],
      ),
    );
  }
}
