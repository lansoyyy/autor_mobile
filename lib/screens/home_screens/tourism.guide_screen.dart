import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';

class SmartTourismGuideScreen extends StatelessWidget {
  const SmartTourismGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Smart Tourism Guide',
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Interactive Tourism Map',
              fontSize: 20,
              color: black,
              fontFamily: 'Bold',
            ),
            const SizedBox(height: 8),
            TextWidget(
              text:
                  'Explore eco-tourism sites, historical landmarks, and emergency zones through a dynamic and GPS-integrated map.',
              fontSize: 14,
              color: grey,
              fontFamily: 'Regular',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: grey.withOpacity(0.3)),
                ),
                child: const Center(
                  child: Text(
                    'Map Placeholder\n(Google Maps integration coming soon)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
