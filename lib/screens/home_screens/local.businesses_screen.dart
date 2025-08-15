import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

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
    'Markets',
    'Transportation',
    'Services',
    'Tours',
  ];

  // Map admin Firestore fields (camelCase) to this screen's expected snake_case keys
  Map<String, dynamic> _mapBusiness(Map<String, dynamic> data) {
    final List<String>? roomTypes = (data['roomTypes'] is List)
        ? List<String>.from(data['roomTypes'] as List)
        : null;

    return {
      'name': (data['name'] ?? '').toString(),
      'category': (data['category'] ?? '').toString(),
      'location': (data['location'] ?? '').toString(),
      'description': (data['description'] ?? '').toString(),
      'phone': (data['phone'] ?? '').toString(),
      'email': (data['email'] ?? '').toString(),
      'hours': (data['hours'] ?? '').toString(),
      'rooms_available': data['roomsAvailable'],
      'total_rooms': data['totalRooms'],
      'room_types': roomTypes,
      'price_range': data['priceRange'],
      'prices': data['prices'],
      'fares': data['fares'],
      // Use the provided static image URL for now
      'image': 'https://live.staticflickr.com/506/19664562909_4ddd66e89f_b.jpg',
    };
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
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
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
          // Business List (from Firestore)
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('businesses')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: TextWidget(
                      text: 'Failed to load businesses',
                      fontSize: 14,
                      color: grey,
                      fontFamily: 'Regular',
                    ),
                  );
                }

                final docs = snapshot.data?.docs ?? [];
                final List<Map<String, dynamic>> allBusinesses = docs
                    .map((d) => _mapBusiness(d.data() as Map<String, dynamic>))
                    .toList();

                final filtered = allBusinesses.where((business) {
                  final matchesCategory = selectedCategory == 'All' ||
                      business['category'] == selectedCategory;
                  final q = searchQuery.toLowerCase();
                  final name =
                      (business['name'] ?? '').toString().toLowerCase();
                  final desc =
                      (business['description'] ?? '').toString().toLowerCase();
                  final loc =
                      (business['location'] ?? '').toString().toLowerCase();
                  final matchesSearch =
                      name.contains(q) || desc.contains(q) || loc.contains(q);
                  return matchesCategory && matchesSearch;
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: TextWidget(
                      text: 'No businesses found',
                      fontSize: 14,
                      color: grey,
                      fontFamily: 'Regular',
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final business = filtered[index];
                    return _buildBusinessCard(
                      context,
                      business: business,
                      name: business['name'] ?? '',
                      category: business['category'] ?? '',
                      location: business['location'] ?? '',
                      description: business['description'] ?? '',
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
    required Map<String, dynamic> business,
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
                  Row(
                    children: [
                      Expanded(
                        child: TextWidget(
                          text: name,
                          fontSize: 16,
                          color: black,
                          fontFamily: 'Bold',
                          align: TextAlign.left,
                        ),
                      ),
                      // Room Availability Badge for Accommodations
                      if (category == 'Accommodations')
                        _buildRoomAvailabilityBadge(business),
                    ],
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
                  // Room Information for Accommodations
                  if (category == 'Accommodations')
                    _buildRoomInformation(business),
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

  Widget _buildRoomAvailabilityBadge(Map<String, dynamic> business) {
    if (business['rooms_available'] == null) {
      return const SizedBox();
    }

    final roomsAvailable = business['rooms_available'] as int;
    final totalRooms = business['total_rooms'] as int;

    Color badgeColor;
    String availabilityText;

    if (roomsAvailable == 0) {
      badgeColor = Colors.red;
      availabilityText = 'FULLY BOOKED';
    } else if (roomsAvailable <= 3) {
      badgeColor = Colors.orange;
      availabilityText = 'LIMITED';
    } else {
      badgeColor = Colors.green;
      availabilityText = 'AVAILABLE';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: TextWidget(
        text: availabilityText,
        fontSize: 10,
        color: badgeColor,
        fontFamily: 'Bold',
      ),
    );
  }

  Widget _buildRoomInformation(Map<String, dynamic> business) {
    if (business['rooms_available'] == null) {
      return const SizedBox();
    }

    final roomsAvailable = business['rooms_available'] as int;
    final totalRooms = business['total_rooms'] as int;
    final roomTypes = business['room_types'] as List<String>?;
    final priceRange = business['price_range'] as String?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.bed,
              color: primary,
              size: 16,
            ),
            const SizedBox(width: 4),
            TextWidget(
              text: '$roomsAvailable/$totalRooms rooms available',
              fontSize: 12,
              color: primary,
              fontFamily: 'Medium',
            ),
          ],
        ),
        if (roomTypes != null && roomTypes.isNotEmpty) ...[
          const SizedBox(height: 4),
          TextWidget(
            text: 'Types: ${roomTypes.join(', ')}',
            fontSize: 11,
            color: grey,
            fontFamily: 'Regular',
          ),
        ],
        if (priceRange != null) ...[
          const SizedBox(height: 4),
          TextWidget(
            text: 'Price: $priceRange',
            fontSize: 11,
            color: grey,
            fontFamily: 'Regular',
          ),
        ],
      ],
    );
  }
}

