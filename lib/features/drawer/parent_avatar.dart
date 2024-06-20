import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/authentication/repository/users.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/features/common/utils/show_read_err.dart';
import 'package:tracker/features/drawer/storage.dart';

enum AvatarSizeForParent { listTile, drawerBig, drawerSmall, profilePic }

class ParentNetworkAvatar extends ConsumerWidget {
  const ParentNetworkAvatar({
    super.key,
    required this.avatarSize,
    this.parentId,
    this.parent,
  });

  final AvatarSizeForParent avatarSize;
  final String? parentId;
  final User? parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (parentId == null && parent == null) {
      return defaultAvatar(context, avatarSize, parent);
    }
    if (parent != null) {
      return getParentCircleAvatar(context, parent);
    }

    final pod = getUserStreamProvider(uid: parentId);
    final da = ref.watch(pod);
    final radius = getRadius(avatarSize);
    return da.when(
        loading: () => loading(radius),
        error: (err, stack) => ShowReadErr(
            err: err, stack: stack, retry: () => ref.invalidate(pod)),
        data: (parent) => getParentCircleAvatar(context, parent));
  }

  Widget getParentCircleAvatar(BuildContext context, User? parent) {
    final radius = getRadius(avatarSize);
    if (parent == null ||
        parent.profileImgUri == null ||
        parent.profileImgUri!.isEmpty) {
      return defaultAvatar(context, avatarSize, parent);
    }
    final storage = Storage();
    return FutureBuilder<String>(
        future: storage.getProfilePicUrl(parent.profileImgUri!),
        builder: (BuildContext context, AsyncSnapshot<String> url) {
          if (url.hasError) {
            if (kDebugMode) {
              print('Could not load profile pic for ${parent.name}');
            }
            return defaultAvatar(context, avatarSize, parent);
          }
          if (url.hasData) {
            if (url.data == null || url.data!.isEmpty) {
              return defaultAvatar(context, avatarSize, parent);
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

  double getRadius(AvatarSizeForParent av) {
    double radius = 20.0;
    switch (avatarSize) {
      case AvatarSizeForParent.profilePic:
        radius = 60;
        break;
      case AvatarSizeForParent.listTile:
        radius = 40;
        break;
      case AvatarSizeForParent.drawerBig:
        radius = 90;
        break;
      case AvatarSizeForParent.drawerSmall:
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

  Widget addOnTap(BuildContext context, CircleAvatar w) {
    if (avatarSize == AvatarSizeForParent.drawerSmall) {
      return GestureDetector(
        child: w,
        onTap: () => Scaffold.of(context).openEndDrawer(),
      );
    } else {
      return w;
    }
  }

  Widget addPadding(Widget w) {
    return Padding(padding: const EdgeInsets.only(right: 10), child: w);
  }

  Widget defaultAvatar(
      BuildContext context, AvatarSizeForParent avatarSize, User? parent) {
    final radius = getRadius(avatarSize);
    const defaultImg = AssetImage('assets/images/profile.jpg');
    return CircleAvatar(backgroundImage: defaultImg, radius: radius);
  }
}
