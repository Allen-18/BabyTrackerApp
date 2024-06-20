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
import '../../drawer/storage.dart';
import 'measurement_fields.dart';

class BabyProfile extends HookConsumerWidget {
  BabyProfile({
    super.key,
  });

  //final User parent;

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
    final twinIsPremature = useState(false);
    final isPremature = useState(false);
    final imageFile = useState<String?>('');
    final twinImageFile = useState<String?>('');

    Future<void> takePhoto(
        ImageSource source, ValueNotifier<String?> imageFile) async {
      final XFile? image = await _picker.pickImage(source: source);
      debugPrint('_BabyProfile | takePhoto | image=${image?.path}');
      final l = await image?.length();
      debugPrint('_BabyProfile | takePhoto | image length=$l');
      imageFile.value = image?.path;
    }

    void showImageSourceActionSheet(
        BuildContext context, ValueNotifier<String?> imageFile) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galerie'),
                  onTap: () {
                    takePhoto(ImageSource.gallery, imageFile);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Cameră'),
                  onTap: () {
                    takePhoto(ImageSource.camera, imageFile);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
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
                  onTap: () => showImageSourceActionSheet(context, imageFile),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.lightPrimary,
                    backgroundImage: imageFile.value != null
                        ? FileImage(File(imageFile.value!))
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
                decoration:
                    const InputDecoration(labelText: "Numele copilului"),
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
                title:
                    Text('Băiat', style: TextStyle(color: AppColors.darkGrey)),
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
                    Text('Fată', style: TextStyle(color: AppColors.darkGrey)),
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
                  const Text('Bebeluș născut prematur'),
                  Checkbox(
                    value: isPremature.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        isPremature.value = value;
                      }
                    },
                  ),
                ],
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
                    onTap: () =>
                        showImageSourceActionSheet(context, twinImageFile),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.lightPrimary,
                      backgroundImage: twinImageFile.value != null
                          ? FileImage(File(twinImageFile.value!))
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
                  title: Text('Băiat',
                      style: TextStyle(color: AppColors.darkGrey)),
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
                      Text('Fată', style: TextStyle(color: AppColors.darkGrey)),
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
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Bebeluș născut prematur'),
                    Checkbox(
                      value: twinIsPremature.value,
                      onChanged: (bool? value) {
                        if (value != null) {
                          twinIsPremature.value = value;
                        }
                      },
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  final currentUser =
                      await ref.read(getCurrentUserStreamProvider.future);
                  User u = currentUser!.copyWith(hasChild: true);
                  try {
                    final repo = ref.read(usersRepositoryProvider);
                    await repo.updateUser(u);
                  } catch (ex) {
                    if (kDebugMode) {
                      print("Could not save new User: $u");
                    }
                  }
                  final st = Storage();
                  String? gsFilePath;
                  String? gsFilePathTwin;

                  if (imageFile.value != null) {
                    gsFilePath = st.getGsKidPicPathBasedOnDate(
                        imageFile.value!, currentUser.id.toString());
                    await st.uploadFile(gsFilePath, imageFile.value!);
                  }

                  if (twinImageFile.value != null) {
                    gsFilePathTwin = st.getGsKidPicPathBasedOnDate(
                        twinImageFile.value!, currentUser.id.toString());
                    await st.uploadFile(gsFilePathTwin, twinImageFile.value!);
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
                    assignedParentId: currentUser.id,
                    profileImgUriChild: gsFilePath,
                  );

                  try {
                    final repo = ref.read(kidsRepositoryProvider);
                    await repo.createNewKid(addKid);
                  } catch (ex) {
                    if (kDebugMode) {
                      print("Could not save new Kid: $addKid");
                    }
                  }

                  if (isTwin.value) {
                    Kid twinKid = Kid(
                      name: twinNameController.text.trim(),
                      dateOfBirth: twinDobController.text.trim(),
                      gender: twinGender.value,
                      isHasTwin: true,
                      isPremature: twinIsPremature.value,
                      childWeight: double.parse(
                          twinWeightController.text.replaceAll(',', '.')),
                      childHeight: double.parse(
                          twinHeightController.text.replaceAll(',', '.')),
                      childHeadCircumference: double.parse(
                          twinHeadCircumferenceController.text
                              .replaceAll(',', '.')),
                      assignedParentId: currentUser.id,
                      profileImgUriChild: gsFilePathTwin,
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
                  if (context.mounted) {
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
