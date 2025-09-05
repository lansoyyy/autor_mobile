class TravelDestination {
  final String id;
  final String name;
  final String description;
  final String municipality;
  final List<String> categories; // e.g., beaches, hiking, etc.
  final String imageUrl;
  final double latitude;
  final double longitude;

  TravelDestination({
    required this.id,
    required this.name,
    required this.description,
    required this.municipality,
    required this.categories,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  factory TravelDestination.fromJson(Map<String, dynamic> json) {
    return TravelDestination(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      municipality: json['municipality'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      imageUrl: json['imageUrl'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'municipality': municipality,
      'categories': categories,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class TravelActivity {
  final String id;
  final String title;
  final String description;
  final String location;
  final List<String> categories; // e.g., surfing, food, etc.
  final String imageUrl;
  final int duration; // in hours
  final double cost; // in PHP

  TravelActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.categories,
    required this.imageUrl,
    required this.duration,
    required this.cost,
  });

  factory TravelActivity.fromJson(Map<String, dynamic> json) {
    return TravelActivity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      imageUrl: json['imageUrl'] ?? '',
      duration: json['duration'] ?? 0,
      cost: json['cost']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'categories': categories,
      'imageUrl': imageUrl,
      'duration': duration,
      'cost': cost,
    };
  }
}

class TravelTip {
  final String id;
  final String title;
  final String description;
  final List<String> categories; // e.g., permits, transportation, etc.

  TravelTip({
    required this.id,
    required this.title,
    required this.description,
    required this.categories,
  });

  factory TravelTip.fromJson(Map<String, dynamic> json) {
    return TravelTip(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categories': categories,
    };
  }
}
