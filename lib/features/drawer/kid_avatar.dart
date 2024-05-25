import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/drawer/storage.dart';

enum AvatarSize { listTile, drawerBig, drawerSmall, profilePic }

class KidNetworkAvatar extends ConsumerWidget {
  const KidNetworkAvatar({
    super.key,
    required this.avatarSize,
    required this.kidId,
  });

  final AvatarSize avatarSize;
  final String kidId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return getKidCircleAvatar(context, kidId);
  }

  Widget getKidCircleAvatar(BuildContext context, String kidId) {
    final radius = getRadius(avatarSize);
    final storage = Storage();
    return FutureBuilder<String>(
        future: storage.getKidProfilePicUrl(kidId),
        builder: (BuildContext context, AsyncSnapshot<String> url) {
          if (url.hasError) {
            if (kDebugMode) {
              print('Could not load profile pic for kid $kidId');
            }
            return defaultAvatar(context, avatarSize);
          }
          if (url.hasData) {
            if (url.data == null || url.data!.isEmpty) {
              return defaultAvatar(context, avatarSize);
            }
            return CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(url.data!),
            );
          } else {
            return loading(radius);
          }
        });
  }

  double getRadius(AvatarSize av) {
    double radius = 20.0;
    switch (avatarSize) {
      case AvatarSize.profilePic:
        radius = 60;
        break;
      case AvatarSize.listTile:
        radius = 20;
        break;
      case AvatarSize.drawerBig:
        radius = 90;
        break;
      case AvatarSize.drawerSmall:
        radius = 20;
        break;
    }
    return radius;
  }

  Widget loading(double radius) {
    return SizedBox(
      height: radius,
      width: radius,
      child: const CircularProgressIndicator(),
    );
  }

  Widget defaultAvatar(BuildContext context, AvatarSize avatarSize) {
    final radius = getRadius(avatarSize);
    const defaultImg = AssetImage('assets/images/profile.jpg');
    return CircleAvatar(backgroundImage: defaultImg, radius: radius);
  }
}
