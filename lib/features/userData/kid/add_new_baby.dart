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
import 'package:tracker/features/children/kids_repository.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/authentication/domain/user.dart';
import '../../../authentication/repository/users.dart';
import '../../../services/app_router.dart';
import '../../drawer/storage.dart';
import 'measurement_fields.dart';

class AddAnotherChild extends HookConsumerWidget {
  AddAnotherChild({super.key, required this.parent});
  final User parent;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

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
    final gender = useState('Băiat');
    final twinGender = useState('Băiat');
    final isTwin = useState(false);
    final imageFile = useState<XFile?>(null);
    final twinImageFile = useState<XFile?>(null);
    final isPremature = useState(false);
    final isTwinPremature = useState(false);

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
        title: const Text("Adaugă un alt copil"),
        titleTextStyle: getRegularStyle(color: AppColors.black, fontSize: 20),
        backgroundColor: AppColors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                        ? const Icon(Icons.camera_alt,
                            size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Numele copilului",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Numele copilului nu poate fi gol";
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
                      labelText: "Data nașterii",
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
                title:
                    Text('Băiat', style: TextStyle(color: AppColors.darkGrey)),
                value: 'Băiat',
                groupValue: gender.value,
                onChanged: (String? value) {
                  if (value != null) {
                    gender.value = value;
                  }
                },
              ),
              RadioListTile<String>(
                title:
                    Text('Fată', style: TextStyle(color: AppColors.darkGrey)),
                value: 'Fată',
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
              CheckboxListTile(
                title: const Text('Copil Prematur'),
                value: isPremature.value,
                onChanged: (bool? value) {
                  if (value != null) {
                    isPremature.value = value;
                  }
                },
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gemenii?'),
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
                          ? const Icon(Icons.camera_alt,
                              size: 50, color: Colors.grey)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: twinNameController,
                  decoration: const InputDecoration(
                    labelText: "Numele geamănului",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Numele geamănului nu poate fi gol";
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
                        labelText: "Data nașterii",
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
                  title: Text('Băiat',
                      style: TextStyle(color: AppColors.darkGrey)),
                  value: 'Băiat',
                  groupValue: twinGender.value,
                  onChanged: (String? value) {
                    if (value != null) {
                      twinGender.value = value;
                    }
                  },
                ),
                RadioListTile<String>(
                  title:
                      Text('Fată', style: TextStyle(color: AppColors.darkGrey)),
                  value: 'Fată',
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
                const SizedBox(height: 25),
                CheckboxListTile(
                  title: const Text('Geamăn Prematur'),
                  value: isTwinPremature.value,
                  onChanged: (bool? value) {
                    if (value != null) {
                      isTwinPremature.value = value;
                    }
                  },
                ),
              ],
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  final currentUser =
                      await ref.read(getCurrentUserStreamProvider.future);
                  final st = Storage();
                  String? gsFilePath;
                  String? gsFilePathTwin;

                  if (imageFile.value != null) {
                    gsFilePath = st.getGsKidPicPathBasedOnDate(
                        imageFile.value!.path, currentUser!.id.toString());
                    await st.uploadFile(gsFilePath, imageFile.value!.path);
                  }

                  if (twinImageFile.value != null) {
                    gsFilePathTwin = st.getGsKidPicPathBasedOnDate(
                        twinImageFile.value!.path, currentUser!.id.toString());
                    await st.uploadFile(
                        gsFilePathTwin, twinImageFile.value!.path);
                  }

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  Kid addKid = Kid(
                    name: nameController.text.trim(),
                    dateOfBirth: dobController.text.trim(),
                    gender: gender.value,
                    isHasTwin: isTwin.value,
                    isPremature: isPremature.value,
                    childWeight: double.parse(
                        weightController.text.replaceAll(',', '.')),
                    childHeight: double.parse(
                        heightController.text.replaceAll(',', '.')),
                    childHeadCircumference: double.parse(
                        headCircumferenceController.text.replaceAll(',', '.')),
                    assignedParentId: parent.id,
                    profileImgUriChild: gsFilePath,
                  );

                  try {
                    final repo = ref.read(kidsRepositoryProvider);
                    await repo.createNewKid(addKid);
                  } catch (ex) {
                    if (kDebugMode) {
                      print("Nu s-a putut salva copilul: $addKid");
                    }
                  }

                  if (isTwin.value) {
                    Kid twinKid = Kid(
                      name: twinNameController.text.trim(),
                      dateOfBirth: twinDobController.text.trim(),
                      gender: twinGender.value,
                      isHasTwin: true,
                      isPremature: isTwinPremature.value,
                      childWeight: double.parse(
                          twinWeightController.text.replaceAll(',', '.')),
                      childHeight: double.parse(
                          twinHeightController.text.replaceAll(',', '.')),
                      childHeadCircumference: double.parse(
                          twinHeadCircumferenceController.text
                              .replaceAll(',', '.')),
                      assignedParentId: parent.id,
                      profileImgUriChild: gsFilePathTwin,
                    );

                    try {
                      final repo = ref.read(kidsRepositoryProvider);
                      await repo.createNewKid(twinKid);
                    } catch (ex) {
                      if (kDebugMode) {
                        print("Nu s-a putut salva geamănul: $twinKid");
                      }
                    }
                  }
                  if (context.mounted) {
                    context.pushNamed(AppRoutes.homeScreen.name,
                        extra: currentUser);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: appButton(text: "Salvează copilul"),
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
