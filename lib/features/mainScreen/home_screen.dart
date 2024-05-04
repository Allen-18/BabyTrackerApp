import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/mainScreen/provider/selected_index_provider.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'categories_page.dart';
import 'progress_page.dart';
import 'package:tracker/features/homePage/home_page.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.parent});
  final User parent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = ref.watch(selectedIndexProvider);
    final List<Widget> pages = [
      Home(currentUser: parent),
      Categories(),
      const Progress()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        showSelectedLabels: false,
        selectedItemColor: AppColors.primary,
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(selectedIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(label: "", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.category)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.bar_chart)),
        ],
      ),
      body: pages.elementAt(selectedIndex),
    );
  }
}
