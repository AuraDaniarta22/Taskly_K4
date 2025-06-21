import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Keep this for date formatting localization

// Import your pages from the 'pages' directory
import 'package:taskly/pages/landing_page.dart'; // Correct path based on project name 'taskly'

void main() async { // main needs to be async because of initializeDateFormatting
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize date formatting for Indonesian locale
  // This needs to be awaited before runApp to ensure it's ready.
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LandingPage(), // Start with the Landing Page
    );
  }
}