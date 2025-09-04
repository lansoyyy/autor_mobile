import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';
import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> chatHistory = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  String intro =
      'Hello! I\'m your AuTour guide for Aurora Province. I can help you with: '
      'Tourist spots like Sabang Beach, Ditumabo Falls, Baler Church, and hidden gems. '
      'Cultural insights about Aurora\'s history, festivals like Aurora Day, and indigenous heritage. '
      'Seasonal tips for surfing, typhoon alerts, and best months for eco-tourism. '
      'Local recommendations based on your location. '
      'Itinerary planning for surfing, hiking, heritage tours, and food trips. '
      'Connections to local services like bookings, emergency contacts, and QR check-ins.';

  @override
  void initState() {
    super.initState();
    // Greet user on open
    _sendIntroMessage();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendIntroMessage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.together.xyz/v1/chat/completions'),
        headers: {
          'Authorization':
              'Bearer tgp_v1_onFMvvKE406HiInIX9ZxmQtZB-xk1uTumlxUHlFUxJc',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "mistralai/Mixtral-8x7B-Instruct-v0.1",
          "messages": [
            {
              "role": "system",
              "content": "You are an AI tour guide for Aurora Province in the Philippines named AuTour. You must be fluent in Aurora's unique offerings:\n"
                  "1. Tourist Spots: Provide info on Sabang Beach, Ditumabo Falls, Baler Church, and lesser-known gems across all municipalities.\n"
                  "2. Cultural Insights: Share trivia about Aurora's history, local festivals (e.g., Aurora Day), and indigenous heritage.\n"
                  "3. Seasonal Tips: Give advice on surfing season, typhoon alerts, best months for eco-tourism.\n"
                  "4. Geo-Aware Responses: Offer location-based suggestions (e.g., if near Baler, suggest nearby eateries or surf schools).\n"
                  "5. Language and Tone: Use Filipino-English hybrid phrasing or local expressions like 'Tara!' or 'Astig!' with a friendly, conversational tone.\n"
                  "6. Smart Itinerary Builder: Help users build plans for surfing, hiking, heritage tours, food trips with LGU-approved guides and safety advisories.\n"
                  "7. Local Services Integration: Connect to booking systems, emergency contacts (MDRRMO, tourism office), and QR code check-ins.\n"
                  "8. Data-Driven Personalization: Recommend repeat visits or new spots based on interests.\n"
                  "9. Modular Design: Acknowledge that LGUs can update content easily.\n"
                  "IMPORTANT: Keep responses concise (maximum 50 words), use bullet points when helpful, and always stay focused on Aurora Province. Never answer questions unrelated to Aurora Province tourism."
            },
            {'role': 'user', 'content': intro},
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = data['choices'][0]['message']['content'];
        setState(() {
          chatHistory.add({'sender': 'bot', 'message': message});
        });
        _scrollToBottom();
      } else {
        setState(() {
          chatHistory.add({
            'sender': 'bot',
            'message':
                'Sorry, our tour guide is taking a quick break! Please try again in a moment.'
          });
        });
        _scrollToBottom();
      }
    } catch (e) {
      setState(() {
        chatHistory.add({
          'sender': 'bot',
          'message':
              'Sorry, our tour guide is taking a quick break! Please try again in a moment.'
        });
      });
      _scrollToBottom();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    final userMessage = messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      chatHistory.add({'sender': 'user', 'message': userMessage});
      _isLoading = true;
      messageController.clear();
    });
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse('https://api.together.xyz/v1/chat/completions'),
        headers: {
          'Authorization':
              'Bearer tgp_v1_onFMvvKE406HiInIX9ZxmQtZB-xk1uTumlxUHlFUxJc',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "mistralai/Mixtral-8x7B-Instruct-v0.1",
          "messages": [
            {
              "role": "system",
              "content": "You are an AI tour guide for Aurora Province in the Philippines named AuTour. You must be fluent in Aurora's unique offerings:\n"
                  "1. Tourist Spots: Provide info on Sabang Beach, Ditumabo Falls, Baler Church, and lesser-known gems across all municipalities.\n"
                  "2. Cultural Insights: Share trivia about Aurora's history, local festivals (e.g., Aurora Day), and indigenous heritage.\n"
                  "3. Seasonal Tips: Give advice on surfing season, typhoon alerts, best months for eco-tourism.\n"
                  "4. Geo-Aware Responses: Offer location-based suggestions (e.g., if near Baler, suggest nearby eateries or surf schools).\n"
                  "5. Language and Tone: Use Filipino-English hybrid phrasing or local expressions like 'Tara!' or 'Astig!' with a friendly, conversational tone.\n"
                  "6. Smart Itinerary Builder: Help users build plans for surfing, hiking, heritage tours, food trips with LGU-approved guides and safety advisories.\n"
                  "7. Local Services Integration: Connect to booking systems, emergency contacts (MDRRMO, tourism office), and QR code check-ins.\n"
                  "8. Data-Driven Personalization: Recommend repeat visits or new spots based on interests.\n"
                  "9. Modular Design: Acknowledge that LGUs can update content easily.\n"
                  "IMPORTANT: Keep responses concise (maximum 50 words), use bullet points when helpful, and always stay focused on Aurora Province. Never answer questions unrelated to Aurora Province tourism."
            },
            {'role': 'user', 'content': userMessage},
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = data['choices'][0]['message']['content'];
        setState(() {
          chatHistory.add({'sender': 'bot', 'message': message});
        });
        _scrollToBottom();
      } else {
        setState(() {
          chatHistory.add({
            'sender': 'bot',
            'message':
                'Sorry, our tour guide is taking a quick break! Please try again in a moment.'
          });
        });
        _scrollToBottom();
      }
    } catch (e) {
      setState(() {
        chatHistory.add({
          'sender': 'bot',
          'message':
              'Sorry, our tour guide is taking a quick break! Please try again in a moment.'
        });
      });
      _scrollToBottom();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
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
                controller: _scrollController,
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

            // Loading indicator
            if (_isLoading)
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
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
                      label: 'Type your message here...',
                      controller: messageController,
                      borderColor: primary,
                      hintColor: grey,
                      width: double.infinity,
                      height: 50,
                      radius: 8,
                      hasValidator: false,
                      inputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ButtonWidget(
                    label: 'Send',
                    onPressed: _isLoading ? () {} : _sendMessage,
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
