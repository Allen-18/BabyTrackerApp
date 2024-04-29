import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tracker/helpers/colors_manager.dart';

class LoadingSheet extends StatelessWidget {
  const LoadingSheet({super.key});
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(48),
        )),
        context: context,
        builder: (_) => const LoadingSheet());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: AppColors.primary, size: 80));
  }
}
