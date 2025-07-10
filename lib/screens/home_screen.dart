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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        elevation: 4,
        shadowColor: grey.withOpacity(0.3),
        title: TextWidget(
          text: 'AuTour',
          fontSize: 22,
          color: white,
          fontFamily: 'Bold',
          align: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context, LoginScreen());
            },
            icon: const Icon(Icons.logout, size: 26),
          ),
        ],
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel
                _buildImageCarousel(),
                const SizedBox(height: 16),
                // Welcome Section
                TextWidget(
                  text: 'Welcome to Aurora Province',
                  fontSize: 28,
                  color: primary,
                  fontFamily: 'Bold',
                  align: TextAlign.left,
                ),
                const SizedBox(height: 8),
                TextWidget(
                  text:
                      'Explore lush landscapes, vibrant culture, and sustainable travel experiences in Aurora.',
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                // Feature Grid
                _buildFeatureGrid(context),
                const SizedBox(height: 30),
                // Community Stories Section
                TextWidget(
                  text: 'Explore Local Communities',
                  fontSize: 20,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text:
                          'Discover the heart of Aurora through its people, heritage, and eco-conscious practices.',
                      fontSize: 14,
                      color: grey,
                      fontFamily: 'Regular',
                    ),
                    const SizedBox(height: 12),
                    ButtonWidget(
                      label: 'Explore Community Stories',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CommunityScreen()),
                        );
                      },
                      color: primary,
                      textColor: white,
                      width: double.infinity,
                      height: 50,
                      radius: 12,
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                viewportFraction: 1.0,
              ),
              items: images.map((imageUrl) {
                return Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: grey.withOpacity(0.2),
                    child: Center(
                      child: TextWidget(
                        text: 'Image Unavailable',
                        fontSize: 14,
                        color: grey,
                        fontFamily: 'Regular',
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    black.withOpacity(0.3),
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
      },
      {
        'title': 'Smart Tourism Guide',
        'description': 'Explore maps and eco-tourism sites',
        'icon': Icons.map_outlined,
        'screen': const SmartTourismGuideScreen(),
      },
      {
        'title': 'Local Businesses',
        'description': 'Find accommodations and dining',
        'icon': Icons.storefront_outlined,
        'screen': const LocalBusinessesScreen(),
      },
      {
        'title': 'Disaster Preparedness',
        'description': 'Stay safe with real-time alerts',
        'icon': Icons.warning_amber_outlined,
        'screen': const DisasterPreparednessScreen(),
      },
      {
        'title': 'Travel Planner',
        'description': 'Customize your adventure',
        'icon': Icons.event_note_outlined,
        'screen': const TravelPlannerScreen(),
      },
      {
        'title': 'Cultural Preservation',
        'description': 'Engage with local heritage',
        'icon': Icons.people_outline,
        'screen': const CommunityScreen(),
      },
      {
        'title': 'QR Code Pass',
        'description': 'Access attractions easily',
        'icon': Icons.qr_code_outlined,
        'screen': const QrCodeTouristPassScreen(),
      },
      {
        'title': 'Health Surveillance',
        'description': 'Ensure safety with health checks',
        'icon': Icons.health_and_safety_outlined,
        'screen': const HealthSurveillanceScreen(),
      },
      {
        'title': 'Common Dialects',
        'description': 'Learn local phrases and dialects',
        'icon': Icons.language_outlined,
        'screen': const CommonDialectsScreen(),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2.5,
      ),
      itemBuilder: (context, index) {
        final feature = features[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => feature['screen'] as Widget),
            );
          },
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    feature['icon'] as IconData,
                    size: 30,
                    color: primary,
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
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
