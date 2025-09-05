# AuTour Mobile

A Flutter-based mobile application for tourism in Aurora Province, Philippines.

## Features

- Location-based emergency alerts for tourist destinations
- Tourism guide and smart tourism features
- Emergency hotlines and disaster preparedness
- Health surveillance and community interaction
- Local businesses directory
- QR code scanner and pass management
- Chatbot integration
- Travel planner and itinerary management

## Location-Based Alert System

The app includes a location-based alert system that shows emergency alerts to users when they are near tourist destinations in Aurora Province and there are active weather or safety alerts for those locations.

### How It Works

1. The app tracks user location every minute
2. When a user is near a tourist destination, it checks current weather conditions
3. If weather conditions are dangerous for nearby activities, the app displays an alert dialog with vibration feedback
4. Vibration intensity varies based on alert severity (High > Medium > Low)

## Dynamic Travel Planner

The travel planner feature dynamically generates personalized itineraries based on user preferences. Instead of hardcoded data, the app fetches travel destinations, activities, and tips from Firebase Firestore.

### How It Works

1. Users select their interests, budget, and sustainability preferences
2. The app fetches relevant travel data from Firebase
3. Based on user selections, the app generates a personalized 3-day itinerary
4. Users can view their custom itinerary with destinations and activities that match their preferences

### Data Structure

The travel planner uses three main data collections in Firebase:

1. **Destinations**: Tourist spots with categories, descriptions, and locations
2. **Activities**: Things to do with duration and cost information
3. **Tips**: Practical travel advice organized by category

### Populating Firebase Data

To populate Firebase with initial travel data:

1. **Option 1 - Through Admin Screen**: 
   - Open the app and navigate to "Admin Data Populate" in the main menu
   - Tap "Populate Data" to add sample destinations, activities, and tips

2. **Option 2 - Command Line Script**:
   - Run `dart populate_firebase_data.dart` from the project root

The sample data includes:
- 10 sample destinations across Aurora Province municipalities
- 10 sample activities with duration and cost information
- 10 sample travel tips organized by category

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.