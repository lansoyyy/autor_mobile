import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataPopulator {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sample destinations data
  static final List<Map<String, dynamic>> _destinations = [
    {
      'id': 'dest_001',
      'name': 'Dingalan Viewpoint',
      'description':
          'Hidden gem with stunning coastal views. Less crowded and perfect for eco-hiking.',
      'municipality': 'Dingalan',
      'categories': ['Hiking', 'Eco-Tourism', 'Viewpoints'],
      'imageUrl': '',
      'latitude': 16.1234,
      'longitude': 121.5678,
    },
    {
      'id': 'dest_002',
      'name': 'Baler Organic Farms',
      'description':
          'Support sustainable agriculture and enjoy farm-to-table experiences.',
      'municipality': 'Baler',
      'categories': ['Food', 'Eco-Tourism', 'Local Businesses'],
      'imageUrl': '',
      'latitude': 15.7556,
      'longitude': 121.4678,
    },
    {
      'id': 'dest_003',
      'name': 'Sabang Beach',
      'description':
          'Beginner-friendly surf breaks, surf schools, and sunrise walks along the bay.',
      'municipality': 'Baler',
      'categories': ['Beaches', 'Surfing', 'Food'],
      'imageUrl': '',
      'latitude': 15.7567,
      'longitude': 121.4689,
    },
    {
      'id': 'dest_004',
      'name': 'Ditumabo (Mother) Falls',
      'description':
          '45–60 min river trek to a powerful falls; best visited in the morning with a guide.',
      'municipality': 'San Luis',
      'categories': ['Waterfalls', 'Hiking', 'Nature'],
      'imageUrl': '',
      'latitude': 15.7678,
      'longitude': 121.4789,
    },
    {
      'id': 'dest_005',
      'name': 'Digisit & Aniao Islets',
      'description':
          'Rock formations and tide pools great for photos and light snorkeling during low tide.',
      'municipality': 'Baler',
      'categories': ['Beaches', 'Snorkeling', 'Photography'],
      'imageUrl': '',
      'latitude': 15.7789,
      'longitude': 121.4890,
    },
    {
      'id': 'dest_006',
      'name': 'Dinadiawan Beach',
      'description':
          'Long white-sand stretch with clear waters; ideal for relaxed swimming and sunrise.',
      'municipality': 'Dipaculao',
      'categories': ['Beaches', 'Swimming', 'Sunrise'],
      'imageUrl': '',
      'latitude': 16.0123,
      'longitude': 121.5234,
    },
    {
      'id': 'dest_007',
      'name': 'Casapsapan Beach',
      'description':
          'Quiet cove with seagrass beds and calm waters; perfect for off-the-beaten-path trips.',
      'municipality': 'Casiguran',
      'categories': ['Beaches', 'Eco-Tourism', 'Peaceful'],
      'imageUrl': '',
      'latitude': 16.2345,
      'longitude': 121.6789,
    },
    {
      'id': 'dest_008',
      'name': 'Baler Church',
      'description':
          'Historic church showcasing Spanish colonial architecture and local religious heritage.',
      'municipality': 'Baler',
      'categories': ['History', 'Culture', 'Architecture'],
      'imageUrl': '',
      'latitude': 15.7543,
      'longitude': 121.4654,
    },
    {
      'id': 'dest_009',
      'name': 'Lamao Caves',
      'description':
          'Impressive limestone caves with stalactites and stalagmites; guided tours available.',
      'municipality': 'Baler',
      'categories': ['Adventure', 'Caving', 'Nature'],
      'imageUrl': '',
      'latitude': 15.7654,
      'longitude': 121.4765,
    },
    {
      'id': 'dest_010',
      'name': 'Balete Tree',
      'description':
          'Ancient 600-year-old tree considered sacred by locals; located in Maria Aurora.',
      'municipality': 'Maria Aurora',
      'categories': ['Nature', 'Culture', 'History'],
      'imageUrl': '',
      'latitude': 15.8765,
      'longitude': 121.4876,
    },
  ];

  // Sample activities data
  static final List<Map<String, dynamic>> _activities = [
    {
      'id': 'act_001',
      'title': 'Surfing Lessons at Sabang',
      'description':
          'Book a certified instructor; best season is Oct–Mar, but summer also has small waves.',
      'location': 'Baler',
      'categories': ['Surfing', 'Lessons', 'Water Sports'],
      'imageUrl': '',
      'duration': 2,
      'cost': 800.0,
    },
    {
      'id': 'act_002',
      'title': 'Mother Falls Trek',
      'description':
          'Wear proper footwear; expect river crossings and slippery rocks. Start early.',
      'location': 'San Luis',
      'categories': ['Hiking', 'Waterfalls', 'Adventure'],
      'imageUrl': '',
      'duration': 4,
      'cost': 0.0,
    },
    {
      'id': 'act_003',
      'title': 'Dingalan Lighthouse Hike',
      'description':
          'Combine a short boat ride to White Beach with a ridge hike for panoramic views.',
      'location': 'Dingalan',
      'categories': ['Hiking', 'Viewpoints', 'Adventure'],
      'imageUrl': '',
      'duration': 3,
      'cost': 500.0,
    },
    {
      'id': 'act_004',
      'title': 'Sea Caving at Lamao Caves',
      'description':
          'Time your visit with low tide and go with accredited guides. Bring helmet/headlamp.',
      'location': 'Baler',
      'categories': ['Caving', 'Adventure', 'Nature'],
      'imageUrl': '',
      'duration': 4,
      'cost': 750.0,
    },
    {
      'id': 'act_005',
      'title': 'Tide Pooling at Digisit',
      'description':
          'Best during low tide; wear aqua shoes and avoid slippery rocks during strong swells.',
      'location': 'Baler',
      'categories': ['Snorkeling', 'Photography', 'Nature'],
      'imageUrl': '',
      'duration': 2,
      'cost': 0.0,
    },
    {
      'id': 'act_006',
      'title': 'Snorkeling at Casapsapan',
      'description':
          'Use reef-safe sunscreen; do not step on corals. Calm mornings are ideal for visibility.',
      'location': 'Casiguran',
      'categories': ['Snorkeling', 'Water Sports', 'Nature'],
      'imageUrl': '',
      'duration': 2,
      'cost': 300.0,
    },
    {
      'id': 'act_007',
      'title': 'Farm Tour and Lunch',
      'description':
          'Experience sustainable farming practices and enjoy fresh organic produce.',
      'location': 'Baler',
      'categories': ['Food', 'Eco-Tourism', 'Local Businesses'],
      'imageUrl': '',
      'duration': 3,
      'cost': 600.0,
    },
    {
      'id': 'act_008',
      'title': 'Heritage Walking Tour',
      'description':
          'Explore historical sites and learn about Aurora\'s rich cultural heritage.',
      'location': 'Baler',
      'categories': ['History', 'Culture', 'Walking'],
      'imageUrl': '',
      'duration': 2,
      'cost': 0.0,
    },
    {
      'id': 'act_009',
      'title': 'Sunrise Photography Session',
      'description':
          'Capture stunning sunrise views at Dinadiawan Beach with professional guidance.',
      'location': 'Dipaculao',
      'categories': ['Photography', 'Sunrise', 'Beaches'],
      'imageUrl': '',
      'duration': 2,
      'cost': 1200.0,
    },
    {
      'id': 'act_010',
      'title': 'Local Market Tour',
      'description':
          'Discover local products, handicrafts, and fresh produce at Aurora\'s markets.',
      'location': 'Baler',
      'categories': ['Shopping', 'Culture', 'Local Businesses'],
      'imageUrl': '',
      'duration': 2,
      'cost': 0.0,
    },
  ];

  // Sample tips data
  static final List<Map<String, dynamic>> _tips = [
    {
      'id': 'tip_001',
      'title': 'Best Time to Visit',
      'description':
          'Dry months (Nov–May) are ideal. Surf season peaks around Oct–Mar with bigger swells.',
      'categories': ['Planning', 'Weather', 'Seasons'],
    },
    {
      'id': 'tip_002',
      'title': 'Getting Around',
      'description':
          'Tricycles for town hops; hire vans or motorbikes for inter-town trips (Baler–Dingalan–Casiguran).',
      'categories': ['Transportation', 'Getting Around', 'Mobility'],
    },
    {
      'id': 'tip_003',
      'title': 'Permits & Guides',
      'description':
          'Register at barangay/LGU for certain trails/caves. Use accredited guides and follow safety advisories.',
      'categories': ['Safety', 'Permits', 'Guides'],
    },
    {
      'id': 'tip_004',
      'title': 'Packing Essentials',
      'description':
          'Bring reef-safe sunscreen, waterproof bags, hiking shoes, and quick-dry clothes.',
      'categories': ['Packing', 'Essentials', 'Preparation'],
    },
    {
      'id': 'tip_005',
      'title': 'Local Etiquette',
      'description':
          'Respect local customs, ask permission before taking photos of people, and support local businesses.',
      'categories': ['Culture', 'Etiquette', 'Respect'],
    },
    {
      'id': 'tip_006',
      'title': 'Emergency Contacts',
      'description':
          'Save local emergency numbers: MDRRMO (0917-123-4567), Tourism Office (0917-234-5678).',
      'categories': ['Safety', 'Emergency', 'Contacts'],
    },
    {
      'id': 'tip_007',
      'title': 'Eco-Friendly Practices',
      'description':
          'Use reusable water bottles, avoid single-use plastics, and stay on marked trails.',
      'categories': ['Eco-Tourism', 'Sustainability', 'Environment'],
    },
    {
      'id': 'tip_008',
      'title': 'Internet & Connectivity',
      'description':
          'Mobile signal can be spotty in remote areas. Download offline maps before departure.',
      'categories': ['Technology', 'Connectivity', 'Preparation'],
    },
    {
      'id': 'tip_009',
      'title': 'Currency & Payments',
      'description':
          'Carry cash as many establishments don\'t accept cards. ATMs are available in major towns.',
      'categories': ['Money', 'Payments', 'Finance'],
    },
    {
      'id': 'tip_010',
      'title': 'Health Precautions',
      'description':
          'Bring insect repellent, first aid kit, and any personal medications. Drink bottled or purified water.',
      'categories': ['Health', 'Safety', 'Preparation'],
    },
  ];

  /// Populate all travel data to Firebase
  static Future<void> populateAllData() async {
    print('Starting to populate Firebase with travel data...');

    try {
      // Populate destinations
      await _populateCollection('destinations', _destinations);
      print('Destinations populated successfully');

      // Populate activities
      await _populateCollection('activities', _activities);
      print('Activities populated successfully');

      // Populate tips
      await _populateCollection('tips', _tips);
      print('Tips populated successfully');

      print('All travel data populated successfully!');
    } catch (e) {
      print('Error populating data: $e');
      rethrow;
    }
  }

  /// Helper method to populate a collection
  static Future<void> _populateCollection(
      String collectionName, List<Map<String, dynamic>> data) async {
    final CollectionReference collection =
        _firestore.collection(collectionName);

    for (final item in data) {
      try {
        await collection.doc(item['id']).set(item);
        print('Added ${item['id']} to $collectionName');
      } catch (e) {
        print('Error adding ${item['id']} to $collectionName: $e');
        rethrow;
      }
    }
  }

  /// Clear all travel data from Firebase (for testing purposes)
  static Future<void> clearAllData() async {
    print('Clearing all travel data from Firebase...');

    try {
      await _clearCollection('destinations');
      await _clearCollection('activities');
      await _clearCollection('tips');
      print('All travel data cleared successfully!');
    } catch (e) {
      print('Error clearing data: $e');
      rethrow;
    }
  }

  /// Helper method to clear a collection
  static Future<void> _clearCollection(String collectionName) async {
    final CollectionReference collection =
        _firestore.collection(collectionName);

    final QuerySnapshot snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
      print('Deleted document ${doc.id} from $collectionName');
    }
  }
}
