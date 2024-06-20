import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/drawer/storage.dart';
import 'package:tracker/features/children/kids.dart';

import '../children/kids_repository.dart';
import '../common/utils/show_read_err.dart';

enum AvatarSize { listTile, drawerBig, drawerSmall, profilePic }

class KidNetworkAvatar extends ConsumerWidget {
  const KidNetworkAvatar({
    super.key,
    required this.avatarSize,
    required this.kid,
  });

  final AvatarSize avatarSize;
  final Kid kid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pod = getKidFutureProvider(kidId: kid.id!);
    final da = ref.watch(pod);
    final radius = getRadius(avatarSize);
    return da.when(
        loading: () => loading(radius),
        error: (err, stack) => ShowReadErr(
            err: err, stack: stack, retry: () => ref.invalidate(pod)),
        data: (parent) => getKidCircleAvatar(context, kid));
  }

  Widget getKidCircleAvatar(BuildContext context, Kid kid) {
    final radius = getRadius(avatarSize);
    if (kid.profileImgUriChild == null || kid.profileImgUriChild!.isEmpty) {
      return defaultAvatar(context, avatarSize, kid);
    }
    final storage = Storage();
    return FutureBuilder<String>(
        future: storage.getProfilePicUrl(kid.profileImgUriChild!),
        builder: (BuildContext context, AsyncSnapshot<String> url) {
          if (url.hasError) {
            if (kDebugMode) {
              print('Could not load profile pic for kid $kid');
            }
            return defaultAvatar(context, avatarSize, kid);
          }
          if (url.hasData) {
            if (url.data == null || url.data!.isEmpty) {
              return defaultAvatar(context, avatarSize, kid);
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

  Widget defaultAvatar(BuildContext context, AvatarSize avatarSize, Kid kid) {
    final radius = getRadius(avatarSize);
    const defaultImg = AssetImage('assets/images/profile.jpg');
    return CircleAvatar(backgroundImage: defaultImg, radius: radius);
  }
}
