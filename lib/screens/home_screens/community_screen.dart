import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {
        'title': 'The Legend of Maria Aurora',
        'author': 'Lola Nena • Baler',
        'content':
            'A tale passed down for generations about a young maiden who protected the forest. Her bravery symbolizes Aurora\'s cultural strength.',
        'image':
            'https://outoftownblog.com/wp-content/uploads/2014/03/Dona-Aurora-Aragon-Quezon-House-600x398.jpg'
      },
      {
        'title': 'Preserving the Bayanihan Spirit',
        'author': 'Barangay San Luis Youth',
        'content':
            'During community festivals, we practice bayanihan by helping each family prepare. This tradition reminds us to uplift one another.',
        'image':
            'https://outoftownblog.com/wp-content/uploads/2014/03/Dona-Aurora-Aragon-Quezon-House-600x398.jpg'
      },
      {
        'title': 'Eco-Guiding by the Elders',
        'author': 'Manong Rudy • Casiguran',
        'content':
            'We guide visitors to our eco-sites, ensuring they understand the sacredness of nature and the importance of protecting it.',
        'image':
            'https://outoftownblog.com/wp-content/uploads/2014/03/Dona-Aurora-Aragon-Quezon-House-600x398.jpg'
      },
    ];

    final heritageItems = [
      {
        'title': 'Aurora Ancestral Languages',
        'description':
            'Languages like Ilongot, Tagalog, and Kapampangan reflect Aurora\'s identity. These preserve chants, rituals, and oral storytelling.',
      },
      {
        'title': 'Traditional Dances & Music',
        'description':
            'Enjoy performances of Pandanggo, Harana, and tribal drumming. These arts show the creativity and soul of the community.',
      },
      {
        'title': 'Cultural Dos and Don\'ts',
        'description':
            'Respect rituals, remove shoes in sacred homes, greet elders with honor, and observe traditions with mindfulness.',
      },
    ];

    final rulesAndRegulations = [
      {
        'title': 'Environmental Protection',
        'items': [
          'No littering in beaches, mountains, and public areas',
          'Proper waste disposal in designated bins only',
          'No collection of corals, shells, or marine life',
          'Respect protected areas and wildlife sanctuaries',
          'Follow designated trails in forest areas',
        ]
      },
      {
        'title': 'Cultural Respect',
        'items': [
          'Ask permission before taking photos of locals',
          'Respect sacred sites and religious ceremonies',
          'Dress modestly when visiting cultural sites',
          'Learn basic greetings in local languages',
          'Support local artisans and craftsmen',
        ]
      },
      {
        'title': 'Safety Guidelines',
        'items': [
          'Always inform local guides of your plans',
          'Carry emergency contact information',
          'Follow weather advisories and warnings',
          'Stay on marked paths and designated areas',
          'Respect swimming and diving restrictions',
        ]
      },
      {
        'title': 'Community Guidelines',
        'items': [
          'Support local businesses and services',
          'Participate in community activities when invited',
          'Respect quiet hours in residential areas',
          'Learn about local customs and traditions',
          'Contribute to community development projects',
        ]
      },
    ];

    final sustainabilityInfo = [
      {
        'title': 'Eco-Tourism Initiatives',
        'description': 'Aurora promotes sustainable tourism practices that protect natural resources while supporting local communities.',
        'initiatives': [
          'Community-based tourism programs',
          'Eco-friendly accommodation options',
          'Local guide training and certification',
          'Waste management and recycling programs',
          'Renewable energy projects in remote areas',
        ]
      },
      {
        'title': 'Conservation Efforts',
        'description': 'Active protection of Aurora\'s unique biodiversity and natural habitats.',
        'initiatives': [
          'Marine protected areas and sanctuaries',
          'Forest conservation and reforestation',
          'Wildlife protection and monitoring',
          'Water resource management',
          'Sustainable fishing practices',
        ]
      },
      {
        'title': 'Cultural Preservation',
        'description': 'Safeguarding indigenous knowledge, traditions, and cultural heritage for future generations.',
        'initiatives': [
          'Traditional knowledge documentation',
          'Cultural heritage site protection',
          'Indigenous language preservation',
          'Traditional craft revival programs',
          'Cultural education and awareness',
        ]
      },
    ];

    final touristPreservation = [
      {
        'title': 'Responsible Tourism Practices',
        'description': 'Guidelines for visitors to minimize environmental impact and support local communities.',
        'practices': [
          'Use eco-friendly transportation options',
          'Choose locally-owned accommodations',
          'Purchase souvenirs from local artisans',
          'Respect wildlife and natural habitats',
          'Participate in community-led tours',
        ]
      },
      {
        'title': 'Cultural Sensitivity',
        'description': 'Understanding and respecting local customs, traditions, and social norms.',
        'practices': [
          'Learn about local customs before visiting',
          'Dress appropriately for cultural sites',
          'Ask permission before taking photos',
          'Respect religious and spiritual practices',
          'Support cultural preservation efforts',
        ]
      },
      {
        'title': 'Environmental Stewardship',
        'description': 'Active participation in protecting Aurora\'s natural environment and resources.',
        'practices': [
          'Follow Leave No Trace principles',
          'Use biodegradable and eco-friendly products',
          'Conserve water and energy resources',
          'Support environmental protection programs',
          'Report environmental violations',
        ]
      },
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Community & Cultural Preservation',
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
            fontSize: 22,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 8),
          TextWidget(
            text:
                'Located in the eastern part of Luzon, Aurora is a hidden gem filled with lush mountains, scenic coastlines, and a rich blend of indigenous and colonial culture. It is known for sustainable tourism, ancestral traditions, and a strong sense of community.',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
            maxLines: 20,
          ),
          const SizedBox(height: 24),
          TextWidget(
            text: 'Community Engagement',
            fontSize: 22,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 8),
          TextWidget(
            text:
                'Aurora\'s people actively preserve and promote their heritage. Through storytelling, eco-guiding, music, and tradition, locals keep their cultural identity alive while embracing eco-tourism.',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
            maxLines: 20,
          ),
          const SizedBox(height: 24),
          TextWidget(
            text: 'Voices of Aurora',
            fontSize: 20,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 8),
          ...stories.map((story) => _buildStoryCard(context, story)).toList(),
          const SizedBox(height: 24),
          TextWidget(
            text: 'Heritage Education',
            fontSize: 20,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 12),
          ...heritageItems.map((item) => _buildHeritageCard(item)).toList(),
          const SizedBox(height: 24),
          TextWidget(
            text: 'Rules & Regulations',
            fontSize: 20,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 12),
          ...rulesAndRegulations.map((rule) => _buildRulesCard(rule)).toList(),
          const SizedBox(height: 24),
          TextWidget(
            text: 'Sustainability Initiatives',
            fontSize: 20,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 12),
          ...sustainabilityInfo.map((info) => _buildSustainabilityCard(info)).toList(),
          const SizedBox(height: 24),
          TextWidget(
            text: 'Tourist Preservation Guidelines',
            fontSize: 20,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 12),
          ...touristPreservation.map((preservation) => _buildPreservationCard(preservation)).toList(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, Map<String, String> story) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _StoryDetailScreen(story: story),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                story['image']!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: story['title']!,
                    fontSize: 16,
                    color: white,
                    fontFamily: 'Bold',
                  ),
                  TextWidget(
                    text: story['author']!,
                    fontSize: 12,
                    color: white.withOpacity(0.85),
                    fontFamily: 'Regular',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeritageCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: secondary.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://outoftownblog.com/wp-content/uploads/2014/03/Dona-Aurora-Aragon-Quezon-House-600x398.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: item['title']!,
                fontSize: 16,
                color: primary,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 225,
                child: TextWidget(
                  text: item['description']!,
                  fontSize: 13,
                  color: black,
                  fontFamily: 'Regular',
                  maxLines: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRulesCard(Map<String, dynamic> rule) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: secondary.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: rule['title']!,
            fontSize: 18,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 12),
          ...rule['items']!.map((item) => _buildRuleItem(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextWidget(
              text: item,
              fontSize: 14,
              color: black,
              fontFamily: 'Regular',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSustainabilityCard(Map<String, dynamic> info) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: secondary.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: info['title']!,
            fontSize: 18,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 12),
          TextWidget(
            text: info['description']!,
            fontSize: 14,
            color: black,
            fontFamily: 'Regular',
          ),
          const SizedBox(height: 12),
          ...info['initiatives']!.map((initiative) => _buildSustainabilityItem(initiative)).toList(),
        ],
      ),
    );
  }

  Widget _buildSustainabilityItem(String item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.trending_up, color: primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextWidget(
              text: item,
              fontSize: 14,
              color: black,
              fontFamily: 'Regular',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreservationCard(Map<String, dynamic> preservation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: secondary.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: preservation['title']!,
            fontSize: 18,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 12),
          TextWidget(
            text: preservation['description']!,
            fontSize: 14,
            color: black,
            fontFamily: 'Regular',
          ),
          const SizedBox(height: 12),
          ...preservation['practices']!.map((practice) => _buildPreservationItem(practice)).toList(),
        ],
      ),
    );
  }

  Widget _buildPreservationItem(String item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.handshake, color: primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextWidget(
              text: item,
              fontSize: 14,
              color: black,
              fontFamily: 'Regular',
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryDetailScreen extends StatelessWidget {
  final Map<String, String> story;

  const _StoryDetailScreen({required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: story['title']!,
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              story['image']!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          TextWidget(
            text: story['title']!,
            fontSize: 20,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 6),
          TextWidget(
            text: story['author']!,
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          const SizedBox(height: 16),
          TextWidget(
            text: story['content']!,
            fontSize: 14,
            color: black,
            fontFamily: 'Regular',
            maxLines: 50,
          ),
        ],
      ),
    );
  }
}
