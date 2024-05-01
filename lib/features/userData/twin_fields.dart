import 'package:flutter/material.dart';

List<Widget> buildTwinFields({
  required BuildContext context,
  required TextEditingController twinNameController,
  required TextEditingController twinDobController,
  required TextEditingController twinWeightController,
  required TextEditingController twinHeightController,
  required TextEditingController twinHeadCircumferenceController,
  required Function(BuildContext, TextEditingController) pickDateOfBirth,
  required String twinGender,
  required ValueChanged<String?> onTwinGenderChanged,
}) {
  return [
    const SizedBox(height: 25),
    TextFormField(
      controller: twinNameController,
      decoration: const InputDecoration(labelText: "Twin's Name"),
    ),
    const SizedBox(height: 25),
    GestureDetector(
      onTap: () => pickDateOfBirth(context, twinDobController),
      child: AbsorbPointer(
        child: TextFormField(
          controller: twinDobController,
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
          child: Text(value, style: const TextStyle(color: Colors.black54)),
        );
      }).toList(),
      onChanged: onTwinGenderChanged,
      decoration: const InputDecoration(labelText: "Twin's Gender"),
    ),
    const SizedBox(height: 25),
    TextFormField(
      controller: twinWeightController,
      decoration:
          const InputDecoration(labelText: "Twin's Weight at Birth (kg)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    ),
    const SizedBox(height: 25),
    TextFormField(
      controller: twinHeightController,
      decoration:
          const InputDecoration(labelText: "Twin's Height at Birth (cm)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    ),
    const SizedBox(height: 25),
    TextFormField(
      controller: twinHeadCircumferenceController,
      decoration: const InputDecoration(
          labelText: "Twin's Head Circumference at Birth (cm)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    ),
    const SizedBox(height: 25),
  ];
}
