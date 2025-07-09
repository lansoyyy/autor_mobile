import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';

class LocalBusinessesScreen extends StatefulWidget {
  const LocalBusinessesScreen({super.key});

  @override
  State<LocalBusinessesScreen> createState() => _LocalBusinessesScreenState();
}

class _LocalBusinessesScreenState extends State<LocalBusinessesScreen> {
  String selectedCategory = 'All';
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  final List<String> categories = [
    'All',
    'Accommodations',
    'Restaurants',
    'Transportation',
    'Services',
    'Tours',
  ];

  final List<Map<String, String>> businesses = [
    {
      'name': 'Baler Beach Resort',
      'category': 'Accommodations',
      'location': 'Baler, Aurora',
      'description': 'Cozy beachfront resort with accessible rooms.',
      'phone': '09751000896',
      'email': 'baler.eco@gmail.com.ph',
      'hours': '8:00AM - 5:00PM'
    },
    {
      'name': 'Aurora Eats',
      'category': 'Restaurants',
      'location': 'Maria Aurora, Aurora',
      'description': 'Local cuisine with vegan options.',
      'phone': '09751000896',
      'email': 'baler.eco@gmail.com.ph',
      'hours': '8:00AM - 5:00PM'
    },
    {
      'name': 'Baler Bus Terminal',
      'category': 'Transportation',
      'location': 'Baler, Aurora',
      'description': 'Convenient bus services to Aurora.',
      'phone': '09751000896',
      'email': 'baler.eco@gmail.com.ph',
      'hours': '8:00AM - 5:00PM'
    },
    {
      'name': 'Eco Tours Aurora',
      'category': 'Tours',
      'location': 'Dingalan, Aurora',
      'description': 'Guided eco-friendly tours to waterfalls.',
      'phone': '09751000896',
      'email': 'baler.eco@gmail.com.ph',
      'hours': '8:00AM - 5:00PM'
    },
    {
      'name': 'Quick Fix Vulcanizing',
      'category': 'Services',
      'location': 'San Luis, Aurora',
      'description': 'Reliable tire repair services.',
      'phone': '09751000896',
      'email': 'baler.eco@gmail.com.ph',
      'hours': '8:00AM - 5:00PM'
    },
  ];

  List<Map<String, String>> get filteredBusinesses {
    return businesses.where((business) {
      final matchesCategory =
          selectedCategory == 'All' || business['category'] == selectedCategory;
      final matchesSearch =
          business['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              business['description']!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              business['location']!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
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
          text: 'Local Businesses',
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextFieldWidget(
              suffix: Icon(
                Icons.search,
              ),
              label: 'Search Businesses',
              hint: 'Search by name, location, or description',
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
          ),
          // Category Filters
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
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
                          text: category,
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
          ),
          // Business List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: filteredBusinesses.length,
              itemBuilder: (context, index) {
                final business = filteredBusinesses[index];
                return _buildBusinessCard(
                  context,
                  name: business['name']!,
                  category: business['category']!,
                  location: business['location']!,
                  description: business['description']!,
                  imageUrl:
                      'https://live.staticflickr.com/506/19664562909_4ddd66e89f_b.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BusinessDetailScreen(business: business),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(
    BuildContext context, {
    required String name,
    required String category,
    required String location,
    required String description,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
          children: [
            // Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
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
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: name,
                    fontSize: 16,
                    color: black,
                    fontFamily: 'Bold',
                    align: TextAlign.left,
                  ),
                  const SizedBox(height: 4),
                  TextWidget(
                    text: category,
                    fontSize: 12,
                    color: primary,
                    fontFamily: 'Medium',
                    align: TextAlign.left,
                  ),
                  const SizedBox(height: 4),
                  TextWidget(
                    text: location,
                    fontSize: 12,
                    color: grey,
                    fontFamily: 'Regular',
                    align: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  TextWidget(
                    text: description,
                    fontSize: 12,
                    color: grey,
                    fontFamily: 'Regular',
                    align: TextAlign.left,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  ButtonWidget(
                    label: 'View Details',
                    onPressed: onTap,
                    color: primary,
                    textColor: white,
                    width: 120,
                    height: 36,
                    radius: 8,
                    fontSize: 12,
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

class BusinessDetailScreen extends StatelessWidget {
  final Map<String, String> business;

  const BusinessDetailScreen({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: business['name'] ?? 'Business Detail',
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Business Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  business['image'] ??
                      'https://live.staticflickr.com/506/19664562909_4ddd66e89f_b.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
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
                ),
              ),

              const SizedBox(height: 20),

              // Business Name
              TextWidget(
                text: business['name'] ?? 'Unknown',
                fontSize: 24,
                color: black,
                fontFamily: 'Bold',
              ),

              const SizedBox(height: 6),

              // Category
              TextWidget(
                text: business['category'] ?? '',
                fontSize: 16,
                color: primary,
                fontFamily: 'Medium',
              ),

              const SizedBox(height: 20),

              // Contact Details Section
              _buildDetailRow(
                  Icons.location_on, 'Location', business['location']),
              _buildDetailRow(Icons.phone, 'Phone', business['phone']),
              _buildDetailRow(Icons.email, 'Email', business['email']),

              _buildDetailRow(
                  Icons.access_time, 'Business Hours', business['hours']),

              const SizedBox(height: 24),

              // Description
              TextWidget(
                text: 'About the Business',
                fontSize: 18,
                color: black,
                fontFamily: 'Bold',
              ),
              const SizedBox(height: 8),
              TextWidget(
                text: business['description'] ?? 'No description available.',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
                align: TextAlign.justify,
              ),

              const SizedBox(height: 30),

              // Contact Button
              ButtonWidget(
                label: 'Contact Business',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: TextWidget(
                        text: 'Contacting ${business['name']}...',
                        fontSize: 14,
                        color: white,
                      ),
                      backgroundColor: primary,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                color: primary,
                textColor: white,
                width: double.infinity,
                height: 50,
                radius: 10,
                fontSize: 16,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create icon-label-value rows
  Widget _buildDetailRow(IconData icon, String label, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: primary, size: 20),
          const SizedBox(width: 8),
          TextWidget(
            text: '$label: $value',
            fontSize: 14,
            color: black,
            fontFamily: 'Regular',
          ),
        ],
      ),
    );
  }
}
