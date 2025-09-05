import 'package:autour_mobile/screens/itinerary_screen.dart';
import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autour_mobile/utils/travel_models.dart';
import 'package:autour_mobile/utils/travel_service.dart';

class TravelPlannerScreen extends StatefulWidget {
  const TravelPlannerScreen({super.key});

  @override
  State<TravelPlannerScreen> createState() => _TravelPlannerScreenState();
}

class _TravelPlannerScreenState extends State<TravelPlannerScreen> {
  final Set<String> selectedInterests = {};
  final Set<String> selectedSustainability = {};
  String? selectedBudget;

  // Add loading states
  bool _isLoading = true;
  bool _isGenerating = false;

  // Add data lists
  List<TravelDestination> _destinations = [];
  List<TravelActivity> _activities = [];
  List<TravelTip> _tips = [];
  List<String> _interestCategories = [];
  List<String> _activityCategories = [];
  List<String> _tipCategories = [];

  // Add service
  final TravelService _travelService = TravelService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load all data in parallel
      final futures = [
        _travelService.getDestinations(),
        _travelService.getActivities(),
        _travelService.getTips(),
        _travelService.getDestinationCategories(),
        _travelService.getActivityCategories(),
        _travelService.getTipCategories(),
      ];

      final results = await Future.wait(futures);

      setState(() {
        _destinations = results[0] as List<TravelDestination>;
        _activities = results[1] as List<TravelActivity>;
        _tips = results[2] as List<TravelTip>;
        _interestCategories = results[3] as List<String>;
        _activityCategories = results[4] as List<String>;
        _tipCategories = results[5] as List<String>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // In case of error, we'll use the default hardcoded values
    }
  }

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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                    _buildFilterChipWrap(
                        _interestCategories.isEmpty
                            ? [
                                'Beaches',
                                'Surfing',
                                'Waterfalls',
                                'Hiking',
                                'History',
                                'Food',
                                'Eco-Tourism',
                                'Festivals',
                              ]
                            : _interestCategories,
                        selectedInterests),

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

