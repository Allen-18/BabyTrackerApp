import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/features/homePage/home_page.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.parent});
  final User parent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> pages = [
      Home(currentUser: parent),
    ];
    return Scaffold(body: pages.elementAt(0));
  }
}
