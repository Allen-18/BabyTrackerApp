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
  String _gender = 'Male'; // Default gender selection
  bool _isTwin = false;

  final TextEditingController _twinNameController = TextEditingController();
  final TextEditingController _twinDobController = TextEditingController();
  String _twinGender = 'Male'; // Default gender selection for the twin

  void _pickDateOfBirth(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  List<Widget> _buildTwinFields() {
    return [
      const SizedBox(height: 25),
      TextFormField(
        controller: _twinNameController,
        decoration: const InputDecoration(labelText: "Twin's Name"),
      ),
      const SizedBox(height: 25),
      GestureDetector(
        onTap: () => _pickDateOfBirth(context, _twinDobController),
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
        value: _twinGender,
        items: <String>['Male', 'Female'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: AppColors.darkGrey)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _twinGender = newValue;
            });
          }
        },
        decoration: const InputDecoration(labelText: "Twin's Gender"),
      ),
      const SizedBox(height: 25),
    ];
  }

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
              onTap: () => _pickDateOfBirth(context, _dobController),
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
              items: <String>['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: TextStyle(color: AppColors.darkGrey)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _gender = newValue;
                  });
                }
              },
              decoration: const InputDecoration(labelText: "Baby Gender"),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is this a twin?'),
                Switch(
                  value: _isTwin,
                  onChanged: (bool value) {
                    setState(() {
                      _isTwin = value;
                    });
                  },
                ),
              ],
            ),
            if (_isTwin) ..._buildTwinFields(),
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
}
