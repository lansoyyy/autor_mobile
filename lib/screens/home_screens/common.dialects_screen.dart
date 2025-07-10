import 'package:flutter/material.dart';
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

  final List<Map<String, String>> dialectEntries = [
    {
      'phrase': 'Kumusta',
      'meaning': 'Hello',
      'pronunciation': 'Koo-moos-ta',
      'town': 'Baler',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Agyamanak',
      'meaning': 'Thank you',
      'pronunciation': 'Ag-ya-ma-nak',
      'town': 'Maria Aurora',
      'language': 'Ilocano',
    },
    {
      'phrase': 'Magandang Umaga',
      'meaning': 'Good Morning',
      'pronunciation': 'Ma-gan-dang Oo-ma-ga',
      'town': 'Dingalan',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Naimbag nga Bigat',
      'meaning': 'Good Morning',
      'pronunciation': 'Nai-im-bag nga Bi-gat',
      'town': 'San Luis',
      'language': 'Ilocano',
    },
    {
      'phrase': 'Salamat',
      'meaning': 'Thank you',
      'pronunciation': 'Sa-la-mat',
      'town': 'Baler',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Mabuhay',
      'meaning': 'Welcome',
      'pronunciation': 'Ma-boo-hai',
      'town': 'Dingalan',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Magandang Hapon',
      'meaning': 'Good Afternoon',
      'pronunciation': 'Ma-gan-dang Ha-pon',
      'town': 'Maria Aurora',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Naimbag nga Malem',
      'meaning': 'Good Afternoon',
      'pronunciation': 'Nai-im-bag nga Ma-lem',
      'town': 'San Luis',
      'language': 'Ilocano',
    },
    {
      'phrase': 'Paalam',
      'meaning': 'Goodbye',
      'pronunciation': 'Pa-a-lam',
      'town': 'Baler',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Agsardeng',
      'meaning': 'Goodbye',
      'pronunciation': 'Ag-sar-deng',
      'town': 'Maria Aurora',
      'language': 'Ilocano',
    },
    {
      'phrase': 'Kumusta ka?',
      'meaning': 'How are you?',
      'pronunciation': 'Koo-moos-ta ka',
      'town': 'Dingalan',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Kumusta ka ngayon?',
      'meaning': 'How are you today?',
      'pronunciation': 'Koo-moos-ta ka nga-yon',
      'town': 'San Luis',
      'language': 'Tagalog',
    },
    {
      'phrase': 'Ania ti balita?',
      'meaning': 'How are you?',
      'pronunciation': 'A-ni-a ti ba-li-ta',
      'town': 'Maria Aurora',
      'language': 'Ilocano',
    },
  ];

  List<Map<String, String>> get filteredDialects {
    return dialectEntries.where((entry) {
      final matchesTown =
          selectedTown == 'All' || entry['town'] == selectedTown;
      final matchesSearch = entry['phrase']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          entry['meaning']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          entry['pronunciation']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
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

  Widget _buildDialectCard(Map<String, String> entry) {
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
          TextWidget(
            text: entry['phrase']!,
            fontSize: 16,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: 'Meaning: ${entry['meaning']}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Pronunciation: ${entry['pronunciation']}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Town: ${entry['town']}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Language: ${entry['language']}',
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
                // onChanged: (value) {
                //   setState(() {
                //     searchQuery = value;
                //   });
                // },
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
  final List<Map<String, String>> dialectEntries;

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

  List<Map<String, String>> get filteredDialects {
    return widget.dialectEntries.where((entry) {
      final matchesTown =
          selectedTown == 'All' || entry['town'] == selectedTown;
      final matchesSearch = entry['phrase']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          entry['meaning']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          entry['pronunciation']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
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

  Widget _buildDialectCard(Map<String, String> entry) {
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
          TextWidget(
            text: entry['phrase']!,
            fontSize: 16,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: 'Meaning: ${entry['meaning']}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Pronunciation: ${entry['pronunciation']}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Town: ${entry['town']}',
            fontSize: 14,
            color: grey,
            fontFamily: 'Regular',
          ),
          TextWidget(
            text: 'Language: ${entry['language']}',
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
                // onChanged: (value) {
                //   setState(() {
                //     searchQuery = value;
                //   });
                // },
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
