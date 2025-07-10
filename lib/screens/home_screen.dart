import 'package:autour_mobile/screens/home_screens/health.surveillance_screen.dart';
import 'package:flutter/material.dart';
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
        elevation: 0,
        title: TextWidget(
          text: 'AuTour',
          fontSize: 20,
          color: white,
          fontFamily: 'Bold',
          align: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context, LoginScreen());
            },
            icon: const Icon(Icons.logout),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://outoftownblog.com/wp-content/uploads/2014/03/Dona-Aurora-Aragon-Quezon-House-600x398.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              TextWidget(
                text: 'Welcome to Aurora Province',
                fontSize: 24,
                color: primary,
                fontFamily: 'Bold',
                align: TextAlign.left,
              ),
              const SizedBox(height: 8),
              TextWidget(
                text:
                    'Discover lush landscapes, historic culture, and meaningful community through modern and sustainable travel tools.',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
              ),
              const SizedBox(height: 24),
              _buildFeatureGrid(context),
              const SizedBox(height: 30),
              TextWidget(
                text: 'Explore Local Communities',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 8),
              TextWidget(
                text:
                    'Get to know the heart of Aurora through its people, heritage, and eco-conscious practices.',
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
                    MaterialPageRoute(builder: (_) => const CommunityScreen()),
                  );
                },
                color: primary,
                textColor: white,
                width: double.infinity,
                height: 48,
                radius: 10,
                fontSize: 14,
              ),
            ],
          ),
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
        'screen': HealthSurveillanceScreen()
      },
      {
        'title': 'Common Dialects',
        'description': 'Learn local phrases and dialects',
        'icon': Icons.language_outlined,
        'screen': const PlaceholderScreen(title: 'Common Dialects'),
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
        childAspectRatio: 3 / 2.3,
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
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.15),
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
                  size: 28,
                  color: primary,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  text: feature['title'] as String,
                  fontSize: 14,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 4),
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
        );
      },
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: title,
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: TextWidget(
          text: '$title - Coming Soon',
          fontSize: 20,
          color: primary,
          fontFamily: 'Bold',
          align: TextAlign.center,
        ),
      ),
    );
  }
}