                    // Top Destinations based on selected interests
                    TextWidget(
                      text: 'Top Destinations',
                      fontSize: 18,
                      color: black,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(height: 10),
                    if (_destinations.isEmpty)
                      ..._buildDefaultDestinationCards()
                    else
                      ..._buildDestinationCards(),

                    const SizedBox(height: 30),

                    // Suggested Activities based on selected interests
                    TextWidget(
                      text: 'Suggested Activities in Aurora',
                      fontSize: 18,
                      color: black,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(height: 10),
                    if (_activities.isEmpty)
                      ..._buildDefaultActivityCards()
                    else
                      ..._buildActivityCards(),

                    const SizedBox(height: 30),

                    // Practical Tips based on selected interests
                    TextWidget(
                      text: 'Practical Tips',
                      fontSize: 18,
                      color: black,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(height: 10),
                    if (_tips.isEmpty)
                      ..._buildDefaultTipCards()
                    else
                      ..._buildTipCards(),

                    // Generate Itinerary
                    ButtonWidget(
                      label: _isGenerating
                          ? 'Generating...'
                          : 'Generate Itinerary',
                      onPressed: _generateItinerary,
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

  List<Widget> _buildDestinationCards() {
    // Filter destinations based on selected interests
    List<TravelDestination> filteredDestinations = _destinations;

    if (selectedInterests.isNotEmpty) {
      filteredDestinations = _destinations.where((destination) {
        return selectedInterests
            .any((interest) => destination.categories.contains(interest));
      }).toList();
    }

    // If no destinations match interests, show all
    if (filteredDestinations.isEmpty) {
      filteredDestinations = _destinations;
    }

    // Limit to first 6 destinations
    if (filteredDestinations.length > 6) {
      filteredDestinations = filteredDestinations.sublist(0, 6);
    }

    return filteredDestinations.map((destination) {
      return Column(
        children: [
          _buildSuggestionCard(
            title: destination.name,
            description: destination.description,
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  List<Widget> _buildActivityCards() {
    // Filter activities based on selected interests
    List<TravelActivity> filteredActivities = _activities;

    if (selectedInterests.isNotEmpty) {
      filteredActivities = _activities.where((activity) {
        return selectedInterests
            .any((interest) => activity.categories.contains(interest));
      }).toList();
    }

    // If no activities match interests, show all
    if (filteredActivities.isEmpty) {
      filteredActivities = _activities;
    }

    // Limit to first 6 activities
    if (filteredActivities.length > 6) {
      filteredActivities = filteredActivities.sublist(0, 6);
    }

    return filteredActivities.map((activity) {
      return Column(
        children: [
          _buildSuggestionCard(
            title: activity.title,
            description: activity.description,
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  List<Widget> _buildTipCards() {
    // Filter tips based on selected interests
    List<TravelTip> filteredTips = _tips;

    if (selectedInterests.isNotEmpty) {
      filteredTips = _tips.where((tip) {
        return selectedInterests
            .any((interest) => tip.categories.contains(interest));
      }).toList();
    }

    // If no tips match interests, show all
    if (filteredTips.isEmpty) {
      filteredTips = _tips;
    }

    // Limit to first 3 tips
    if (filteredTips.length > 3) {
      filteredTips = filteredTips.sublist(0, 3);
    }

    return filteredTips.map((tip) {
      return Column(
        children: [
          _buildSuggestionCard(
            title: tip.title,
            description: tip.description,
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  // Default cards in case Firebase data is not available
  List<Widget> _buildDefaultDestinationCards() {
    final defaultDestinations = [
      {
        'title': 'Dingalan Viewpoint',
        'description':
            'Hidden gem with stunning coastal views. Less crowded and perfect for eco-hiking.',
      },
      {
        'title': 'Baler Organic Farms',
        'description':
            'Support sustainable agriculture and enjoy farm-to-table experiences.',
      },
      {
        'title': 'Sabang Beach (Baler)',
        'description':
            'Beginner-friendly surf breaks, surf schools, and sunrise walks along the bay.',
      },
      {
        'title': 'Ditumabo (Mother) Falls – San Luis',
        'description':
            '45–60 min river trek to a powerful falls; best visited in the morning with a guide.',
      },
      {
        'title': 'Digisit & Aniao Islets – Baler',
        'description':
            'Rock formations and tide pools great for photos and light snorkeling during low tide.',
      },
      {
        'title': 'Dinadiawan Beach – Dipaculao',
        'description':
            'Long white-sand stretch with clear waters; ideal for relaxed swimming and sunrise.',
      },
      {
        'title': 'Casapsapan Beach – Casiguran',
        'description':
            'Quiet cove with seagrass beds and calm waters; perfect for off-the-beaten-path trips.',
      },
    ];

    return defaultDestinations.map((destination) {
      return Column(
        children: [
          _buildSuggestionCard(
            title: destination['title']!,
            description: destination['description']!,
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  List<Widget> _buildDefaultActivityCards() {
    final defaultActivities = [
      {
        'title': 'Surfing Lessons at Sabang',
        'description':
            'Book a certified instructor; best season is Oct–Mar, but summer also has small waves.',
      },
      {
        'title': 'Mother Falls Trek (San Luis)',
        'description':
            'Wear proper footwear; expect river crossings and slippery rocks. Start early.',
      },
      {
        'title': 'Dingalan Lighthouse & Viewdeck Hike',
        'description':
            'Combine a short boat ride to White Beach with a ridge hike for panoramic views.',
      },
      {
        'title': 'Sea Caving at Lamao Caves',
        'description':
            'Time your visit with low tide and go with accredited guides. Bring helmet/headlamp.',
      },
      {
        'title': 'Tide Pooling at Digisit',
        'description':
            'Best during low tide; wear aqua shoes and avoid slippery rocks during strong swells.',
      },
      {
        'title': 'Snorkeling at Casapsapan/Dinadiawan',
        'description':
            'Use reef-safe sunscreen; do not step on corals. Calm mornings are ideal for visibility.',
      },
    ];

    return defaultActivities.map((activity) {
      return Column(
        children: [
          _buildSuggestionCard(
            title: activity['title']!,
            description: activity['description']!,
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  List<Widget> _buildDefaultTipCards() {
    final defaultTips = [
      {
        'title': 'Best Time to Visit',
        'description':
            'Dry months (Nov–May) are ideal. Surf season peaks around Oct–Mar with bigger swells.',
      },
      {
        'title': 'Getting Around',
        'description':
            'Tricycles for town hops; hire vans or motorbikes for inter-town trips (Baler–Dingalan–Casiguran).',
      },
      {
        'title': 'Permits & Guides',
        'description':
            'Register at barangay/LGU for certain trails/caves. Use accredited guides and follow safety advisories.',
      },
    ];

    return defaultTips.map((tip) {
      return Column(
        children: [
          _buildSuggestionCard(
            title: tip['title']!,
            description: tip['description']!,
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  // Updated generate itinerary method
  Future<void> _generateItinerary() async {
    if (_isGenerating) return; // Prevent multiple taps
    
    setState(() {
      _isGenerating = true;
    });

    try {
      // Navigate to the itinerary screen with the selected preferences
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
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }
}
