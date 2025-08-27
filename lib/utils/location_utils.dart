import 'dart:math';

class LocationUtils {
  // Earth radius in kilometers
  static const double earthRadius = 6371.0;

  /// Calculate the distance between two points using the Haversine formula
  /// Returns distance in kilometers
  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    // Convert latitude and longitude from degrees to radians
    double lat1Rad = _toRadians(lat1);
    double lon1Rad = _toRadians(lon1);
    double lat2Rad = _toRadians(lat2);
    double lon2Rad = _toRadians(lon2);

    // Haversine formula
    double deltaLat = lat2Rad - lat1Rad;
    double deltaLon = lon2Rad - lon1Rad;

    double a = pow(sin(deltaLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(deltaLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  /// Convert degrees to radians
  static double _toRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  /// Check if a point is within a certain radius of another point
  /// radius in kilometers
  static bool isWithinRadius(
      double lat1, double lon1, double lat2, double lon2, double radius) {
    double distance = calculateDistance(lat1, lon1, lat2, lon2);
    return distance <= radius;
  }
}