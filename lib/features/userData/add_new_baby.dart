import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';

class AddAnotherChild extends StatefulWidget {
  const AddAnotherChild({Key? key}) : super(key: key);

  @override
  AddAnotherChildState createState() => AddAnotherChildState();
}

class AddAnotherChildState extends State<AddAnotherChild> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String _gender = 'Male';

  void _pickDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Add Another Child"),
        titleTextStyle: getRegularStyle(color: AppColors.black, fontSize: 20),
        backgroundColor: AppColors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Child's Name",
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => _pickDateOfBirth(context),
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
              value: _gender,
              items: <String>['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: AppColors.darkGrey),),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _gender = newValue;
                  });
                }
              },
              decoration: const InputDecoration(labelText: "Child's Gender"),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Logic to save child's information
                Navigator.pop(
                    context); // Return to previous screen after adding
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: appButton(text: "Save Child"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
