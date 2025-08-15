import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';

class CommonDialectsScreen extends StatefulWidget {
  const CommonDialectsScreen({super.key});

  @override
  State<CommonDialectsScreen> createState() => _CommonDialectsScreenState();
}

class _CommonDialectsScreenState extends State<CommonDialectsScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String selectedTown = 'All';

  final List<String> towns = [
    'All',
    'Baler',
    'Dingalan',
    'Maria Aurora',
    'San Luis',
  ];

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late final CollectionReference dialectsRef =
      _db.collection('common_dialects');
  StreamSubscription? _sub;
  bool _loading = true;

  List<Map<String, dynamic>> dialectEntries = [];

  List<Map<String, dynamic>> get filteredDialects {
    return dialectEntries.where((entry) {
      final town = (entry['town'] ?? '').toString();
      final q = searchQuery.toLowerCase();
      final matchesTown = selectedTown == 'All' || town == selectedTown;
      final matchesSearch = (entry['phrase'] ?? '')
              .toString()
              .toLowerCase()
              .contains(q) ||
          (entry['meaning'] ?? '').toString().toLowerCase().contains(q) ||
          (entry['pronunciation'] ?? '').toString().toLowerCase().contains(q) ||
          (entry['usage'] ?? '').toString().toLowerCase().contains(q) ||
          (entry['example'] ?? '').toString().toLowerCase().contains(q);
      return matchesTown && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _sub = dialectsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((s) {
      setState(() {
        dialectEntries = s.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return {
            'phrase': (data['phrase'] ?? '').toString(),
            'meaning': (data['meaning'] ?? '').toString(),
            'pronunciation': (data['pronunciation'] ?? '').toString(),
            'town': (data['town'] ?? '').toString(),
            'language': (data['language'] ?? '').toString(),
            'usage': (data['usage'] ?? '').toString(),
            'example': (data['example'] ?? '').toString(),
            'verified': (data['verified'] ?? false) == true,
          };
        }).toList();
        _loading = false;
      });
    }, onError: (_) {
      setState(() => _loading = false);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: TextWidget(
        text: title,
        fontSize: 18,
        color: primary,
        fontFamily: 'Bold',
        align: TextAlign.left,
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDialectCard(Map<String, dynamic> entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: grey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextWidget(
                  text: (entry['phrase'] ?? '').toString(),
                  fontSize: 16,
                  color: black,
                  fontFamily: 'Bold',
                ),
              ),
              if (entry['verified'] == true)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Verified',
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: 'Meaning: ${(entry['meaning'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Pronunciation: ${(entry['pronunciation'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Town: ${(entry['town'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Language: ${(entry['language'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          if ((entry['usage'] ?? '').toString().isNotEmpty)
            TextWidget(
              text: 'Usage: ${(entry['usage'] ?? '').toString()}',
              fontSize: 14,
              color: grey,
              fontFamily: 'Regular',
            ),
          if ((entry['example'] ?? '').toString().isNotEmpty)
            TextWidget(
              text: 'Example: ${(entry['example'] ?? '').toString()}',
              fontSize: 14,
              color: grey,
              fontFamily: 'Regular',
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: 'Common Dialects',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              TextWidget(
                text: 'Learn Aurora’s Dialects',
                fontSize: 22,
                color: primary,
                fontFamily: 'Bold',
                align: TextAlign.left,
              ),
              const SizedBox(height: 6),
              TextWidget(
                text: 'Explore common greetings in Aurora Province’s dialects',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
                align: TextAlign.left,
              ),
              const SizedBox(height: 12),
              // Search Bar
              TextFieldWidget(
                label: 'Search Dialects',
                hint: 'Search by phrase, meaning, or pronunciation',
                controller: searchController,
                borderColor: primary,
                hintColor: grey,
                width: double.infinity,
                height: 50,
                radius: 8,
                hasValidator: false,
                inputType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                prefix: const Icon(Icons.search, color: grey),
              ),
              const SizedBox(height: 12),
              // Town Filters
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: towns.length,
                  itemBuilder: (context, index) {
                    final town = towns[index];
                    final isSelected = selectedTown == town;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTown = town;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? primary : grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: isSelected ? primary : grey),
                          ),
                          child: TextWidget(
                            text: town,
                            fontSize: 14,
                            color: isSelected ? white : black,
                            fontFamily: isSelected ? 'Bold' : 'Regular',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Verified Dialect Entries
              _buildSectionHeader('Common Greetings'),
              _buildSection([
                if (_loading)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ))
                else if (filteredDialects.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextWidget(
                      text: 'No entries found',
                      fontSize: 14,
                      color: grey,
                      fontFamily: 'Regular',
                    ),
                  )
                else
                  ...filteredDialects
                      .map((entry) => _buildDialectCard(entry))
                      .toList(),
                const SizedBox(height: 6),
                ButtonWidget(
                  label: 'View More Entries',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullDialectDatabaseScreen(
                            dialectEntries: dialectEntries),
                      ),
                    );
                  },
                  color: secondary,
                  textColor: black,
                  width: double.infinity,
                  height: 50,
                  radius: 8,
                  fontSize: 14,
                ),
              ]),
              // Sample Conversations
              _buildSectionHeader('Sample Conversations'),
              _buildSection([
                TextWidget(
                  text: 'Example 1: Greeting in Baler',
                  fontSize: 14,
                  color: black,
                  fontFamily: 'Medium',
                ),
                TextWidget(
                  text:
                      'You: Kumusta! (Hello!)\nLocal: Kumusta rin! Anong plano mo sa Baler? (Hello! What’s your plan in Baler?)',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                  maxLines: 4,
                ),
                const SizedBox(height: 8),
                TextWidget(
                  text: 'Example 2: Thanking in Maria Aurora',
                  fontSize: 14,
                  color: black,
                  fontFamily: 'Medium',
                ),
                TextWidget(
                  text:
                      'You: Agyamanak! (Thank you!)\nLocal: Awanan, nalaka! (You’re welcome, it’s easy!)',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                  maxLines: 4,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class FullDialectDatabaseScreen extends StatefulWidget {
  final List<Map<String, dynamic>> dialectEntries;

  const FullDialectDatabaseScreen({super.key, required this.dialectEntries});

  @override
  State<FullDialectDatabaseScreen> createState() =>
      _FullDialectDatabaseScreenState();
}

class _FullDialectDatabaseScreenState extends State<FullDialectDatabaseScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String selectedTown = 'All';

  final List<String> towns = [
    'All',
    'Baler',
    'Dingalan',
    'Maria Aurora',
    'San Luis',
  ];

  List<Map<String, dynamic>> get filteredDialects {
    return widget.dialectEntries.where((entry) {
      final town = (entry['town'] ?? '').toString();
      final q = searchQuery.toLowerCase();
      final matchesTown = selectedTown == 'All' || town == selectedTown;
      final matchesSearch = (entry['phrase'] ?? '')
              .toString()
              .toLowerCase()
              .contains(q) ||
          (entry['meaning'] ?? '').toString().toLowerCase().contains(q) ||
          (entry['pronunciation'] ?? '').toString().toLowerCase().contains(q) ||
          (entry['usage'] ?? '').toString().toLowerCase().contains(q) ||
          (entry['example'] ?? '').toString().toLowerCase().contains(q);
      return matchesTown && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: TextWidget(
        text: title,
        fontSize: 18,
        color: primary,
        fontFamily: 'Bold',
        align: TextAlign.left,
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDialectCard(Map<String, dynamic> entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: grey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextWidget(
                  text: (entry['phrase'] ?? '').toString(),
                  fontSize: 16,
                  color: black,
                  fontFamily: 'Bold',
                ),
              ),
              if (entry['verified'] == true)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Verified',
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: 'Meaning: ${(entry['meaning'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Pronunciation: ${(entry['pronunciation'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Town: ${(entry['town'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Language: ${(entry['language'] ?? '').toString()}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          if ((entry['usage'] ?? '').toString().isNotEmpty)
            TextWidget(
              text: 'Usage: ${(entry['usage'] ?? '').toString()}',
              fontSize: 14,
              color: grey,
              fontFamily: 'Regular',
            ),
          if ((entry['example'] ?? '').toString().isNotEmpty)
            TextWidget(
              text: 'Example: ${(entry['example'] ?? '').toString()}',
              fontSize: 14,
              color: grey,
              fontFamily: 'Regular',
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: 'Dialect Database',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              TextWidget(
                text: 'Full Dialect Database',
                fontSize: 22,
                color: primary,
                fontFamily: 'Bold',
                align: TextAlign.left,
              ),
              const SizedBox(height: 6),
              TextWidget(
                text: 'Explore all greetings in Aurora Province’s dialects',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
                align: TextAlign.left,
              ),
              const SizedBox(height: 12),
              // Search Bar
              TextFieldWidget(
                label: 'Search Dialects',
                hint: 'Search by phrase, meaning, or pronunciation',
                controller: searchController,
                borderColor: primary,
                hintColor: grey,
                width: double.infinity,
                height: 50,
                radius: 8,
                hasValidator: false,
                inputType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                prefix: const Icon(Icons.search, color: grey),
              ),
              const SizedBox(height: 12),
              // Town Filters
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: towns.length,
                  itemBuilder: (context, index) {
                    final town = towns[index];
                    final isSelected = selectedTown == town;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTown = town;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? primary : grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: isSelected ? primary : grey),
                          ),
                          child: TextWidget(
                            text: town,
                            fontSize: 14,
                            color: isSelected ? white : black,
                            fontFamily: isSelected ? 'Bold' : 'Regular',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Verified Dialect Entries
              _buildSectionHeader('All Greetings'),
              _buildSection([
                ...filteredDialects
                    .map((entry) => _buildDialectCard(entry))
                    .toList(),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
