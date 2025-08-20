import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/screens/home_screens/qr_scanner_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class QrCodeTouristPassScreen extends StatelessWidget {
  const QrCodeTouristPassScreen({super.key});

  Future<void> _storeScan(BuildContext context, String qr) async {
    // Progress dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.of(context).pop(); // close progress
        await showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Not Logged In'),
            content: Text('Please log in to record your scan.'),
          ),
        );
        return;
      }

      // Fetch full user profile from Firestore (created during signup)
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final userData = userDoc.data() ?? <String, dynamic>{};

      // Try to parse QR payload as JSON to extract destination details
      Map<String, dynamic>? parsed;
      try {
        dynamic decoded = jsonDecode(qr);
        // Handle cases where the JSON object is string-wrapped
        if (decoded is String) {
          decoded = jsonDecode(decoded);
        }
        if (decoded is Map<String, dynamic>) {
          parsed = Map<String, dynamic>.from(decoded);
        }
      } catch (_) {
        // keep parsed null; we'll still store raw string
      }

      final scanRecord = <String, dynamic>{
        'userId': user.uid,
        'userEmail': user.email,
        'userProfile': userData, // snapshot of full profile at scan time
        'qrRaw': qr,
        'qrParsed': parsed,
        'destinationId': parsed?['id'] ?? parsed?['destinationId'],
        'destinationName': parsed?['name'] ??
            parsed?['destinationName'] ??
            parsed?['spotName'],
        'municipality': parsed?['municipality'],
        'scannedAt': FieldValue.serverTimestamp(),
        'platform': 'flutter',
      };

      await FirebaseFirestore.instance.collection('scans').add(scanRecord);

      Navigator.of(context).pop(); // close progress

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Scan recorded'),
          content: Text(
            parsed?['name'] != null
                ? 'Successfully recorded your visit to ${parsed!['name']}.'
                : 'Your QR scan has been saved.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
        ),
      );
    } catch (e) {
      Navigator.of(context).pop(); // close progress
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Failed to save scan'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'QR Code Tourist Pass',
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_2, size: 80, color: primary),
                const SizedBox(height: 12),
                TextWidget(
                  text: 'Scan QR Code',
                  fontSize: 18,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 6),
                TextWidget(
                  text: 'Click below to start scanning',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.of(context).push<String>(
                      MaterialPageRoute(
                        builder: (_) => const QrScannerScreen(),
                      ),
                    );
                    if (result != null) {
                      // ignore: use_build_context_synchronously
                      await _storeScan(context, result);
                    }
                  },
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.qr_code, size: 100, color: grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            icon: Icons.verified_user,
            title: 'Seamless Access to Tourist Spots',
            description:
                'Present your QR code at designated attractions to verify your identity and enjoy quick, contactless access.',
          ),
          _buildSection(
            icon: Icons.shield_outlined,
            title: 'Enhanced Safety & Emergency Response',
            description:
                'Authorities can scan your QR code to access emergency contacts and quickly locate you in case of incidents.',
          ),
          _buildSection(
            icon: Icons.payment_outlined,
            title: 'Digital Payments & Services',
            description:
                'Use your QR code for cashless payments, bookings, and exclusive discounts from partnered businesses.',
          ),
          _buildSection(
            icon: Icons.lock_outline,
            title: 'Privacy & Data Security',
            description:
                'Your data is encrypted and protected. You control what information is shared and with whom.',
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fontSize: 14,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 6),
                TextWidget(
                  text: description,
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
