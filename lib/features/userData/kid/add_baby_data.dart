import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/features/children/kids_repository.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/authentication/repository/users.dart';
import 'measurement_fields.dart';

class BabyProfile extends HookConsumerWidget {
  BabyProfile({super.key, required this.parent});
  final User parent;

  // Declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
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
    final imageFile = useState<XFile?>(null);
    final twinImageFile = useState<XFile?>(null);

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
        childHeadCircumference: double.parse(headCircumferenceController.text),
        assignedParentId: parent.id,
        profileImgUriChild: imageFile.value?.path, // Include image file path
      );
      try {
        final repo = ref.read(kidsRepositoryProvider);
        await repo.createNewKid(addKid);
      } catch (ex) {
        if (kDebugMode) {
          print("Could not save new Kid: $addKid");
        }
      }
      if (isTwin.value == true) {
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
          profileImgUriChild: twinImageFile.value?.path, // Include twin's image file path
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

    Future<void> pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile.value = pickedFile;
      }
    }

    Future<void> pickTwinImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        twinImageFile.value = pickedFile;
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Procesul de personalizare ..."),
        titleTextStyle: getRegularStyle(color: AppColors.black, fontSize: 20),
        backgroundColor: AppColors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 25),
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.lightPrimary,
                    backgroundImage: imageFile.value != null
                        ? FileImage(File(imageFile.value!.path))
                        : null,
                    child: imageFile.value == null
                        ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Numele copilului"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Numele copilului nu poate fi gol';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => pickDateOfBirth(context, dobController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      labelText: "Introduceți data nașterii",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data nașterii nu poate fi goală';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              RadioListTile<String>(
                title: Text('Băiat', style: TextStyle(color: AppColors.darkGrey)),
                value: 'Boy',
                groupValue: gender.value,
                onChanged: (String? value) {
                  if (value != null) {
                    gender.value = value;
                  }
                },
              ),
              RadioListTile<String>(
                title: Text('Fată', style: TextStyle(color: AppColors.darkGrey)),
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
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gemeni?'),
                  Switch(
                    value: isTwin.value,
                    onChanged: (bool value) {
                      isTwin.value = value;
                    },
                  ),
                ],
              ),
              if (isTwin.value) ...[
                Center(
                  child: GestureDetector(
                    onTap: pickTwinImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.lightPrimary,
                      backgroundImage: twinImageFile.value != null
                          ? FileImage(File(twinImageFile.value!.path))
                          : null,
                      child: twinImageFile.value == null
                          ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: twinNameController,
                  decoration: const InputDecoration(
                    labelText: "Numele copilului",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Numele copilului nu poate fi gol';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => pickDateOfBirth(context, twinDobController),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: twinDobController,
                      decoration: const InputDecoration(
                        labelText: "Introduceți data nașterii",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data nașterii nu poate fi goală';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                RadioListTile<String>(
                  title: Text('Băiat', style: TextStyle(color: AppColors.darkGrey)),
                  value: 'Boy',
                  groupValue: twinGender.value,
                  onChanged: (String? value) {
                    if (value != null) {
                      twinGender.value = value;
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text('Fată', style: TextStyle(color: AppColors.darkGrey)),
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
              GestureDetector(
                onTap: () {
                  if (context.mounted) {
                    context.pushNamed(AppRoutes.addNewBaby.name);
                  }
                },
                child: appButton(
                    text: "Adaugă o soră sau un frate",
                    background: AppColors.lightPrimary,
                    textColor: AppColors.primary),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  User u = parent.copyWith(hasChild: true);
                  try {
                    final repo = ref.read(usersRepositoryProvider);
                    await repo.updateUser(u);
                  } catch (ex) {
                    if (kDebugMode) {
                      print("Could not save new User: $u");
                    }
                  }
                  final currentUser =
                  await ref.read(getCurrentUserStreamProvider.future);
                  if (context.mounted) {
                    saveForm();
                    context.pushNamed(AppRoutes.homeScreen.name,
                        extra: currentUser);
                  }
                },
                child: appButton(text: "Finalizare"),
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
      controller.text = DateFormat('dd.MM.yyyy').format(pickedDate);
    }
  }
}
