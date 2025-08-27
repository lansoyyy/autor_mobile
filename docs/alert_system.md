# Location-Based Alert System Documentation

## Overview

The location-based alert system in the AuTour mobile application provides real-time safety alerts to users when they are near tourist destinations in Aurora Province and there are adverse weather conditions that could affect their activities.

## Features

1. **Real-time Location Monitoring**: Tracks user location every minute
2. **Proximity Detection**: Determines when users are near tourist destinations
3. **Alert Checking**: Checks for active alerts related to nearby destinations
4. **Vibration Feedback**: Provides haptic feedback based on alert severity
5. **Visual Alerts**: Displays emergency alerts with detailed information

## How It Works

### 1. Location Monitoring
- The system uses the `geolocator` package to track user location
- Location updates occur every minute in the background
- User location is stored in Firebase for potential future use

### 2. Proximity Detection
- Uses the Haversine formula to calculate distances between user and destinations
- Different alert radii based on destination type:
  - Beaches: 2km radius
  - Hiking trails/mountains: 1km radius
  - Other destinations: 500m radius

### 3. Alert Checking
- When a user is within the defined radius of a destination, the system checks for active alerts
- Alerts are associated with activities rather than specific destinations
- Multiple alerts can be triggered for a single location

### 4. Alert Display
- Alerts are displayed as modal dialogs on the home screen
- Each alert includes:
  - Alert type (Weather, Trail, Safety, Tide)
  - Severity level (High, Medium, Low)
  - Detailed message
  - Timestamp
- Vibration feedback is provided based on severity:
  - High: Long vibration (1000ms) with pauses, repeated 3 times
  - Medium: Medium vibration (500ms) with pauses, repeated 2 times
  - Low: Short vibration (250ms) once

## Data Models

### TouristDestination
Represents a tourist destination in Aurora Province:
- `name`: Name of the destination
- `municipality`: Municipality where the destination is located
- `latitude`/`longitude`: GPS coordinates
- `description`: Description of the destination
- `activities`: List of activities available at the destination
- `hours`: Operating hours
- `fees`: Entry fees information
- `tips`: Safety tips for visitors

### TouristActivity
Represents a tourist activity with associated alerts:
- `name`: Name of the activity
- `icon`: Icon representing the activity
- `color`: Color associated with the activity
- `locations`: List of locations where this activity is available
- `riskLevel`: General risk level (High, Medium, Low)
- `alerts`: General safety alerts for the activity
- `activeAlerts`: Currently active alerts

### ActiveAlert
Represents a currently active alert:
- `type`: Type of alert (Weather, Trail, Safety, Tide)
- `message`: Detailed alert message
- `severity`: Severity level (High, Medium, Low)
- `time`: When the alert was issued

## Integration Points

### Home Screen
- The alert system is integrated into the home screen's location update cycle
- Alerts are displayed as modal dialogs
- Vibration feedback is triggered when alerts are shown

### Firebase
- User locations are stored in Firebase Firestore
- Future enhancements could include storing active alerts in Firebase

## Dependencies

- `geolocator`: For location services
- `vibration`: For haptic feedback
- `firebase_core` and `cloud_firestore`: For Firebase integration

## Testing

Unit tests are available in `test/alert_system_test.dart` and cover:
- Location calculations
- Data model creation
- Alert checking logic

## Future Enhancements

1. **Push Notifications**: Implement background alert notifications
2. **Weather Integration**: Connect with weather APIs for real-time conditions
3. **Multi-language Support**: Translate alerts to local dialects
4. **Dynamic Alert Data**: Store and retrieve alerts from Firebase instead of hardcoded data