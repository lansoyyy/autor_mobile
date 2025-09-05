import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autour_mobile/utils/travel_models.dart';

class TravelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all travel destinations
  Future<List<TravelDestination>> getDestinations() async {
    try {
      final snapshot = await _firestore.collection('destinations').get();
      return snapshot.docs
          .map((doc) => TravelDestination.fromJson(doc.data()))
          .toList();
    } catch (e) {
      // Return empty list if there's an error
      return [];
    }
  }

  // Fetch destinations by category
  Future<List<TravelDestination>> getDestinationsByCategory(
      String category) async {
    try {
      final snapshot = await _firestore
          .collection('destinations')
          .where('categories', arrayContains: category)
          .get();
      return snapshot.docs
          .map((doc) => TravelDestination.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Fetch all travel activities
  Future<List<TravelActivity>> getActivities() async {
    try {
      final snapshot = await _firestore.collection('activities').get();
      return snapshot.docs
          .map((doc) => TravelActivity.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Fetch activities by category
  Future<List<TravelActivity>> getActivitiesByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection('activities')
          .where('categories', arrayContains: category)
          .get();
      return snapshot.docs
          .map((doc) => TravelActivity.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Fetch all travel tips
  Future<List<TravelTip>> getTips() async {
    try {
      final snapshot = await _firestore.collection('tips').get();
      return snapshot.docs
          .map((doc) => TravelTip.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Fetch tips by category
  Future<List<TravelTip>> getTipsByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection('tips')
          .where('categories', arrayContains: category)
          .get();
      return snapshot.docs
          .map((doc) => TravelTip.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Get all unique categories for destinations
  Future<List<String>> getDestinationCategories() async {
    try {
      final snapshot = await _firestore.collection('destinations').get();
      final categories = <String>{};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data['categories'] != null) {
          categories.addAll(List<String>.from(data['categories']));
        }
      }

      return categories.toList();
    } catch (e) {
      return [];
    }
  }

  // Get all unique categories for activities
  Future<List<String>> getActivityCategories() async {
    try {
      final snapshot = await _firestore.collection('activities').get();
      final categories = <String>{};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data['categories'] != null) {
          categories.addAll(List<String>.from(data['categories']));
        }
      }

      return categories.toList();
    } catch (e) {
      return [];
    }
  }

  // Get all unique categories for tips
  Future<List<String>> getTipCategories() async {
    try {
      final snapshot = await _firestore.collection('tips').get();
      final categories = <String>{};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data['categories'] != null) {
          categories.addAll(List<String>.from(data['categories']));
        }
      }

      return categories.toList();
    } catch (e) {
      return [];
    }
  }
}
