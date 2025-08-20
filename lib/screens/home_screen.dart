import 'package:autour_mobile/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/utils/const.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';
import 'package:autour_mobile/widgets/drawer_widget.dart';
import 'package:autour_mobile/widgets/logout_widget.dart';
import 'package:autour_mobile/screens/home_screens/chatbot_screen.dart';
import 'package:autour_mobile/screens/home_screens/common.dialects_screen.dart';
import 'package:autour_mobile/screens/home_screens/community_screen.dart';
import 'package:autour_mobile/screens/home_screens/disaster.preparedness_screen.dart';
import 'package:autour_mobile/screens/home_screens/health.surveillance_screen.dart';
import 'package:autour_mobile/screens/home_screens/local.businesses_screen.dart';
import 'package:autour_mobile/screens/home_screens/qrcode.pass_screen.dart';
import 'package:autour_mobile/screens/home_screens/tourism.guide_screen.dart';
import 'package:autour_mobile/screens/home_screens/travel.planner_screen.dart';
import 'package:autour_mobile/screens/itinerary_screen.dart';
import 'package:autour_mobile/widgets/date_picker_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:autour_mobile/screens/home_screens/emergency_hotlines_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  Timer? _locationTimer;

  @override
  void initState() {
    super.initState();

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideAnimationController.forward();
    });
    // Show location info and enforce location services/permission after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLocationPermissionDialog();
      _initLocationEnforcement();
    });
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    _stopLocationUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: TextWidget(
          text: 'AuTour',
          fontSize: 24,
          color: white,
          fontFamily: 'Bold',
          align: TextAlign.center,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                logout(context, LoginScreen());
              },
              icon: const Icon(Icons.logout, size: 24),
            ),
          ),
        ],
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: TextWidget(
              text: 'Logo',
              fontSize: 14,
              color: white,
              fontFamily: 'Bold',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Carousel
                  _buildImageCarousel(),
                  const SizedBox(height: 24),

                  // Welcome Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: primary.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Welcome to Aurora Province',
                          fontSize: 28,
                          color: primary,
                          fontFamily: 'Bold',
                          align: TextAlign.left,
                        ),
                        const SizedBox(height: 12),
                        TextWidget(
                          text:
                              'Explore lush landscapes, vibrant culture, and sustainable travel experiences in Aurora.',
                          fontSize: 16,
                          color: grey,
                          fontFamily: 'Regular',
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Feature Grid
                  _buildFeatureGrid(context),
                  const SizedBox(height: 40),

                  // Community Stories Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Emergency Assistance',
                          fontSize: 22,
                          color: black,
                          fontFamily: 'Bold',
                        ),
                        const SizedBox(height: 12),
                        TextWidget(
                          text:
                              'Quick access to emergency hotlines, police, fire, medical, and disaster response services in Aurora.',
                          fontSize: 16,
                          color: grey,
                          fontFamily: 'Regular',
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _showEmergencyConfirmationDialog(context);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Center(
                                child: TextWidget(
                                  text: 'Emergency',
                                  fontSize: 16,
                                  color: white,
                                  fontFamily: 'Bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 30),

                  // // AI-Powered Risk Detection & Alert Delivery
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: [
                  //         Colors.orange.withOpacity(0.1),
                  //         Colors.red.withOpacity(0.05),
                  //       ],
                  //     ),
                  //     borderRadius: BorderRadius.circular(16),
                  //     border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Container(
                  //             padding: const EdgeInsets.all(8),
                  //             decoration: BoxDecoration(
                  //               color: Colors.orange.withOpacity(0.2),
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             child: Icon(
                  //               Icons.psychology,
                  //               color: Colors.orange,
                  //               size: 24,
                  //             ),
                  //           ),
                  //           const SizedBox(width: 12),
                  //           Expanded(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 TextWidget(
                  //                   text: 'AI-Powered Risk Detection',
                  //                   fontSize: 18,
                  //                   color: black,
                  //                   fontFamily: 'Bold',
                  //                 ),
                  //                 TextWidget(
                  //                   text:
                  //                       'Real-time safety alerts based on your location',
                  //                   fontSize: 12,
                  //                   color: grey,
                  //                   fontFamily: 'Regular',
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 16),

                  //       // Active Alerts
                  //       _buildActiveAlert(
                  //         'Swimming at Mother Falls',
                  //         'Reminder: Sudden water surges may occur at Mother Falls during heavy rain. Please avoid swimming during red alert conditions.',
                  //         Icons.pool,
                  //         Colors.blue,
                  //         'High Risk',
                  //         '2 minutes ago',
                  //       ),

                  //       const SizedBox(height: 12),

                  //       _buildActiveAlert(
                  //         'Picnic near Landslide Zone',
                  //         'You\'re picnicking near a landslide-prone zone. Please stay alert for falling rocks and avoid setting up near steep slopes.',
                  //         Icons.table_bar,
                  //         Colors.orange,
                  //         'Medium Risk',
                  //         '5 minutes ago',
                  //       ),

                  //       const SizedBox(height: 16),

                  //       Center(
                  //         child: ButtonWidget(
                  //           width: 300,
                  //           label: 'Safety Guide',
                  //           onPressed: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (_) =>
                  //                     const SmartTourismGuideScreen(),
                  //               ),
                  //             );
                  //           },
                  //           color: primary,
                  //           textColor: white,
                  //           height: 40,
                  //           radius: 8,
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    final List<String> images = [
      'https://ik.imagekit.io/tvlk/blog/2017/10/Dicasalarin-Cove-750x469.jpg?tr=q-70,c-at_max,w-500,h-300,dpr-2',
      'https://outoftownblog.com/wp-content/uploads/2014/03/Dona-Aurora-Aragon-Quezon-House-600x398.jpg',
      'https://lakbaypinas.com/wp-content/uploads/2024/10/Snapinsta.app_47414388_588105308300029_3756977274192887370_n_1080.jpg',
    ];

    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 220,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                autoPlayCurve: Curves.easeInOut,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
              items: images.map((imageUrl) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: BoxDecoration(
                        color: grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 48,
                              color: grey,
                            ),
                            const SizedBox(height: 8),
                            TextWidget(
                              text: 'Image Unavailable',
                              fontSize: 16,
                              color: grey,
                              fontFamily: 'Regular',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    black.withOpacity(0.4),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      {
        'title': 'AI-Powered Chatbot',
        'description': 'Get instant answers and accessibility info',
        'icon': Icons.chat_bubble_outline,
        'screen': const ChatbotScreen(),
        'color': Colors.blue,
      },
      {
        'title': 'Smart Tourism Guide',
        'description': 'Explore maps and eco-tourism sites',
        'icon': Icons.map_outlined,
        'screen': const SmartTourismGuideScreen(),
        'color': Colors.green,
      },
      {
        'title': 'Local Businesses',
        'description': 'Find accommodations and dining',
        'icon': Icons.storefront_outlined,
        'screen': const LocalBusinessesScreen(),
        'color': Colors.orange,
      },
      {
        'title': 'Disaster Preparedness',
        'description': 'Stay safe with real-time alerts',
        'icon': Icons.warning_amber_outlined,
        'screen': const DisasterPreparednessScreen(),
        'color': Colors.red,
      },
      {
        'title': 'Travel Planner',
        'description': 'Customize your adventure',
        'icon': Icons.event_note_outlined,
        'screen': const TravelPlannerScreen(),
        'color': Colors.purple,
      },
      {
        'title': 'Cultural Preservation',
        'description': 'Engage with local heritage',
        'icon': Icons.people_outline,
        'screen': const CommunityScreen(),
        'color': Colors.teal,
      },
      {
        'title': 'QR Code Pass',
        'description': 'Access attractions easily',
        'icon': Icons.qr_code_outlined,
        'screen': const QrCodeTouristPassScreen(),
        'color': Colors.indigo,
      },
      {
        'title': 'Health Surveillance',
        'description': 'Ensure safety with health checks',
        'icon': Icons.health_and_safety_outlined,
        'screen': const HealthSurveillanceScreen(),
        'color': Colors.pink,
      },
      {
        'title': 'Common Dialects',
        'description': 'Learn local phrases and dialects',
        'icon': Icons.language_outlined,
        'screen': const CommonDialectsScreen(),
        'color': Colors.amber,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3 / 3.2,
      ),
      itemBuilder: (context, index) {
        final feature = features[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 600 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => feature['screen'] as Widget),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: (feature['color'] as Color).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (feature['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          size: 28,
                          color: feature['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextWidget(
                        text: feature['title'] as String,
                        fontSize: 14,
                        color: black,
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(height: 6),
                      TextWidget(
                        text: feature['description'] as String,
                        fontSize: 12,
                        color: grey,
                        fontFamily: 'Regular',
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showEmergencyConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.emergency,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(width: 8),
              TextWidget(
                text: 'Emergency Hotlines',
                fontSize: 20,
                color: black,
                fontFamily: 'Bold',
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                text: 'Do you need emergency assistance?',
                fontSize: 16,
                color: black,
                fontFamily: 'Medium',
              ),
              const SizedBox(height: 8),
              TextWidget(
                text:
                    'This will show you all available emergency contact numbers that you can call immediately.',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(
                text: 'Cancel',
                fontSize: 16,
                color: grey,
                fontFamily: 'Medium',
              ),
            ),
            ButtonWidget(
              label: 'Show Hotlines',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EmergencyHotlinesScreen(),
                  ),
                );
              },
              color: Colors.red,
              textColor: white,
              width: 120,
              height: 40,
              radius: 8,
              fontSize: 14,
            ),
          ],
        );
      },
    );
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.location_on,
                  color: primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextWidget(
                  text: 'Location Services',
                  fontSize: 18,
                  color: black,
                  fontFamily: 'Bold',
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Location monitoring is enabled for:',
                fontSize: 16,
                color: black,
                fontFamily: 'Medium',
              ),
              const SizedBox(height: 12),
              _buildLocationFeature('📍 Real-time weather updates'),
              _buildLocationFeature('🗺️ Nearby attractions and services'),
              _buildLocationFeature('🚨 Emergency alerts and notifications'),
              _buildLocationFeature('🎯 Personalized recommendations'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextWidget(
                        text:
                            'Your location data is secure and only used to enhance your experience in Aurora.',
                        fontSize: 12,
                        color: grey,
                        fontFamily: 'Regular',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ButtonWidget(
              label: 'Got it!',
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: primary,
              textColor: white,
              width: 80,
              height: 36,
              radius: 8,
              fontSize: 14,
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: primary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextWidget(
              text: feature,
              fontSize: 14,
              color: black,
              fontFamily: 'Regular',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextWidget(
              text: text,
              fontSize: 12,
              color: black,
              fontFamily: 'Regular',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveAlert(String title, String message, IconData icon,
      Color color, String riskLevel, String timeAgo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fontSize: 16,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 4),
                TextWidget(
                  text: message,
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextWidget(
                text: riskLevel,
                fontSize: 12,
                color: color,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 4),
              TextWidget(
                text: timeAgo,
                fontSize: 10,
                color: grey,
                fontFamily: 'Regular',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAllRiskAlerts() {
    // This method will navigate to a dedicated risk alerts screen
    // For now, we'll just show a simple dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget(
            text: 'Risk Alerts',
            fontSize: 20,
            color: black,
            fontFamily: 'Bold',
          ),
          content: TextWidget(
            text:
                'This feature is under development. Please check back later for more details.',
            fontSize: 16,
            color: grey,
            fontFamily: 'Regular',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(
                text: 'OK',
                fontSize: 16,
                color: primary,
                fontFamily: 'Medium',
              ),
            ),
          ],
        );
      },
    );
  }

  // Ensure location services and permission before starting updates
  Future<void> _initLocationEnforcement() async {
    final ok = await _requireLocationServiceAndPermission();
    if (ok) {
      _startLocationUpdates();
    }
  }

  // Periodic location updates every 1 minute to Firestore
  void _startLocationUpdates() {
    // Run once immediately
    _updateLocationOnce();
    // Then schedule every minute
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateLocationOnce();
    });
  }

  void _stopLocationUpdates() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  Future<void> _updateLocationOnce() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return; // not logged in

      final hasPermission = await _ensureLocationPermission();
      if (!hasPermission) return;

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
          timeLimit: Duration(minutes: 1),
        ),
      );

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'latitude': pos.latitude,
        'longitude': pos.longitude,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      // Fail silently to avoid interrupting UI; could add debug logs if needed
    }
  }

  Future<bool> _ensureLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  // Force user to enable location services and grant permission
  Future<bool> _requireLocationServiceAndPermission() async {
    // 1) Ensure services enabled
    for (int i = 0; i < 3; i++) {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (enabled) break;

      final proceed = await _showEnableLocationDialog();
      if (!proceed) return false;
      await Geolocator.openLocationSettings();
      await Future.delayed(const Duration(seconds: 2));
    }

    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    // 2) Ensure permission granted
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      final opened = await _showOpenAppSettingsDialog();
      if (!opened) return false;
      await Geolocator.openAppSettings();
      await Future.delayed(const Duration(seconds: 2));
      permission = await Geolocator.checkPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _showEnableLocationDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: TextWidget(
                text: 'Enable Location',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              content: TextWidget(
                text:
                    'Location services are required. Please enable your phone\'s location.',
                fontSize: 14,
                color: black,
                fontFamily: 'Regular',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: TextWidget(
                    text: 'Cancel',
                    fontSize: 14,
                    color: grey,
                    fontFamily: 'Medium',
                  ),
                ),
                ButtonWidget(
                  label: 'Open Settings',
                  onPressed: () => Navigator.pop(context, true),
                  color: primary,
                  textColor: white,
                  height: 40,
                  radius: 8,
                  fontSize: 14,
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _showOpenAppSettingsDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: TextWidget(
                text: 'Grant Location Permission',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              content: TextWidget(
                text:
                    'This app needs location permission. Please enable it in Settings.',
                fontSize: 14,
                color: black,
                fontFamily: 'Regular',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: TextWidget(
                    text: 'Cancel',
                    fontSize: 14,
                    color: grey,
                    fontFamily: 'Medium',
                  ),
                ),
                ButtonWidget(
                  label: 'Open Settings',
                  onPressed: () => Navigator.pop(context, true),
                  color: primary,
                  textColor: white,
                  height: 40,
                  radius: 8,
                  fontSize: 14,
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
