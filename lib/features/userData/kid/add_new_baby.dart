import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/features/children/kids_repository.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'measurement_fields.dart';

class AddAnotherChild extends HookConsumerWidget {
  AddAnotherChild({super.key, required this.parent});
  final User parent;
  // declare a GlobalKey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final dobController = useTextEditingController();
    final weightController = useTextEditingController();
    final heightController = useTextEditingController();
    final headCircumferenceController = useTextEditingController();
    final twinNameController = useTextEditingController();
    final twinDobController = useTextEditingController();
    final twinWeightController = useTextEditingController();
    final twinHeightController = useTextEditingController();
    final twinHeadCircumferenceController = useTextEditingController();
    final gender = useState('Boy');
    final twinGender = useState('Boy');
    final isTwin = useState(false);

    Future<void> saveForm() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      Kid addKid = Kid(
          name: nameController.text.trim(),
          dateOfBirth: dobController.text.trim(),
          gender: gender.value,
          isHasTwin: isTwin.value,
          childWeight: double.parse(weightController.text),
          childHeight: double.parse(heightController.text),
          childHeadCircumference:
              double.parse(headCircumferenceController.text),
          assignedParentId: parent.id);
      try {
        final repo = ref.read(kidsRepositoryProvider);
        await repo.createNewKid(addKid);
      } catch (ex) {
        if (kDebugMode) {
          print("Could not save new Kid: $addKid");
        }
      }
      if (isTwin.value == true) {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        Kid twinKid = Kid(
          name: twinNameController.text.trim(),
          dateOfBirth: twinDobController.text.trim(),
          gender: twinGender.value,
          isHasTwin: true,
          childWeight: double.parse(twinWeightController.text),
          childHeight: double.parse(twinHeightController.text),
          childHeadCircumference:
              double.parse(twinHeadCircumferenceController.text),
          assignedParentId: parent.id,
        );
        try {
          final repo = ref.read(kidsRepositoryProvider);
          await repo.createNewKid(twinKid);
        } catch (ex) {
          if (kDebugMode) {
            print("Could not save new Twin: $twinKid");
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Add Another Child"),
        titleTextStyle: getRegularStyle(color: AppColors.black, fontSize: 20),
        backgroundColor: AppColors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Child's Name",
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => pickDateOfBirth(context, dobController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      labelText: "Date of Birth",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              RadioListTile<String>(
                title: Text('Boy', style: TextStyle(color: AppColors.darkGrey)),
                value: 'Boy',
                groupValue: gender.value,
                onChanged: (String? value) {
                  if (value != null) {
                    gender.value = value;
                  }
                },
              ),
              RadioListTile<String>(
                title:
                    Text('Girl', style: TextStyle(color: AppColors.darkGrey)),
                value: 'Girl',
                groupValue: gender.value,
                onChanged: (String? value) {
                  if (value != null) {
                    gender.value = value;
                  }
                },
              ),
              const SizedBox(height: 25),
              ...measurementBirthDetailsFields(
                weightController: weightController,
                heightController: heightController,
                headCircumferenceController: headCircumferenceController,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Is this a twin?'),
                  Switch(
                    value: isTwin.value,
                    onChanged: (bool value) {
                      isTwin.value = value;
                    },
                  ),
                ],
              ),
              if (isTwin.value) ...[
                TextFormField(
                  controller: twinNameController,
                  decoration: const InputDecoration(
                    labelText: "Child's Name",
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => pickDateOfBirth(context, twinDobController),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: twinDobController,
                      decoration: const InputDecoration(
                        labelText: "Date of Birth",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                RadioListTile<String>(
                  title:
                      Text('Boy', style: TextStyle(color: AppColors.darkGrey)),
                  value: 'Boy',
                  groupValue: twinGender.value,
                  onChanged: (String? value) {
                    if (value != null) {
                      twinGender.value = value;
                    }
                  },
                ),
                RadioListTile<String>(
                  title:
                      Text('Girl', style: TextStyle(color: AppColors.darkGrey)),
                  value: 'Girl',
                  groupValue: twinGender.value,
                  onChanged: (String? value) {
                    if (value != null) {
                      twinGender.value = value;
                    }
                  },
                ),
                const SizedBox(height: 25),
                ...measurementBirthDetailsFields(
                  weightController: twinWeightController,
                  heightController: twinHeightController,
                  headCircumferenceController: twinHeadCircumferenceController,
                ),
              ],
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (context.mounted) {
                    saveForm();
                    context.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: appButton(text: "Save Child"),
              ),
            ],
          ),
        ),
      ),
    );
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
      controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }
}
