import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/services/app_router.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          context.pushReplacementNamed(AppRoutes.forgetPassword.name);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password",
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
