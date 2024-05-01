import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/services/app_router.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordController = ref.read(forgotPasswordProvider.notifier);
    final emailState =
        ref.watch(forgotPasswordProvider.select((state) => state.email.value));
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.registrationBackground),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: emailState,
                        onChanged: (value) =>
                            forgotPasswordController.onEmailChange(value),
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),
                      appButton(
                        context: context,
                        text: "Reset Password",
                        onPressed: () {
                          if (ref
                              .read(forgotPasswordProvider)
                              .status
                              .isSuccess) {
                            forgotPasswordController.forgotPassword();
                            if (context.mounted) {
                              context
                                  .pushReplacementNamed(AppRoutes.login.name);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter a valid email address')),
                            );
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          if (context.mounted) {
                            context.pushReplacementNamed(AppRoutes.login.name);
                          }
                        },
                        child: Text(
                          "Cancel",
                          style: getRegularStyle(
                              color: AppColors.primary, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
