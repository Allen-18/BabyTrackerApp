import 'package:flutter/material.dart';
import 'package:tracker/helpers//colors_manager.dart';
import 'package:tracker/helpers/routes_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';

class MotherProfile extends StatefulWidget {
  const MotherProfile({Key? key}) : super(key: key);

  @override
  MotherProfileState createState() => MotherProfileState();
}

class MotherProfileState extends State<MotherProfile> {
  final TextEditingController _nameController = TextEditingController();
  String relationship = 'Mother'; // Default to 'Mother'

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Mother"),
        titleTextStyle: getRegularStyle(color: AppColors.black, fontSize: 20),
        backgroundColor: AppColors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            const SizedBox(height: 25),
            const Center(
              child: Text(
                "Please take a moment to personalize the app",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                fillColor: AppColors.lightGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: getRegularStyle(color: AppColors.grey, fontSize: 15),
            ),
            const SizedBox(height: 25),
            Text('Relationship:',
                style: getRegularStyle(color: AppColors.black)),
            ListTile(
              title: const Text('Mother'),
              leading: Radio<String>(
                value: 'Mother',
                groupValue: relationship,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      relationship = value;
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Father'),
              leading: Radio<String>(
                value: 'Father',
                groupValue: relationship,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      relationship = value;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: size.height * 0.3),
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.aboutBaby),
                child: appButton(text: "Continue")),
          ],
        ),
      ),
    );
  }
}
