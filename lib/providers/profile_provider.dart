import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier {
  String name = '';
  int age = 0;
  String role = '';
  int experience = 0;
  String address = '';

  void updateProfile({
    required String name,
    required int age,
    required String role,
    required int experience,
    required String address,
  }) {
    this.name = name;
    this.age = age;
    this.role = role;
    this.experience = experience;
    this.address = address;
    notifyListeners();
  }
}
