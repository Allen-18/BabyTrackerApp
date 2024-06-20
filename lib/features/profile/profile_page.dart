import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../authentication/components/show_loading.dart';
import '../../authentication/domain/user.dart';
import '../../authentication/repository/users.dart';
import '../../helpers/widget_manager.dart';
import '../../services/app_router.dart';
import '../common/utils/show_read_err.dart';
import '../drawer/parent_avatar.dart';
import '../drawer/storage.dart';

class ProfileScreen extends HookConsumerWidget {
  final ImagePicker _picker = ImagePicker();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doc = ref.watch(getCurrentUserStreamProvider);
    if (doc is AsyncError) {
      final err = doc as AsyncError;
      return ShowReadErr(
          err: err.error,
          stack: err.stackTrace,
          retry: () => ref.invalidate(getCurrentUserStreamProvider));
    }
    if (doc is AsyncLoading) {
      return const ShowLoading(
        text: 'Loading current parent profile ...',
      );
    }
    final User parent = (doc as AsyncData).value;
    final nameController = useTextEditingController(text: parent.name);
    final imageFile = useState<String?>(parent.profileImgUri);
    final isLoadingPic = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pushNamed(AppRoutes.homeScreen.name, extra: parent);
          },
        ),
        title: const Text(
          'Profilul părintelui',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: <Widget>[
            imageProfile(parent, imageFile, context),
            const SizedBox(
              height: 20,
            ),
            nameTextField(nameController),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Adaugă o soră sau un frate',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                context.push('/addNewBaby', extra: parent);
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLoadingPic.value
          ? const SizedBox(
              width: 90, height: 90, child: CircularProgressIndicator())
          : appButton(
              onPressed: () async {
                if (imageFile.value != null) {
                  final st = Storage();
                  var newParent = parent;
                  if (imageFile.value != parent.profileImgUri) {
                    debugPrint(
                        'ProfileScreen | onPressed | updating user image: ${imageFile.value}');
                    final gsFilePath =
                        st.getGsProfilePicPathBasedOnDate(imageFile.value!);
                    await st.uploadFile(gsFilePath, imageFile.value!);
                    debugPrint(
                        'ProfileScreen | onPressed | downlodableUrl=$gsFilePath');
                    newParent = parent.copyWith(profileImgUri: gsFilePath);
                  }
                  if (nameController.text != newParent.name) {
                    newParent = newParent.copyWith(name: nameController.text);
                  }
                  if (newParent == parent) {
                    debugPrint(
                        'ProfileScreen | onPressed | user profile was not changed (img + name) so we dont save anything in db.');
                    return;
                  }

                  debugPrint(
                      'ProfileScreen | onPressed | Saving new profile for ${newParent.name}');
                  final ur = UsersRepository();
                  await ur.updateUser(newParent);
                }
                if (context.mounted) {
                  context.pop();
                }
              },
              text: 'Salvează',
            ),
    );
  }

  Widget imageProfile(
      User? parent, ValueNotifier<String?> imageFile, BuildContext context) {
    debugPrint('ProfileScreen | imageProfile | parent=${parent?.name}');
    return Center(
      child: Stack(
        children: <Widget>[
          imageFile.value != parent?.profileImgUri && imageFile.value != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(imageFile.value!)))
              : ParentNetworkAvatar(
                  parent: parent,
                  avatarSize: AvatarSizeForParent.profilePic,
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
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Alegeți Fotografie de profil",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera, file);
                },
                label: const Text("Camera"),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery, file);
                },
                label: const Text("Gallery"),
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
    debugPrint('_ProfileScreen | takePhoto | image=${image?.path}');
    final l = await image?.length();
    debugPrint('_ProfileScreen | takePhoto | image length=$l');
    imageFile.value = image?.path;
  }

  Widget nameTextField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          labelText: 'Nume',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
