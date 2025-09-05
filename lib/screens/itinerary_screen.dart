import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autour_mobile/utils/travel_models.dart';
import 'package:autour_mobile/utils/travel_service.dart';

class GeneratedItineraryScreen extends StatefulWidget {
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
  State<GeneratedItineraryScreen> createState() =>
      _GeneratedItineraryScreenState();
}

class _GeneratedItineraryScreenState extends State<GeneratedItineraryScreen> {
  final TravelService _travelService = TravelService();
  bool _isLoading = true;
  List<TravelDestination> _destinations = [];
  List<TravelActivity> _activities = [];
  List<TravelTip> _tips = [];

  @override
  void initState() {
    super.initState();
    _loadItineraryData();
  }

  Future<void> _loadItineraryData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load all travel data
      final destinations = await _travelService.getDestinations();
      final activities = await _travelService.getActivities();
      final tips = await _travelService.getTips();

      setState(() {
        _destinations = destinations;
        _activities = activities;
        _tips = tips;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
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
                        if (widget.interests.isEmpty)
                          TextWidget(
                            text: '• None selected',
                            fontSize: 13,
                            color: grey,
                            fontFamily: 'Regular',
                          )
                        else
                          ...widget.interests.map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
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
                          text: widget.budget ?? 'Not specified',
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
                        if (widget.sustainability.isEmpty)
                          TextWidget(
                            text: '• None selected',
                            fontSize: 13,
                            color: grey,
                            fontFamily: 'Regular',
                          )
                        else
                          ...widget.sustainability.map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
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
                  // Dynamic itinerary based on user preferences
                  ..._buildDynamicItinerary(),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildDynamicItinerary() {
    final itineraryWidgets = <Widget>[];

    // Create a 3-day itinerary
    for (int day = 1; day <= 3; day++) {
      final dayPlan = _generateDayPlan(day);
      if (dayPlan != null) {
        itineraryWidgets.add(dayPlan);
        itineraryWidgets.add(const SizedBox(height: 16));
      }
    }

    // If no dynamic plans could be generated, show default plans
    if (itineraryWidgets.isEmpty) {
      itineraryWidgets.addAll([
        _buildDefaultDayPlan(
          day: 'Day 1',
          location: 'Baler',
          activities: [
            'Surfing at Sabang Beach',
            'Visit Museo de Baler',
            'Dinner at local seafood restaurant',
          ],
          notes: 'Ideal arrival time: 8:00 AM\nAccommodation: Costa Pacifica',
        ),
        const SizedBox(height: 16),
        _buildDefaultDayPlan(
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
        _buildDefaultDayPlan(
          day: 'Day 3',
          location: 'Maria Aurora',
          activities: [
            'Explore the 600-year-old Balete Tree',
            'Farm-to-table lunch at Organic Farms',
            'Shop local handicrafts',
          ],
          notes: 'Last day for souvenirs and relaxing before departure.',
        ),
      ]);
    }

    return itineraryWidgets;
  }

  Widget? _generateDayPlan(int day) {
    // Filter destinations and activities based on user interests
    List<TravelDestination> relevantDestinations = [];
    List<TravelActivity> relevantActivities = [];

    if (widget.interests.isNotEmpty) {
      relevantDestinations = _destinations.where((destination) {
        return widget.interests
            .any((interest) => destination.categories.contains(interest));
      }).toList();

      relevantActivities = _activities.where((activity) {
        return widget.interests
            .any((interest) => activity.categories.contains(interest));
      }).toList();
    } else {
      // If no interests selected, use all
      relevantDestinations = _destinations;
      relevantActivities = _activities;
    }

    // If we don't have enough data, return null to use default
    if (relevantDestinations.isEmpty || relevantActivities.isEmpty) {
      return null;
    }

    // Select a destination for this day (rotate through available ones)
    final destinationIndex = (day - 1) % relevantDestinations.length;
    final destination = relevantDestinations[destinationIndex];

    // Select 2-3 activities for this day
    final activitiesForDay = <TravelActivity>[];
    final activitiesNeeded = 2 + (day % 2); // 2 or 3 activities

    for (int i = 0;
        i < activitiesNeeded && i < relevantActivities.length;
        i++) {
      final activityIndex =
          ((day - 1) * activitiesNeeded + i) % relevantActivities.length;
      activitiesForDay.add(relevantActivities[activityIndex]);
    }

    // Generate notes based on sustainability preferences
    String notes = 'Enjoy your day in ${destination.municipality}!';
    if (widget.sustainability.isNotEmpty) {
      notes += '\nSustainability focus: ${widget.sustainability.join(', ')}';
    }

    return _buildDayPlan(
      day: 'Day $day',
      location: destination.municipality,
      activities: activitiesForDay.map((a) => a.title).toList(),
      notes: notes,
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

  // Keep the default day plan method for fallback
  Widget _buildDefaultDayPlan({
    required String day,
    required String location,
    required List<String> activities,
    required String notes,
  }) {
    return _buildDayPlan(
      day: day,
      location: location,
      activities: activities,
      notes: notes,
    );
  }
}