class BusinessDetailScreen extends StatelessWidget {
  final Map<String, dynamic> business;

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

              // Room Availability Section (for Accommodations)
              if (business['category'] == 'Accommodations' &&
                  business['rooms_available'] != null)
                _buildRoomAvailabilitySection(business),

              const SizedBox(height: 24),

              // Prices Section (for Markets)
              if (business['category'] == 'Markets' &&
                  business['prices'] != null)
                _buildPricesSection(),

              // Fares Section (for Transportation)
              if (business['category'] == 'Transportation' &&
                  business['fares'] != null)
                _buildFaresSection(),

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
                onPressed: () { _launchPhoneCall(context); },
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

  // Launch phone dialer for the business phone number
  Future<void> _launchPhoneCall(BuildContext context) async {
    final String phone = (business['phone'] ?? '').toString().trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text: 'No phone number available',
            fontSize: 14,
            color: white,
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final Uri uri = Uri(scheme: 'tel', path: phone);
    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Could not open the dialer',
              fontSize: 14,
              color: white,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text: 'Failed to launch dialer',
            fontSize: 14,
            color: white,
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
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

  // Build prices section for markets
  Widget _buildPricesSection() {
    final prices = business['prices'] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Product Prices',
          fontSize: 18,
          color: black,
          fontFamily: 'Bold',
        ),
        const SizedBox(height: 12),
        ...prices.entries.map(
            (category) => _buildPriceCategory(category.key, category.value)),
      ],
    );
  }

  // Build price category
  Widget _buildPriceCategory(String categoryName, Map<String, dynamic> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: categoryName,
            fontSize: 16,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 8),
          ...items.entries.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: item.key,
                      fontSize: 14,
                      color: black,
                      fontFamily: 'Regular',
                    ),
                    TextWidget(
                      text: item.value,
                      fontSize: 14,
                      color: primary,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // Build fares section for transportation
  Widget _buildFaresSection() {
    final fares = business['fares'] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Transportation Fares',
          fontSize: 18,
          color: black,
          fontFamily: 'Bold',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primary.withOpacity(0.3)),
          ),
          child: Column(
            children: fares.entries
                .map((fare) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: fare.key,
                              fontSize: 14,
                              color: black,
                              fontFamily: 'Regular',
                            ),
                          ),
                          TextWidget(
                            text: fare.value,
                            fontSize: 14,
                            color: primary,
                            fontFamily: 'Bold',
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  // Build room availability section for accommodations
  Widget _buildRoomAvailabilitySection(Map<String, dynamic> business) {
    final roomsAvailable = business['rooms_available'] as int;
    final totalRooms = business['total_rooms'] as int;
    final roomTypes = business['room_types'] as List<String>?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Room Availability',
          fontSize: 18,
          color: black,
          fontFamily: 'Bold',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primary.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: '$roomsAvailable/$totalRooms rooms available',
                fontSize: 16,
                color: primary,
                fontFamily: 'Medium',
              ),
              if (roomTypes != null && roomTypes.isNotEmpty) ...[
                const SizedBox(height: 8),
                TextWidget(
                  text: 'Types: ${roomTypes.join(', ')}',
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
