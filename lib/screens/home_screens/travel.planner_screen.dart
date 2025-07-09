import 'package:autour_mobile/screens/itinerary_screen.dart';
import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';

class TravelPlannerScreen extends StatelessWidget {
  const TravelPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Personalized Travel Planner',
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
              // Header
              TextWidget(
                text: 'Customize Your Trip',
                fontSize: 20,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 8),
              TextWidget(
                text:
                    'Plan your Aurora adventure based on your interests, budget, and sustainability preferences.',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
              ),

              const SizedBox(height: 20),

              // Interests Section
              _buildSectionTitle('Your Interests'),
              _buildChipWrap([
                'Beaches',
                'Hiking',
                'Food',
                'History',
                'Eco-Tourism',
                'Festivals',
              ]),

              const SizedBox(height: 20),

              // Budget Picker
              _buildSectionTitle('Budget Range'),
              _buildChipWrap([
                '₱1,000 - ₱3,000',
                '₱3,000 - ₱5,000',
                '₱5,000 - ₱10,000',
                '₱10,000+',
              ]),

              const SizedBox(height: 20),

              // Sustainability Goals
              _buildSectionTitle('Sustainability Preferences'),
              _buildChipWrap([
                'Low Carbon Travel',
                'Local Businesses',
                'Zero Waste',
                'Eco Lodging',
              ]),

              const SizedBox(height: 30),

              // AI Suggestions
              TextWidget(
                text: 'Top Destinations',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Dingalan Viewpoint',
                description:
                    'Hidden gem with stunning coastal views. Less crowded and perfect for eco-hiking.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Baler Organic Farms',
                description:
                    'Support sustainable agriculture and enjoy farm-to-table experiences.',
              ),

              const SizedBox(height: 30),

              // Generate Itinerary
              ButtonWidget(
                label: 'Generate Itinerary',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GeneratedItineraryScreen(),
                    ),
                  );
                },
                color: primary,
                textColor: white,
                width: double.infinity,
                height: 50,
                radius: 10,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return TextWidget(
      text: title,
      fontSize: 16,
      color: black,
      fontFamily: 'Bold',
    );
  }

  Widget _buildChipWrap(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (item) => Chip(
              label: TextWidget(
                text: item,
                fontSize: 12,
                color: black,
                fontFamily: 'Regular',
              ),
              backgroundColor: secondary.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSuggestionCard({
    required String title,
    required String description,
  }) {
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
            fontSize: 14,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: description,
            fontSize: 12,
            color: black,
            fontFamily: 'Regular',
          ),
        ],
      ),
    );
  }
}
