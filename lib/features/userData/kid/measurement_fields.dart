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
          const InputDecoration(labelText: "Greutatea copilului la naștere(kg)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
       validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Greutatea nu poate fi goală';
        }
        return null;
      },
    ),
    const SizedBox(height: 25),
    TextFormField(
      controller: heightController,
      decoration:
          const InputDecoration(labelText: "Înălțimea copilului la naștere (cm)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Înălțimea nu poate fi goală';
        }
        return null;
      },
    ),
    const SizedBox(height: 25),
    TextFormField(
      controller: headCircumferenceController,
      decoration:
          const InputDecoration(labelText: "Circumferința capului la naștere (cm)"),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Circumferința capului nu poate fi goală';
        }
        return null;
      },
    ),
    const SizedBox(height: 25),
  ];
}
