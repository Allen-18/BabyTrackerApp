import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/authentication/repository/users.dart';
import 'package:tracker/features/drawer/storage.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/features/common/utils/show_read_err.dart';

enum AvatarSize { listTile, drawerBig, drawerSmall, profilePic }

class ParentNetworkAvatar extends ConsumerWidget {
  const ParentNetworkAvatar({
    super.key,
    required this.avatarSize,
    this.parentId,
    this.parent,
  });

  final AvatarSize avatarSize;
  final String? parentId;
  final User? parent;
  final st = const Storage(clientId: 'oradea');

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
    return FutureBuilder<String>(
        future: st.getProfilePicUrl(parent.profileImgUri!),
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

  Widget addOnTap(BuildContext context, CircleAvatar w) {
    if (avatarSize == AvatarSize.drawerSmall) {
      return GestureDetector(
        child: w,
        onTap: () => Scaffold.of(context).openEndDrawer(),
      );
    } else {
      return w;
    }
  }

  CircleAvatar addIsActive(CircleAvatar w, bool? isActive) {
    if (isActive == null) {
      return w;
    }
    var margin = 2.0;
    if (avatarSize == AvatarSize.drawerBig) {
      margin = 6.0;
    }
    if (avatarSize == AvatarSize.listTile) {
      margin = 0.5;
    }
    if (avatarSize == AvatarSize.drawerSmall) {
      margin = 4.5;
    }
    return CircleAvatar(
        backgroundImage: w.backgroundImage,
        radius: w.radius,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(margin),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.lightGreenAccent[700] : Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget addPadding(Widget w) {
    return Padding(padding: const EdgeInsets.only(right: 10), child: w);
  }

  Widget defaultAvatar(
      BuildContext context, AvatarSize avatarSize, User? parent) {
    final radius = getRadius(avatarSize);
    const defaultImg = AssetImage('assets/images/profile.jpg');
    return CircleAvatar(backgroundImage: defaultImg, radius: radius);
  }
}
