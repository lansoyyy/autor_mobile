import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';

class GeneratedItineraryScreen extends StatelessWidget {
  final Set<String> interests;
  final String? budget;
  final Set<String> sustainability;

  GeneratedItineraryScreen({
    super.key,
    required this.interests,
    required this.budget,
    required this.sustainability,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Your Itinerary',
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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextWidget(
              text: 'Enjoy your custom travel experience!',
              fontSize: 16,
              color: grey,
              fontFamily: 'Regular',
            ),
            const SizedBox(height: 20),
            // Preferences Summary
            Container(
              padding: const EdgeInsets.all(14),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Your Preferences',
                    fontSize: 16,
                    color: primary,
                    fontFamily: 'Bold',
                  ),
                  const SizedBox(height: 8),
                  TextWidget(
                    text: 'Interests:',
                    fontSize: 14,
                    color: black,
                    fontFamily: 'Bold',
                  ),
                  const SizedBox(height: 4),
                  if (interests.isEmpty)
                    TextWidget(
                      text: '• None selected',
                      fontSize: 13,
                      color: grey,
                      fontFamily: 'Regular',
                    )
                  else
                    ...interests.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: TextWidget(
                            text: '• $e',
                            fontSize: 13,
                            color: black,
                            fontFamily: 'Regular',
                          ),
                        )),
                  const SizedBox(height: 8),
                  TextWidget(
                    text: 'Budget:',
                    fontSize: 14,
                    color: black,
                    fontFamily: 'Bold',
                  ),
                  const SizedBox(height: 4),
                  TextWidget(
                    text: budget ?? 'Not specified',
                    fontSize: 13,
                    color: grey,
                    fontFamily: 'Regular',
                  ),
                  const SizedBox(height: 8),
                  TextWidget(
                    text: 'Sustainability Preferences:',
                    fontSize: 14,
                    color: black,
                    fontFamily: 'Bold',
                  ),
                  const SizedBox(height: 4),
                  if (sustainability.isEmpty)
                    TextWidget(
                      text: '• None selected',
                      fontSize: 13,
                      color: grey,
                      fontFamily: 'Regular',
                    )
                  else
                    ...sustainability.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: TextWidget(
                            text: '• $e',
                            fontSize: 13,
                            color: black,
                            fontFamily: 'Regular',
                          ),
                        )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildDayPlan(
              day: 'Day 1',
              location: 'Baler',
              activities: [
                'Surfing at Sabang Beach',
                'Visit Museo de Baler',
                'Dinner at local seafood restaurant',
              ],
              notes:
                  'Ideal arrival time: 8:00 AM\nAccommodation: Costa Pacifica',
            ),
            const SizedBox(height: 16),
            _buildDayPlan(
              day: 'Day 2',
              location: 'Dingalan',
              activities: [
                'Trek to Dingalan Viewpoint',
                'Lunch with ocean view',
                'Visit Tanawan Falls',
              ],
              notes: 'Bring hiking shoes and water.',
            ),
            const SizedBox(height: 16),
            _buildDayPlan(
              day: 'Day 3',
              location: 'Maria Aurora',
              activities: [
                'Explore the 600-year-old Balete Tree',
                'Farm-to-table lunch at Organic Farms',
                'Shop local handicrafts',
              ],
              notes: 'Last day for souvenirs and relaxing before departure.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayPlan({
    required String day,
    required String location,
    required List<String> activities,
    required String notes,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: day,
            fontSize: 16,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: 'Destination: $location',
            fontSize: 14,
            color: black,
            fontFamily: 'Medium',
          ),
          const SizedBox(height: 10),
          TextWidget(
            text: 'Activities:',
            fontSize: 14,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          ...activities.map((activity) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: TextWidget(
                  text: '• $activity',
                  fontSize: 13,
                  color: black,
                  fontFamily: 'Regular',
                ),
              )),
          const SizedBox(height: 10),
          TextWidget(
            text: 'Notes:',
            fontSize: 14,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: notes,
            fontSize: 13,
            color: grey,
            fontFamily: 'Regular',
          ),
        ],
      ),
    );
  }
}
