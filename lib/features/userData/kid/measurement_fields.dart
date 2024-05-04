import 'package:flutter/material.dart';

List<Widget> measurementBirthDetailsFields({
  required TextEditingController weightController,
  required TextEditingController heightController,
  required TextEditingController headCircumferenceController,
}) {
  return [
    TextFormField(
      controller: weightController,
      decoration:
          const InputDecoration(labelText: "Child's Weight at Birth (kg)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    ),
    const SizedBox(height: 25),
    TextFormField(
      controller: heightController,
      decoration:
          const InputDecoration(labelText: "Child's Height at Birth (cm)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    ),
    const SizedBox(height: 25),
    TextFormField(
      controller: headCircumferenceController,
      decoration:
          const InputDecoration(labelText: "Child's Height at Birth (cm)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    ),
    const SizedBox(height: 25),
  ];
}
