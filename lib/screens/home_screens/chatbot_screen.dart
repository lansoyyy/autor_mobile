import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> chatHistory = [];

  // Simple knowledge base for Aurora Province tourist Q&A
  final List<Map<String, dynamic>> _kb = [
    {
      'id': 'baler_overview',
      'keywords': [
        'baler',
        'aurora',
        'overview',
        'highlights',
        'what to do',
        'itinerary'
      ],
      'answer':
          'Baler, Aurora is famous for surfing at Sabang Beach, scenic waterfalls like Ditumabo (Mother Falls), historical spots (Museo de Baler, Doña Aurora House), and coastal views (Diguisit Rock Formations, Aniao Islets, Dicasalarin Cove). Best months: Oct–Mar for waves; Mar–Jun for calm seas.'
    },
    {
      'id': 'sabang_surfing',
      'keywords': ['sabang', 'surf', 'surfing', 'beach', 'beginner', 'lessons'],
      'answer':
          'Sabang Beach is Baler’s main surfing spot with gentle beach breaks ideal for beginners. Surf schools offer board rental (₱200–₱400/hour) and lessons (₱350–₱500/hour). Peak surf: Oct–Mar; sunrise sessions are less crowded.'
    },
    {
      'id': 'cemento_point',
      'keywords': [
        'cemento',
        'point break',
        'advanced',
        'reef',
        'right hander'
      ],
      'answer':
          'Cemento is a well-known point break for intermediate to advanced surfers. Expect stronger currents and reef—use proper booties and check conditions with local guides.'
    },
    {
      'id': 'mother_falls',
      'keywords': ['ditumabo', 'mother falls', 'falls', 'waterfall', 'trek'],
      'answer':
          'Ditumabo Mother Falls (San Luis) features a ~1.3 km trek with river crossings (30–45 mins one-way). Wear aqua shoes. Entrance/environmental fees apply. Best visited in the morning; avoid heavy rains due to strong currents.'
    },
    {
      'id': 'diguisit_dicasalarin',
      'keywords': [
        'diguisit',
        'rock formations',
        'aniao',
        'islets',
        'dicasalarin',
        'cove',
        'view'
      ],
      'answer':
          'Along the Baler–Cemento Road, Diguisit Rock Formations and Aniao Islets offer dramatic coastal views (great for sunrise). Dicasalarin Cove (private) may require an access fee/permit. Check local advisories for entry rules.'
    },
    {
      'id': 'museo_history',
      'keywords': [
        'museo de baler',
        'museum',
        'history',
        'quezon',
        'doña aurora'
      ],
      'answer':
          'Museo de Baler highlights local history and culture (Spanish era, Quezon, Doña Aurora). Nearby are historical markers and heritage houses. Great for a quick cultural stop (30–60 mins).'
    },
    {
      'id': 'dingalan',
      'keywords': ['dingalan', 'lighthouse', 'view deck', 'mountain', 'hike'],
      'answer':
          'Dingalan (southern Aurora) is known for its lighthouse/view deck hikes with stunning cliffs and Pacific views. Moderate trails; best in early morning. Check weather, bring water and sun protection.'
    },
    {
      'id': 'food_specialties',
      'keywords': [
        'food',
        'where to eat',
        'cuisine',
        'restaurants',
        'specialty',
        'bulalo',
        'seafood',
        'coffee'
      ],
      'answer':
          'Try local seafood, pancit, and bulalo. Sabang beachfront has cafés for breakfast after surf. Look for small eateries in town for affordable meals; grab local coffee or halo-halo for snacks.'
    },
    {
      'id': 'where_to_stay',
      'keywords': ['stay', 'hotel', 'resort', 'accommodation', 'homestay'],
      'answer':
          'Stay near Sabang Beach for easy surf access (from budget hostels to midrange resorts). Homestays offer local vibes and lower cost. Book early on weekends and holidays.'
    },
    {
      'id': 'transport_local',
      'keywords': [
        'tricycle',
        'transport',
        'around',
        'get around',
        'rent',
        'motorbike'
      ],
      'answer':
          'Getting around Baler: tricycles are the most common. Some shops offer bicycle/motorbike rentals. Ask your accommodation for reliable contacts and current rates.'
    },
    {
      'id': 'accessibility',
      'keywords': ['accessible', 'wheelchair', 'pwd', 'barrier-free', 'ramps'],
      'answer':
          'For accessibility: Sabang Beach promenade has relatively level paths; some hotels/cafes provide ramps. Museums and town center spots are easier to access. Waterfalls and coves are generally not wheelchair-friendly. Always call venues ahead for the latest accessibility info.'
    },
    {
      'id': 'best_time',
      'keywords': ['best time', 'season', 'when to go', 'weather', 'rain'],
      'answer':
          'Surfing is best Oct–Mar (northeast monsoon). Calmer seas and beach weather around Mar–Jun. Rainy months (Jul–Sep) can bring rough seas and occasional road advisories—check forecasts and LGU updates before traveling.'
    },
    {
      'id': 'from_manila',
      'keywords': ['manila', 'how to get', 'directions', 'bus', 'drive'],
      'answer':
          'From Manila: by bus (e.g., Genesis JoyBus/Casual) to Baler (approx. 5–6.5 hrs depending on route); by private car via NLEX–SCTEX–Tarlac–Nueva Ecija–Aurora. Start early to avoid traffic and arrive by late morning.'
    },
    {
      'id': 'budget_family',
      'keywords': [
        'budget',
        'family',
        'kids',
        'itinerary',
        '2 days',
        'weekend'
      ],
      'answer':
          'Weekend family-friendly plan: Day 1—Museo de Baler, Sabang Beach (beginner surf, watch sunrise/sunset). Day 2—Diguisit Rock Formations/Aniao Islets for views; optional café hop. Keep waterfalls optional for families with small kids due to the trek.'
    },
    {
      'id': 'eco_tourism',
      'keywords': ['eco', 'sustainable', 'local', 'environment', 'green'],
      'answer':
          'Support local through community-run eateries and guides, choose reef-safe sunscreen, carry reusable bottles/utensils, and follow Leave No Trace principles at beaches and trails. Consider homestays and locally guided tours.'
    },
    {
      'id': 'fees_permits',
      'keywords': ['fees', 'permit', 'entrance', 'environmental fee', 'rates'],
      'answer':
          'Some attractions collect entrance or environmental fees (and optional guide fees). Rates change—prepare small cash and ask at the tourism office or your accommodation for current amounts.'
    },
    {
      'id': 'sunrise_sunset',
      'keywords': [
        'sunrise',
        'sunset',
        'golden hour',
        'photography',
        'photo spots'
      ],
      'answer':
          'Sunrise: Sabang Beach and Diguisit coast are excellent. Sunset: look westward vantage points or enjoy warm light along the beachfront. Check tide times if shooting rock formations.'
    },
    {
      'id': 'cash_atm_signal',
      'keywords': ['atm', 'cash', 'signal', 'wifi', 'internet'],
      'answer':
          'Bring enough cash—ATMs can be limited or offline. Mobile signal and data vary by spot; many cafés offer Wi‑Fi but expect occasional interruptions.'
    },
    {
      'id': 'safety',
      'keywords': [
        'safety',
        'safe',
        'hazard',
        'waves',
        'currents',
        'rain',
        'typhoon'
      ],
      'answer':
          'Follow local lifeguards and surf school advice. Avoid strong currents and river mouths during heavy rains. For treks and falls, wear proper footwear and avoid slippery rocks. Check weather advisories during monsoon months.'
    },
    {
      'id': 'camping_drone',
      'keywords': ['camping', 'tent', 'drone', 'rules', 'regulation'],
      'answer':
          'Some beachfront areas allow camping but may require permission/fees—ask the barangay or resort. For drones, follow CAAP rules and local guidelines; avoid flying near crowds and respect privacy.'
    },
    {
      'id': 'millennium_tree',
      'keywords': [
        'balete',
        'millennium tree',
        'balete park',
        'tree',
        'giant tree'
      ],
      'answer':
          'The Millennium Tree (Balete Park, Maria Aurora) is one of the largest balete trees in Asia. You can walk inside its hollow roots. Great for families—bring insect repellent and go early to avoid crowds.'
    },
    {
      'id': 'ermita_hill',
      'keywords': [
        'ermita hill',
        'viewpoint',
        'evacuation',
        'history',
        'baler view'
      ],
      'answer':
          'Ermita Hill offers a panoramic view of Baler Bay and has historical significance as an evacuation site during a 1735 tsunami. Short walk to the viewpoint—nice for sunrise or late afternoon.'
    },
    {
      'id': 'baler_church',
      'keywords': [
        'baler church',
        'san luis obispo',
        'church',
        'historical church'
      ],
      'answer':
          'The Baler Church (San Luis Obispo de Tolosa Parish) is a historic church tied to the Siege of Baler (1898–1899). It’s near the town center and Museo de Baler—easy to add to a heritage walk.'
    },
    {
      'id': 'ampere_beach',
      'keywords': [
        'ampere',
        'dipaculao',
        'boulder beach',
        'sunrise beach',
        'rocks'
      ],
      'answer':
          'Ampere Beach (Dipaculao) is known for its black boulders and dramatic sunrise. Waves can be rough—better for photos than swimming. Wear sturdy footwear when walking on rocks.'
    },
    {
      'id': 'souvenirs',
      'keywords': ['souvenir', 'pasalubong', 'market', 'handicrafts'],
      'answer':
          'For pasalubong, check local markets and souvenir shops near Sabang and town center. Look for local delicacies, shirts, keychains, and handicrafts. Bring cash for small vendors.'
    },
    {
      'id': 'parking',
      'keywords': ['parking', 'car', 'where to park', 'vehicle'],
      'answer':
          'Many resorts and cafés offer guest parking. Public spots may be limited on peak weekends—arrive early. For attractions like falls, follow designated parking areas and keep valuables out of sight.'
    },
    {
      'id': '3day_itinerary',
      'keywords': ['3 days', 'itinerary', 'long weekend', 'plan'],
      'answer':
          '3D2N idea: Day 1—Town/heritage (Museo, Baler Church), Sabang surfing. Day 2—Diguisit/Aniao coast, optional Dicasalarin; café hop. Day 3—Ditumabo Mother Falls trek; optional Ampere sunrise (Dipaculao). Adjust based on weather and family needs.'
    },
    {
      'id': 'budget_tips',
      'keywords': ['budget tips', 'cheap', 'affordable', 'cost'],
      'answer':
          'To save: travel off-peak, choose homestays, share tricycle rides, eat at local eateries, and bundle attractions in one loop to reduce transfers. Always ask rates first and bring small bills.'
    },
  ];

  // Small talk intents (greetings, thanks, bot identity, help)
  final List<Map<String, dynamic>> _smallTalk = [
    {
      'patterns': [
        'hi',
        'hello',
        'hey',
        'good morning',
        'good evening',
        'kumusta'
      ],
      'answer':
          'Hello! I\'m your AuTour assistant. How can I help with Aurora trip plans?'
    },
    {
      'patterns': ['thank you', 'thanks', 'salamat', 'appreciate it'],
      'answer': 'You\'re welcome! Happy to help. Got any other questions?'
    },
    {
      'patterns': ['who are you', 'what are you', 'bot', 'assistant'],
      'answer':
          'I\'m the AuTour travel assistant for Aurora. Ask me about Baler, surfing, waterfalls, food, and more.'
    },
    {
      'patterns': ['help', 'what can you do', 'how to use'],
      'answer':
          'You can ask: "Best time for surfing?", "Family-friendly itinerary", "How to get to Baler from Manila", or "Accessible attractions".'
    },
    {
      'patterns': ['how are you', 'what\'s up'],
      'answer': 'Doing great and ready to help plan your Aurora getaway!'
    },
    {
      'patterns': ['joke', 'funny'],
      'answer':
          'Why did the surfer bring a pencil to Sabang? In case he needed to draw a better line-up! 🏄'
    },
    {
      'patterns': ['bye', 'goodbye', 'see you', 'salamat po'],
      'answer': 'Salamat! Safe travels and see you in Aurora soon!'
    },
    {
      'patterns': ['you are great', 'nice', 'cool', 'galing mo'],
      'answer':
          'Thanks! I\'m happy to help. Anything else you\'re curious about?'
    },
  ];

  String _normalize(String s) {
    final lower = s.toLowerCase();
    final cleaned = lower.replaceAll(RegExp(r"[^a-z0-9\s]"), ' ');
    return cleaned.replaceAll(RegExp(r"\s+"), ' ').trim();
  }

  double _tokenOverlapScore(String query, List<String> keywords) {
    final qTokens = _normalize(query).split(' ').toSet();
    int hits = 0;
    for (final kw in keywords) {
      final kwTokens = _normalize(kw).split(' ');
      // hit if any token contained or equals
      final hit = kwTokens.any((t) => qTokens.contains(t));
      if (hit) hits++;
    }
    // scale by number of keywords
    return keywords.isEmpty ? 0 : hits / keywords.length;
  }

  String _generateResponse(String userInput) {
    final norm = _normalize(userInput);
    if (norm.isEmpty) {
      return 'Please enter a question about Aurora Province. For example: "Best time to visit Baler?" or "Beginner surfing spots?"';
    }

    // Small talk first
    for (final intent in _smallTalk) {
      final pats = List<String>.from(intent['patterns'] as List);
      final matched = pats.any((p) => norm.contains(_normalize(p)));
      if (matched) return intent['answer'] as String;
    }

    double bestScore = 0.0;
    Map<String, dynamic>? best;

    for (final item in _kb) {
      final score =
          _tokenOverlapScore(norm, List<String>.from(item['keywords'] as List));
      // Also bonus if the place name is contained directly
      final bonus =
          (item['keywords'] as List).any((k) => norm.contains(_normalize(k)))
              ? 0.15
              : 0.0;
      final total = score + bonus;
      if (total > bestScore) {
        bestScore = total;
        best = item;
      }
    }

    if (best != null && bestScore >= 0.15) {
      return best['answer'] as String;
    }

    // Fallback generic guidance
    return 'Here are popular Aurora picks: Surf at Sabang Beach (Baler), trek Ditumabo Mother Falls, and enjoy Diguisit Rock Formations/Aniao Islets views. For specific tips, ask: "How to get to Baler from Manila?", "Best time for surfing?", or "Family-friendly itinerary?"';
  }

  @override
  void initState() {
    super.initState();
    // Greet user on open
    chatHistory.add({
      'sender': 'bot',
      'message':
          'Welcome to AuTour! Ask me anything about Aurora Province—surfing, waterfalls, food, or travel tips.'
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      setState(() {
        final userMsg = messageController.text;
        chatHistory.add({'sender': 'user', 'message': userMsg});
        final reply = _generateResponse(userMsg);
        chatHistory.add({'sender': 'bot', 'message': reply});
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: 'AuTour Chatbot',
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
        child: Column(
          children: [
            // Chat History
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  final message = chatHistory[index];
                  final isBot = message['sender'] == 'bot';
                  return Align(
                    alignment:
                        isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isBot
                            ? grey.withOpacity(0.2)
                            : primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextWidget(
                        text: message['message']!,
                        fontSize: 14,
                        color: isBot ? black : primary,
                        fontFamily: 'Regular',
                        align: TextAlign.left,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Input Area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      label: 'Ask a question',

                      controller: messageController,
                      borderColor: primary,
                      hintColor: grey,
                      width: double.infinity,
                      height: 50,
                      radius: 8,
                      hasValidator: false,
                      inputType: TextInputType.text,
                      // onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ButtonWidget(
                    label: 'Send',
                    onPressed: _sendMessage,
                    color: primary,
                    textColor: white,
                    width: 80,
                    height: 50,
                    radius: 8,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
