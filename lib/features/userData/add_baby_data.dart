import 'package:flutter/material.dart';
import 'package:tracker/helpers//colors_manager.dart';
import 'package:tracker/helpers/routes_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';

class BabyProfile extends StatefulWidget {
  const BabyProfile({Key? key}) : super(key: key);

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
            ...measurementBirthDetailsFields(),
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
            if (isTwin) ...buildTwinFields(),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.addAnotherChild),
              child: appButton(
                  text: "Add Another Child",
                  background: AppColors.lightPrimary,
                  textColor: AppColors.primary),
            ),
            const SizedBox(height: 50),
            GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.home),
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
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  List<Widget> buildTwinFields() {
    return [
      const SizedBox(height: 25),
      TextFormField(
        controller: _twinNameController,
        decoration: const InputDecoration(labelText: "Twin's Name"),
      ),
      const SizedBox(height: 25),
      GestureDetector(
        onTap: () => pickDateOfBirth(context, _twinDobController),
        child: AbsorbPointer(
          child: TextFormField(
            controller: _twinDobController,
            decoration: const InputDecoration(
              labelText: "Twin's Date of Birth",
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
      const SizedBox(height: 25),
      DropdownButtonFormField<String>(
        value: twinGender,
        items: <String>['Boy', 'Girl'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: AppColors.darkGrey)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              twinGender = newValue;
            });
          }
        },
        decoration: const InputDecoration(labelText: "Twin's Gender"),
      ),
      const SizedBox(height: 25),
      ...measurementBirthDetailsFields(),
    ];
  }

  List<Widget> measurementBirthDetailsFields() {
    return [
      TextFormField(
        controller: _weightController,
        decoration:
            const InputDecoration(labelText: "Child's Weight at Birth (kg)"),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      const SizedBox(height: 25),
      TextFormField(
        controller: _heightController,
        decoration:
            const InputDecoration(labelText: "Child's Height at Birth (cm)"),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      const SizedBox(height: 25),
      TextFormField(
        controller: _headCircumferenceController,
        decoration:
            const InputDecoration(labelText: "Child's Height at Birth (cm)"),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      const SizedBox(height: 25),
    ];
  }
}
