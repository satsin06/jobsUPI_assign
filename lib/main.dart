import 'package:flutter/material.dart';
import 'package:jobsupi_assignment/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'providers/profile_provider.dart';
import 'providers/jobs_provider.dart';

import 'screens/profile_screen.dart';
import 'screens/job_listings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => JobsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JobsUPI Assignment',
        theme: ThemeData(
          primaryColor: const Color(0xFF1E4CA1),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E4CA1)),
          useMaterial3: true,
        ),

        home: const SplashScreen(),

        routes: {
          "/profile": (context) => const ProfileScreen(),
          "/jobs": (context) => const JobListingsScreen(),
        },
      ),
    );
  }
}
