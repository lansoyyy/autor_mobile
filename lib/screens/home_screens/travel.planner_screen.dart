import 'package:autour_mobile/screens/itinerary_screen.dart';
import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';

class TravelPlannerScreen extends StatefulWidget {
  const TravelPlannerScreen({super.key});

  @override
  State<TravelPlannerScreen> createState() => _TravelPlannerScreenState();
}

class _TravelPlannerScreenState extends State<TravelPlannerScreen> {
  final Set<String> selectedInterests = {};
  final Set<String> selectedSustainability = {};
  String? selectedBudget;

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
              _buildFilterChipWrap([
                'Beaches',
                'Surfing',
                'Waterfalls',
                'Hiking',
                'History',
                'Food',
                'Eco-Tourism',
                'Festivals',
              ], selectedInterests),

              const SizedBox(height: 20),

              // Budget Picker
              _buildSectionTitle('Budget Range'),
              _buildChoiceChipWrap([
                '₱1,000 - ₱3,000',
                '₱3,000 - ₱5,000',
                '₱5,000 - ₱10,000',
                '₱10,000+',
              ], selectedBudget, (val) {
                selectedBudget = val;
              }),

              const SizedBox(height: 20),

              // Sustainability Goals
              _buildSectionTitle('Sustainability Preferences'),
              _buildFilterChipWrap([
                'Low Carbon Travel',
                'Local Businesses',
                'Zero Waste',
                'Eco Lodging',
              ], selectedSustainability),

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
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Sabang Beach (Baler)',
                description:
                    'Beginner-friendly surf breaks, surf schools, and sunrise walks along the bay.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Ditumabo (Mother) Falls – San Luis',
                description:
                    '45–60 min river trek to a powerful falls; best visited in the morning with a guide.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Digisit & Aniao Islets – Baler',
                description:
                    'Rock formations and tide pools great for photos and light snorkeling during low tide.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Dinadiawan Beach – Dipaculao',
                description:
                    'Long white-sand stretch with clear waters; ideal for relaxed swimming and sunrise.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Casapsapan Beach – Casiguran',
                description:
                    'Quiet cove with seagrass beds and calm waters; perfect for off-the-beaten-path trips.',
              ),

              const SizedBox(height: 30),

              // Suggested Activities
              TextWidget(
                text: 'Suggested Activities in Aurora',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Surfing Lessons at Sabang',
                description:
                    'Book a certified instructor; best season is Oct–Mar, but summer also has small waves.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Mother Falls Trek (San Luis)',
                description:
                    'Wear proper footwear; expect river crossings and slippery rocks. Start early.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Dingalan Lighthouse & Viewdeck Hike',
                description:
                    'Combine a short boat ride to White Beach with a ridge hike for panoramic views.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Sea Caving at Lamao Caves',
                description:
                    'Time your visit with low tide and go with accredited guides. Bring helmet/headlamp.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Tide Pooling at Digisit',
                description:
                    'Best during low tide; wear aqua shoes and avoid slippery rocks during strong swells.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Snorkeling at Casapsapan/Dinadiawan',
                description:
                    'Use reef-safe sunscreen; do not step on corals. Calm mornings are ideal for visibility.',
              ),

              const SizedBox(height: 30),
              // Practical Info
              TextWidget(
                text: 'Practical Tips',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Best Time to Visit',
                description:
                    'Dry months (Nov–May) are ideal. Surf season peaks around Oct–Mar with bigger swells.',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Getting Around',
                description:
                    'Tricycles for town hops; hire vans or motorbikes for inter-town trips (Baler–Dingalan–Casiguran).',
              ),
              const SizedBox(height: 10),
              _buildSuggestionCard(
                title: 'Permits & Guides',
                description:
                    'Register at barangay/LGU for certain trails/caves. Use accredited guides and follow safety advisories.',
              ),

              // Generate Itinerary
              ButtonWidget(
                label: 'Generate Itinerary',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GeneratedItineraryScreen(
                        interests: selectedInterests,
                        budget: selectedBudget,
                        sustainability: selectedSustainability,
                      ),
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

  Widget _buildFilterChipWrap(List<String> items, Set<String> selectedSet) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedSet.contains(item);
        return FilterChip(
          label: TextWidget(
            text: item,
            fontSize: 12,
            color: isSelected ? white : black,
            fontFamily: 'Regular',
          ),
          selected: isSelected,
          onSelected: (value) {
            setState(() {
              if (value) {
                selectedSet.add(item);
              } else {
                selectedSet.remove(item);
              }
            });
          },
          selectedColor: primary,
          backgroundColor: secondary.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChoiceChipWrap(List<String> items, String? selectedValue,
      void Function(String) onSelected) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedValue == item;
        return ChoiceChip(
          label: TextWidget(
            text: item,
            fontSize: 12,
            color: isSelected ? white : black,
            fontFamily: 'Regular',
          ),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              onSelected(item);
            });
          },
          selectedColor: primary,
          backgroundColor: secondary.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
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
