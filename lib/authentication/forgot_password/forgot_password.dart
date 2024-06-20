import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import '../../services/app_router.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordController = ref.read(forgotPasswordProvider.notifier);
    final email =
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
                        initialValue: email,
                        onChanged: (value) =>
                            forgotPasswordController.onEmailChange(value),
                        decoration: const InputDecoration(
                          hintText: 'Introduceți email-ul',
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),
                      appButton(
                        context: context,
                        text: "Resetați parola",
                        onPressed: () async {
                          if (ref
                              .read(forgotPasswordProvider)
                              .status
                              .isSuccess) {
                            await forgotPasswordController.forgotPassword();
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Un email a fost trimis către $email. Faceți clic pe linkul primit și introduceți noua parolă.'),
                                    content: const SingleChildScrollView(
                                      child: Text(
                                        'După aceea, puteți reveni în aplicație și vă puteți autentifica cu noua parolă.',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              fontSize: 26.0,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          context.pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.white),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Vă rugăm să introduceți o adresă de email validă.',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 40),
                                      appButton(
                                        context: context,
                                        text: 'OK',
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                          "Anulare",
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
