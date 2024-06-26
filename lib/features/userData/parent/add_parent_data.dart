import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/features/common/providers/relationship_pod.dart';
import 'package:tracker/authentication/repository/users.dart';
import 'package:tracker/features/drawer/storage.dart';

class Parent extends HookConsumerWidget {
  Parent({super.key, required this.parent});

  final User parent;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRelationship = ref.watch(selectedRelationshipPod);
    final nameController = useTextEditingController();
    final imageFile = useState<String?>(parent.profileImgUri);

    Future<void> takePhoto(
        ImageSource source, ValueNotifier<String?> imageFile) async {
      final XFile? image = await _picker.pickImage(source: source);
      debugPrint('Parent | takePhoto | image=${image?.path}');
      final l = await image?.length();
      debugPrint('Parent | takePhoto | image length=$l');
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
                  title: const Text('Camera'),
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

    Size size = MediaQuery.of(context).size;

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
              const Center(
                child: Text(
                  "Vă rugăm să acordați un moment pentru a personaliza aplicația.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
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
                decoration: InputDecoration(
                  labelText: 'Introduceți numele dvs.',
                  fillColor: AppColors.lightGrey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: getRegularStyle(color: AppColors.grey, fontSize: 15),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduceți numele dvs.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Text(
                'Relația cu copilul:',
                style: getRegularStyle(color: AppColors.black, fontSize: 15),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Mamă', style: TextStyle(fontSize: 20)),
                      value: Relationship.mother.name,
                      groupValue: selectedRelationship,
                      onChanged: (String? value) {
                        ref.read(selectedRelationshipPod.notifier).state =
                            value;
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Tată', style: TextStyle(fontSize: 20)),
                      value: Relationship.father.name,
                      groupValue: selectedRelationship,
                      onChanged: (String? value) {
                        ref.read(selectedRelationshipPod.notifier).state =
                            value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.2),
              GestureDetector(
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  if (selectedRelationship != null &&
                      nameController.text.isNotEmpty) {
                    final st = Storage();
                    final gsFilePath = st
                        .getGsProfilePicPathBasedOnDate(imageFile.value ?? '');
                    if (imageFile.value != null) {
                      await st.uploadFile(gsFilePath, imageFile.value!);
                    }
                    var updatedUser = parent.copyWith(
                      profileImgUri: gsFilePath,
                      name: nameController.text.trim(),
                      relationship: selectedRelationship,
                      isActive: true,
                      hasChild: false,
                    );
                    try {
                      final repo = ref.read(usersRepositoryProvider);
                      await repo.updateUser(updatedUser);
                      if (context.mounted) {
                        context
                            .pushReplacementNamed(AppRoutes.addBabyData.name);
                      }
                    } catch (ex) {
                      if (kDebugMode) {
                        print("Could not save new User: $updatedUser");
                      }
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Eroare la salvarea utilizatorului.')),
                        );
                      }
                      return;
                    }
                  } else {
                    if (kDebugMode) {
                      print("Form fields are not correctly filled.");
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Vă rugăm să completați toate câmpurile corect.')),
                    );
                    return;
                  }
                },
                child: appButton(text: "Continuă"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
