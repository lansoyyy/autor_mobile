import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/screens/home_screens/chatbot_screen.dart';
import 'package:autour_mobile/screens/home_screens/community_screen.dart';
import 'package:autour_mobile/screens/home_screens/disaster.preparedness_screen.dart';
import 'package:autour_mobile/screens/home_screens/local.businesses_screen.dart';
import 'package:autour_mobile/screens/home_screens/travel.planner_screen.dart';
import 'package:autour_mobile/screens/home_screens/qrcode.pass_screen.dart';
import 'package:autour_mobile/screens/home_screens/tourism.guide_screen.dart';
import 'package:autour_mobile/screens/home_screens/common.dialects_screen.dart';
import 'package:autour_mobile/screens/home_screens/health.surveillance_screen.dart';
import 'package:autour_mobile/widgets/logout_widget.dart';
import 'package:autour_mobile/screens/auth/login_screen.dart';

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
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
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
                          text: 'Explore Local Communities',
                          fontSize: 22,
                          color: black,
                          fontFamily: 'Bold',
                        ),
                        const SizedBox(height: 12),
                        TextWidget(
                          text:
                              'Discover the heart of Aurora through its people, heritage, and eco-conscious practices.',
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CommunityScreen()),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Center(
                                child: TextWidget(
                                  text: 'Explore Community Stories',
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
}
