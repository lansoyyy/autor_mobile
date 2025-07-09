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
  final List<Map<String, String>> chatHistory = [
    {
      'sender': 'bot',
      'message': 'Welcome to AuTour Chatbot! How can I assist you today?'
    },
    {
      'sender': 'user',
      'message': 'Can you recommend accessible attractions in Aurora?'
    },
    {
      'sender': 'bot',
      'message':
          'Certainly! Baler Beach has wheelchair-accessible paths. Would you like more details?'
    },
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      setState(() {
        chatHistory.add({'sender': 'user', 'message': messageController.text});
        chatHistory.add({
          'sender': 'bot',
          'message':
              'Thanks for your query! This is a placeholder response for: "${messageController.text}".'
        });
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
