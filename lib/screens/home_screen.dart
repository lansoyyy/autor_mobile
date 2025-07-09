import 'package:autour_mobile/screens/auth/login_screen.dart';
import 'package:autour_mobile/screens/home_screens/chatbot_screen.dart';
import 'package:autour_mobile/screens/home_screens/community_screen.dart';
import 'package:autour_mobile/screens/home_screens/disaster.preparedness_screen.dart';
import 'package:autour_mobile/screens/home_screens/local.businesses_screen.dart';
import 'package:autour_mobile/screens/home_screens/travel.planner_screen.dart';
import 'package:autour_mobile/widgets/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';

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
            icon: Icon(
              Icons.logout,
            ),
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
              // Welcome Header
              TextWidget(
                text: 'Welcome to Aurora Province',
                fontSize: 24,
                color: primary,
                fontFamily: 'Bold',
                align: TextAlign.left,
              ),
              const SizedBox(height: 8),
              TextWidget(
                text: 'Discover, plan, and explore with AuTour',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
                align: TextAlign.left,
              ),
              const SizedBox(height: 20),
              // Feature Cards
              _buildFeatureCard(
                context,
                title: 'AI-Powered Chatbot',
                description: 'Get instant answers and accessibility info',
                icon: Icons.chat_bubble_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatbotScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                context,
                title: 'Smart Tourism Guide',
                description: 'Explore interactive maps and eco-tourism sites',
                icon: Icons.map_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlaceholderScreen(
                            title: 'Smart Tourism Guide')),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                context,
                title: 'Local Businesses',
                description: 'Discover accommodations, dining, and services',
                icon: Icons.storefront_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocalBusinessesScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                context,
                title: 'Disaster Preparedness & Weather',
                description: 'Stay safe with real-time alerts',
                icon: Icons.warning_amber_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DisasterPreparednessScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                context,
                title: 'Personalized Travel Planner',
                description: 'Customize your Aurora adventure',
                icon: Icons.event_note_outlined,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TravelPlannerScreen()));
                },
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                context,
                title: 'Community & Cultural Preservation',
                description: 'Engage with local stories and heritage',
                icon: Icons.people_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommunityScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                context,
                title: 'QR Code Tourist Pass',
                description: 'Access attractions and services seamlessly',
                icon: Icons.qr_code_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PlaceholderScreen(title: 'QR Code Pass')),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Quick Action Button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: primary,
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
                    align: TextAlign.left,
                  ),
                  const SizedBox(height: 4),
                  TextWidget(
                    text: description,
                    fontSize: 12,
                    color: grey,
                    fontFamily: 'Regular',
                    align: TextAlign.left,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: grey,
              size: 16,
            ),
          ],
        ),
      ),
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
