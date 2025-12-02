import 'package:flutter/foundation.dart';

class JobsProvider with ChangeNotifier {
  List<Map<String, dynamic>> jobs = [
    {
      'title': 'Flutter Developer',
      'experience': '1-3 yrs',
      'salary': '₹8L - ₹12L',
      'location': 'Remote'
    },
    {
      'title': 'Python Developer',
      'experience': '2-4 yrs',
      'salary': '₹10L - ₹15L',
      'location': 'Bangalore'
    },
    {
      'title': 'Full Stack Developer',
      'experience': '3-5 yrs',
      'salary': '₹12L - ₹18L',
      'location': 'Hybrid'
    },
  ];
}
