import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/ai_guide_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final roleController = TextEditingController();
  final experienceController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF1E4CA1),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                _buildTextField("Full Name", nameController),
                _buildTextField("Age", ageController, isNumber: true),
                _buildTextField("Desired Job Role", roleController),
                _buildTextField(
                  "Experience (Years)",
                  experienceController,
                  isNumber: true,
                ),
                _buildTextField("Address", addressController, maxLines: 2),

                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E4CA1),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<ProfileProvider>(
                        context,
                        listen: false,
                      ).updateProfile(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        role: roleController.text,
                        experience: int.parse(experienceController.text),
                        address: addressController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Profile Saved Successfully"),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Save Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF15A25),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    final provider = Provider.of<ProfileProvider>(
                      context,
                      listen: false,
                    );

                    if (provider.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please save your profile first"),
                        ),
                      );
                      return;
                    }

                    Navigator.pushNamed(context, "/jobs");
                  },
                  child: const Text(
                    "Continue to Job Listings",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: const AIGuideButton(screen: "profile"),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
