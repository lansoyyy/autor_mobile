import 'package:firebase_core/firebase_core.dart';
import 'package:autour_mobile/firebase_options.dart';
import 'package:autour_mobile/utils/populate_firebase_data.dart';

/// This script is meant to be run once to populate Firebase with initial data
/// for the travel planner feature.
Future<void> main() async {
  print('Initializing Firebase...');

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('Firebase initialized successfully');

    // Populate data
    await FirebaseDataPopulator.populateAllData();

    print('Data population completed!');
  } catch (e) {
    print('Error during data population: $e');
  }
}
