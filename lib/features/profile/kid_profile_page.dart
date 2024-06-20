import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracker/helpers/widget_manager.dart';
import '../../authentication/components/show_loading.dart';
import '../children/kids.dart';
import '../children/kids_repository.dart';
import '../common/utils/show_read_err.dart';
import '../drawer/kid_avatar.dart';
import '../drawer/storage.dart';

class KidProfileScreen extends HookConsumerWidget {
  final ImagePicker _picker = ImagePicker();

  KidProfileScreen({super.key, required this.kidData});
  final Kid kidData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doc = ref.watch(getKidFutureProvider(kidId: kidData.id.toString()));
    if (doc is AsyncError) {
      final err = doc as AsyncError;
      return ShowReadErr(
          err: err.error,
          stack: err.stackTrace,
          retry: () => ref
              .invalidate(getKidFutureProvider(kidId: kidData.id.toString())));
    }
    if (doc is AsyncLoading) {
      return const ShowLoading(
        text: 'Se încarcă profilul actual al copilului ...',
      );
    }
    final Kid kid = (doc as AsyncData).value;
    final nameController = useTextEditingController(text: kid.name);
    final dobController = useTextEditingController(text: kid.dateOfBirth);
    final weightController =
        useTextEditingController(text: kid.childWeight.toString());
    final heightController =
        useTextEditingController(text: kid.childHeight.toString());
    final headCircumferenceController =
        useTextEditingController(text: kid.childHeadCircumference.toString());
    final isPremature = useState<bool>(kid.isPremature);
    final isHasTwin = useState<bool>(kid.isHasTwin);
    final imageFile = useState<String?>(kid.profileImgUriChild);
    final isLoadingPic = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(context);
          },
        ),
        title: const Text(
          'Profilul Copilului',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: <Widget>[
                  imageProfile(kid, imageFile, context),
                  const SizedBox(height: 20),
                  nameTextField(nameController),
                  const SizedBox(height: 20),
                  dateOfBirthTextField(dobController),
                  const SizedBox(height: 20),
                  weightTextField(weightController),
                  const SizedBox(height: 20),
                  heightTextField(heightController),
                  const SizedBox(height: 20),
                  headCircumferenceTextField(headCircumferenceController),
                  const SizedBox(height: 20),
                  prematureCheckbox(isPremature),
                  const SizedBox(height: 20),
                  hasTwinCheckbox(isHasTwin),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            isLoadingPic.value
                ? const SizedBox(
                    width: 90, height: 90, child: CircularProgressIndicator())
                : appButton(
                    onPressed: () async {
                      if (imageFile.value != null) {
                        final st = Storage();
                        var newKid = kid;
                        if (imageFile.value != kid.profileImgUriChild) {
                          debugPrint(
                              'KidProfileScreen | onPressed | actualizează imaginea copilului: ${imageFile.value}');
                          final gsFilePath = st.getGsKidPicPathBasedOnDate(
                              imageFile.value!,
                              kid.assignedParentId.toString());
                          await st.uploadFile(gsFilePath, imageFile.value!);
                          debugPrint(
                              'KidProfileScreen | onPressed | downloadableUrl=$gsFilePath');
                          newKid = kid.copyWith(profileImgUriChild: gsFilePath);
                        }
                        if (nameController.text != newKid.name) {
                          newKid = newKid.copyWith(name: nameController.text);
                        }
                        if (dobController.text != newKid.dateOfBirth) {
                          newKid =
                              newKid.copyWith(dateOfBirth: dobController.text);
                        }
                        if (weightController.text !=
                            newKid.childWeight.toString()) {
                          newKid = newKid.copyWith(
                              childWeight: double.parse(
                                  weightController.text.replaceAll(',', '.')));
                        }
                        if (heightController.text !=
                            newKid.childHeight.toString()) {
                          newKid = newKid.copyWith(
                              childHeight: double.parse(
                                  heightController.text.replaceAll(',', '.')));
                        }
                        if (headCircumferenceController.text !=
                            newKid.childHeadCircumference.toString()) {
                          newKid = newKid.copyWith(
                              childHeadCircumference: double.parse(
                                  headCircumferenceController.text
                                      .replaceAll(',', '.')));
                        }
                        newKid = newKid.copyWith(
                            isPremature: isPremature.value,
                            isHasTwin: isHasTwin.value);

                        if (newKid == kid) {
                          debugPrint(
                              'KidProfileScreen | onPressed | profilul copilului nu a fost schimbat (imagine + detalii) așa că nu salvăm nimic în baza de date.');
                          return;
                        }

                        debugPrint(
                            'KidProfileScreen | onPressed | Salvăm noul profil pentru ${newKid.name}');
                        final ur = KidsRepository();
                        await ur.updateKid(newKid);
                      }
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    text: 'Salvează',
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget imageProfile(
      Kid? kid, ValueNotifier<String?> imageFile, BuildContext context) {
    debugPrint('KidProfileScreen | imageProfile | kid=${kid?.name}');
    return Center(
      child: Stack(
        children: <Widget>[
          imageFile.value != kid?.profileImgUriChild && imageFile.value != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(imageFile.value!)))
              : KidNetworkAvatar(
                  kid: kid!,
                  avatarSize: AvatarSize.profilePic,
                ),
          Positioned(
            bottom: 1.0,
            right: 1.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (builder) => bottomSheet(context, imageFile),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 25.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context, ValueNotifier<String?> file) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "Alegeți Fotografia de Profil",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera, file);
                },
                label: const Text("Cameră"),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery, file);
                },
                label: const Text("Galerie"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> takePhoto(
      ImageSource source, ValueNotifier<String?> imageFile) async {
    final XFile? image = await _picker.pickImage(source: source);
    debugPrint('_KidProfileScreen | takePhoto | image=${image?.path}');
    final l = await image?.length();
    debugPrint('_KidProfileScreen | takePhoto | image length=$l');
    imageFile.value = image?.path;
  }

  Widget nameTextField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          labelText: 'Nume',
          labelStyle: TextStyle(fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person, color: Colors.blue),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget dateOfBirthTextField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          labelText: 'Data Nașterii',
          labelStyle: TextStyle(fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.cake, color: Colors.blue),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  Widget weightTextField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          labelText: 'Greutate',
          labelStyle: TextStyle(fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.monitor_weight, color: Colors.blue),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            final text = newValue.text.replaceAll(',', '.');
            return newValue.copyWith(text: text);
          }),
        ],
      ),
    );
  }

  Widget heightTextField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          labelText: 'Înălțime',
          labelStyle: TextStyle(fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.height, color: Colors.blue),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            final text = newValue.text.replaceAll(',', '.');
            return newValue.copyWith(text: text);
          }),
        ],
      ),
    );
  }

  Widget headCircumferenceTextField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          labelText: 'Circumferința Capului',
          labelStyle: TextStyle(fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.circle, color: Colors.blue),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            final text = newValue.text.replaceAll(',', '.');
            return newValue.copyWith(text: text);
          }),
        ],
      ),
    );
  }

  Widget prematureCheckbox(ValueNotifier<bool> isPremature) {
    return CheckboxListTile(
      title: const Text('Prematur'),
      value: isPremature.value,
      onChanged: (bool? value) {
        isPremature.value = value ?? false;
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget hasTwinCheckbox(ValueNotifier<bool> isHasTwin) {
    return CheckboxListTile(
      title: const Text('Gemeni?'),
      value: isHasTwin.value,
      onChanged: (bool? value) {
        isHasTwin.value = value ?? false;
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
