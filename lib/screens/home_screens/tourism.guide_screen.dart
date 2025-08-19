import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';

class SmartTourismGuideScreen extends StatefulWidget {
  const SmartTourismGuideScreen({super.key});

  @override
  State<SmartTourismGuideScreen> createState() =>
      _SmartTourismGuideScreenState();
}

class _SmartTourismGuideScreenState extends State<SmartTourismGuideScreen>
    with SingleTickerProviderStateMixin {
  String selectedActivity = 'All Activities';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> activities = [
    {
      'name': 'Surfing (Baler)',
      'icon': Icons.surfing,
      'color': Colors.blue,
      'locations': [
        'Sabang Beach - Baler',
        'Cemento Reef - Baler',
        "Charlie\'s Point - Baler"
      ],
      'risk_level': 'High',
      'alerts': [
        'Check swell, wind, and typhoon advisories before paddling out.',
        'Beware of rip currents; if caught, swim parallel to shore to escape.',
        'Wear leash and reef-safe footwear; sharp rocks/urchins present at Cemento.',
        'Beginners should surf within designated zones at Sabang with instructors.',
      ],
      'active_alerts': [
        {
          'type': 'Weather',
          'message': 'Strong onshore winds and rips reported at Sabang Beach',
          'severity': 'Medium',
          'time': '2 hours ago',
        }
      ],
    },
    {
      'name': 'Waterfall Trekking & Swimming (San Luis)',
      'icon': Icons.water,
      'color': Colors.lightBlue,
      'locations': [
        'Ditumabo (Mother) Falls - San Luis',
        'Caunayan Falls - San Luis'
      ],
      'risk_level': 'High',
      'alerts': [
        'Trails may close during heavy rain; follow LGU advisories.',
        'Expect river crossings; wear closed-toe hiking shoes for grip.',
        'Keep distance from plunge pool; sudden water surges can occur.',
        'Hire accredited guides and follow checkpoint instructions.',
      ],
      'active_alerts': [
        {
          'type': 'Trail',
          'message':
              'Footbridge repair on Ditumabo trail — expect short detours',
          'severity': 'Medium',
          'time': '1 hour ago',
        }
      ],
    },
    {
      'name': 'Island Hopping & Tide Pools (Baler)',
      'icon': Icons.waves,
      'color': Colors.cyan,
      'locations': [
        'Digisit Beach & Rock Formations - Baler',
        'Aniao Islets - Baler'
      ],
      'risk_level': 'Medium',
      'alerts': [
        'Check tide schedule; tide pools are safest during low tide.',
        'Wear aqua shoes; sharp corals and rocks are common.',
        'Avoid climbing slippery rock formations; strong waves can sweep you.',
        'Boat rides only with accredited boatmen; always wear life vests.',
      ],
      'active_alerts': [
        {
          'type': 'Safety',
          'message': 'Large swell near Aniao Islets — no crossing recommended',
          'severity': 'High',
          'time': '45 minutes ago',
        }
      ],
    },
    {
      'name': 'Viewpoint Hiking & Lighthouse Ridge (Dingalan)',
      'icon': Icons.terrain,
      'color': Colors.green,
      'locations': [
        'White Beach jump-off - Dingalan',
        'Dingalan Lighthouse & Viewdeck'
      ],
      'risk_level': 'Medium',
      'alerts': [
        'Register at barangay/LGU; guide recommended for first-timers.',
        'If boating to White Beach, check sea state with the Coast Guard.',
        'Beware of strong winds at ridges; stay away from cliff edges.',
        'Avoid hiking during thunderstorms or after heavy rain (landslide risk).',
      ],
      'active_alerts': [
        {
          'type': 'Trail',
          'message': 'Trail muddy and slippery — trekking shoes advised',
          'severity': 'Medium',
          'time': '1 hour ago',
        }
      ],
    },
    {
      'name': 'Sea Caving (Lamao Caves, Dingalan)',
      'icon': Icons.explore,
      'color': Colors.deepPurple,
      'locations': ['Lamao Caves - Dingalan'],
      'risk_level': 'Medium',
      'alerts': [
        'Go with accredited guides; bring helmet and headlamp.',
        'Time your visit with the tide — some chambers flood at high tide.',
        'Beware of falling rocks and surge; never enter during big swells.',
        'Wear proper footwear; rocks are sharp and slippery.',
      ],
      'active_alerts': [
        {
          'type': 'Tide',
          'message': 'High tide window this afternoon; cave entry limited',
          'severity': 'Medium',
          'time': '2 hours ago',
        }
      ],
    },
    {
      'name': 'Beach Swimming & Snorkeling',
      'icon': Icons.beach_access,
      'color': Colors.teal,
      'locations': [
        'Dinadiawan Beach - Dipaculao',
        'Casapsapan Beach - Casiguran'
      ],
      'risk_level': 'Medium',
      'alerts': [
        'Few areas have lifeguards; stay within waist-deep if unfamiliar.',
        'Watch for rip currents; avoid river mouths and rocky headlands.',
        'Possible jellyfish during hot months — use vinegar for stings.',
        'Use reef-safe sunscreen; do not step on or touch corals.',
      ],
      'active_alerts': [
        {
          'type': 'Weather',
          'message':
              'Strong onshore winds at Dinadiawan — not advised for beginners',
          'severity': 'Medium',
          'time': '30 minutes ago',
        }
      ],
    },
    {
      'name': 'Giant Balete Tree & Nature Parks',
      'icon': Icons.park,
      'color': Colors.brown,
      'locations': [
        'Millennium (Balete) Tree - Maria Aurora',
        'Aurora Memorial National Park'
      ],
      'risk_level': 'Low',
      'alerts': [
        'Watch footing around exposed roots; surfaces can be slippery.',
        'Use insect protection and stay on marked paths.',
        'Respect site rules; no carving, picking, or littering.',
        'Keep noise low to protect wildlife and other visitors\' experience.',
      ],
      'active_alerts': [],
    },
    {
      'name': 'Heritage Walk (Baler Town)',
      'icon': Icons.museum,
      'color': Colors.orange,
      'locations': [
        'Museo de Baler',
        'Ermita Hill',
        'Baler Church (San Luis Obispo de Tolosa)'
      ],
      'risk_level': 'Low',
      'alerts': [
        'Hydrate and wear sun protection; mid-day heat can be extreme.',
        'Secure valuables; expect crowds on weekends and holidays.',
        'Follow heritage-site rules; avoid touching artifacts or displays.',
        'Check opening hours and weather-related closures.',
      ],
      'active_alerts': [],
    },
    {
      'name': 'Boating/Kayaking (Aurora Bays)',
      'icon': Icons.directions_boat,
      'color': Colors.cyan,
      'locations': ['Baler Bay', 'Dingalan Bay', 'Casiguran Sound'],
      'risk_level': 'High',
      'alerts': [
        'Life vests required at all times; follow boat crew instructions.',
        'Check weather bulletins and tide/wave forecasts before departure.',
        'Stay within safety markers; beware of rip and cross-currents.',
        'Coordinate with the Coast Guard for permits/clearance when needed.',
      ],
      'active_alerts': [
        {
          'type': 'Safety',
          'message':
              'High tide and strong winds in Dingalan Bay — small craft advisory',
          'severity': 'High',
          'time': '45 minutes ago',
        }
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    if (selectedActivity == 'All Activities') {
      return activities;
    }
    return activities
        .where((activity) => activity['name'] == selectedActivity)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: white),
            onPressed: () {
              _showAllAlerts();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: primary,
            child: TabBar(
              controller: _tabController,
              indicatorColor: white,
              labelColor: white,
              unselectedLabelColor: white.withOpacity(0.7),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, size: 20),
                      const SizedBox(width: 8),
                      TextWidget(
                        text: 'Map',
                        fontSize: 14,
                        color: white,
                        fontFamily: 'Medium',
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.safety_divider, size: 20),
                      const SizedBox(width: 8),
                      TextWidget(
                        text: 'Safety Guide',
                        fontSize: 14,
                        color: white,
                        fontFamily: 'Medium',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Map Tab
                _buildMapTab(),
                // Safety Guide Tab
                _buildSafetyGuideTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapTab() {
    return Padding(
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
    );
  }

  Widget _buildSafetyGuideTab() {
    return Column(
      children: [
        // Header with Safety Overview
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(color: primary.withOpacity(0.2)),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.safety_divider,
                    color: primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    text: 'Risk Detection & Safety Alerts',
                    fontSize: 16,
                    color: black,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextWidget(
                text:
                    'Real-time safety notifications for your activities in Aurora',
                fontSize: 12,
                color: grey,
                fontFamily: 'Regular',
              ),
            ],
          ),
        ),

        // Activity Filter
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: [
              'All Activities',
              ...activities.map((a) => a['name']).toList()
            ].length,
            itemBuilder: (context, index) {
              final activity =
                  index == 0 ? 'All Activities' : activities[index - 1]['name'];
              final isSelected = selectedActivity == activity;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedActivity = activity;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? primary : grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? primary : grey),
                    ),
                    child: TextWidget(
                      text: activity,
                      fontSize: 12,
                      color: isSelected ? white : black,
                      fontFamily: isSelected ? 'Bold' : 'Regular',
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Activities List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredActivities.length,
            itemBuilder: (context, index) {
              final activity = filteredActivities[index];
              return _buildActivityCard(activity);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final activeAlerts = activity['active_alerts'] as List<dynamic>;
    final hasActiveAlerts = activeAlerts.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          color: hasActiveAlerts
              ? Colors.red.withOpacity(0.3)
              : activity['color'].withOpacity(0.3),
          width: hasActiveAlerts ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          // Activity Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: activity['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    activity['icon'],
                    color: activity['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: activity['name'],
                        fontSize: 18,
                        color: black,
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        text: 'Risk Level: ${activity['risk_level']}',
                        fontSize: 12,
                        color: _getRiskColor(activity['risk_level']),
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        text: activity['locations'].join(', '),
                        fontSize: 12,
                        color: grey,
                        fontFamily: 'Regular',
                      ),
                    ],
                  ),
                ),
                if (hasActiveAlerts)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextWidget(
                      text:
                          '${activeAlerts.length} Alert${activeAlerts.length > 1 ? 's' : ''}',
                      fontSize: 10,
                      color: Colors.red,
                      fontFamily: 'Bold',
                    ),
                  ),
              ],
            ),
          ),

          // Active Alerts
          if (hasActiveAlerts) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                border: Border(
                  top: BorderSide(color: Colors.red.withOpacity(0.2)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      TextWidget(
                        text: 'Active Alerts',
                        fontSize: 14,
                        color: Colors.red,
                        fontFamily: 'Bold',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...activeAlerts
                      .map((alert) => _buildAlertItem(alert))
                      .toList(),
                ],
              ),
            ),
          ],

          // Safety Tips
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Safety Guidelines',
                  fontSize: 14,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 8),
                ...(activity['alerts'] as List<String>)
                    .map(
                      (tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: primary,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextWidget(
                                text: tip,
                                fontSize: 12,
                                color: grey,
                                fontFamily: 'Regular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        label: 'View',
                        onPressed: () => _showActivityDetails(activity),
                        color: activity['color'],
                        textColor: white,
                        height: 36,
                        radius: 8,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ButtonWidget(
                      label: 'Emergency',
                      onPressed: () => _showEmergencyContacts(activity),
                      color: Colors.red,
                      textColor: white,
                      height: 36,
                      radius: 8,
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color severityColor;
    switch (alert['severity']) {
      case 'High':
        severityColor = Colors.red;
        break;
      case 'Medium':
        severityColor = Colors.orange;
        break;
      default:
        severityColor = Colors.yellow;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: severityColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: severityColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: severityColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: alert['message'],
                  fontSize: 12,
                  color: black,
                  fontFamily: 'Medium',
                ),
                TextWidget(
                  text: '${alert['type']} • ${alert['time']}',
                  fontSize: 10,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return grey;
    }
  }

  void _showActivityDetails(Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(activity['icon'], color: activity['color']),
            const SizedBox(width: 8),
            TextWidget(
              text: activity['name'],
              fontSize: 18,
              color: black,
              fontFamily: 'Bold',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Locations:',
              fontSize: 14,
              color: black,
              fontFamily: 'Bold',
            ),
            const SizedBox(height: 4),
            ...activity['locations'].map(
              (location) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: TextWidget(
                  text: '• $location',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextWidget(
              text: 'Safety Guidelines:',
              fontSize: 14,
              color: black,
              fontFamily: 'Bold',
            ),
            const SizedBox(height: 4),
            ...(activity['alerts'] as List<String>).map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: TextWidget(
                  text: '• $tip',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Close',
              fontSize: 14,
              color: primary,
              fontFamily: 'Medium',
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyContacts(Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: Colors.red),
            const SizedBox(width: 8),
            TextWidget(
              text: 'Emergency Contacts',
              fontSize: 18,
              color: black,
              fontFamily: 'Bold',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmergencyContact('Police', '117'),
            _buildEmergencyContact('Fire Department', '118'),
            _buildEmergencyContact('Ambulance', '119'),
            _buildEmergencyContact('Coast Guard', '+639123456789'),
            _buildEmergencyContact('Local Rescue', '+639123456790'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Close',
              fontSize: 14,
              color: primary,
              fontFamily: 'Medium',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: name,
            fontSize: 14,
            color: black,
            fontFamily: 'Medium',
          ),
          TextWidget(
            text: number,
            fontSize: 14,
            color: Colors.red,
            fontFamily: 'Bold',
          ),
        ],
      ),
    );
  }

  void _showAllAlerts() {
    final allAlerts = activities
        .expand((activity) =>
            (activity['active_alerts'] as List<dynamic>).map((alert) => {
                  'activity': activity['name'],
                  'alert': alert,
                }))
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextWidget(
          text: 'All Active Alerts',
          fontSize: 18,
          color: black,
          fontFamily: 'Bold',
        ),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: allAlerts.isEmpty
                ? [
                    TextWidget(
                      text: 'No active alerts at the moment.',
                      fontSize: 14,
                      color: grey,
                      fontFamily: 'Regular',
                    ),
                  ]
                : allAlerts
                    .map(
                      (item) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text:
                                  '${item['activity']} - ${item['alert']['type']}',
                              fontSize: 12,
                              color: black,
                              fontFamily: 'Bold',
                            ),
                            TextWidget(
                              text: item['alert']['message'],
                              fontSize: 11,
                              color: grey,
                              fontFamily: 'Regular',
                            ),
                            TextWidget(
                              text: item['alert']['time'],
                              fontSize: 10,
                              color: grey,
                              fontFamily: 'Regular',
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Close',
              fontSize: 14,
              color: primary,
              fontFamily: 'Medium',
            ),
          ),
        ],
      ),
    );
  }
}
