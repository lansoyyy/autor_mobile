import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {
        'title': 'The Legend of Maria Aurora',
        'author': 'Lola Nena • Baler',
        'content':
            'A tale passed down for generations about a young maiden who protected the forest. Her bravery symbolizes Aurora’s cultural strength.',
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
            'Languages like Ilongot, Tagalog, and Kapampangan reflect Aurora’s identity. These preserve chants, rituals, and oral storytelling.',
      },
      {
        'title': 'Traditional Dances & Music',
        'description':
            'Enjoy performances of Pandanggo, Harana, and tribal drumming. These arts show the creativity and soul of the community.',
      },
      {
        'title': 'Cultural Dos and Don’ts',
        'description':
            'Respect rituals, remove shoes in sacred homes, greet elders with honor, and observe traditions with mindfulness.',
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
                'Aurora’s people actively preserve and promote their heritage. Through storytelling, eco-guiding, music, and tradition, locals keep their cultural identity alive while embracing eco-tourism.',
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
