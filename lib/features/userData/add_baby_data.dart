import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:intl/intl.dart';
import 'package:tracker/features/userData/twin_fields.dart';
import 'package:tracker/helpers//colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/services/app_router.dart';
import 'measurement_fields.dart';

class BabyProfile extends StatefulWidget {
  const BabyProfile({super.key});

  @override
  State<BabyProfile> createState() => BabyProfileState();
}

class BabyProfileState extends State<BabyProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _headCircumferenceController =
      TextEditingController();
  final TextEditingController _twinWeightController = TextEditingController();
  final TextEditingController _twinHeightController = TextEditingController();
  final TextEditingController _twinHeadCircumferenceController =
      TextEditingController();
  String gender = 'Boy'; // Default gender selection
  bool isTwin = false;

  final TextEditingController _twinNameController = TextEditingController();
  final TextEditingController _twinDobController = TextEditingController();
  String twinGender = 'Boy'; // Default gender selection for the twin

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Baby"),
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
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Baby's Name"),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => pickDateOfBirth(context, _dobController),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: "Date of Birth",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            DropdownButtonFormField<String>(
              value: gender,
              items: <String>['Boy', 'Girl'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child:
                      Text(value, style: TextStyle(color: AppColors.darkGrey)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    gender = newValue;
                  });
                }
              },
              decoration: const InputDecoration(labelText: "Baby Gender"),
            ),
            const SizedBox(height: 25),
            ...measurementBirthDetailsFields(
              weightController: _weightController,
              heightController: _heightController,
              headCircumferenceController: _headCircumferenceController,
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is this a twin?'),
                Switch(
                  value: isTwin,
                  onChanged: (bool value) {
                    setState(() {
                      isTwin = value;
                    });
                  },
                ),
              ],
            ),
            if (isTwin)
              ...buildTwinFields(
                context: context,
                twinNameController: _twinNameController,
                twinDobController: _twinDobController,
                twinWeightController: _twinWeightController,
                twinHeightController: _twinHeightController,
                twinHeadCircumferenceController:
                    _twinHeadCircumferenceController,
                pickDateOfBirth: pickDateOfBirth,
                twinGender: twinGender,
                onTwinGenderChanged: (newValue) {
                  setState(() {
                    twinGender = newValue!;
                  });
                },
              ),
            const SizedBox(height: 50),
            GestureDetector(
                onTap: () {
                  if (context.mounted) {
                    context.pushNamed(AppRoutes.home.name);
                  }
                },
                child: appButton(text: "Finish"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _headCircumferenceController.dispose();
    if (isTwin) {
      _twinNameController.dispose();
      _twinDobController.dispose();
    }
    super.dispose();
  }

  void pickDateOfBirth(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }
}
