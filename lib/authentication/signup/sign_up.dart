import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:form_validators/form_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tracker/authentication/components/loading_error.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/dimen_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/authentication/components/login_box.dart';
import 'controller/signup_controller.dart';

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final confirmPasswordProvider = StateProvider<String>((ref) => '');

class SignUp extends HookConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final signUpState = ref.watch(signUpProvider);
    final signUpController = ref.read(signUpProvider.notifier);
    final isLoading = useState(false);
    final signUpAttempted = useState(false);

    final showErrorEmail = signUpAttempted.value && signUpState.email.isNotValid;
    final showErrorPassword = signUpAttempted.value && signUpState.password.isNotValid;
    final showErrorConfirmPassword = signUpAttempted.value && signUpState.confirmPassword.isNotValid;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.registrationBackground),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(top: AppMargin.m70),
                  child: Text('Sign Up',
                      style:
                      getBoldStyle(color: AppColors.black, fontSize: 40))),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(height: 70),
                      loginBox(
                        context: context,
                        text: "Email",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                child: TextFormField(
                                  initialValue: signUpState.email.value,
                                  onChanged: (value) =>
                                      signUpController.onEmailChange(value),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your email',
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      if (showErrorEmail)
                        const SizedBox(
                          height: 5,
                        ),
                      if (showErrorEmail)
                        Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              Email.showEmailErrorMessage(
                                  signUpState.email.error) ??
                                  "",
                              style: const TextStyle(color: Colors.red),
                            )),
                      const SizedBox(
                        height: AppMargin.m14,
                      ),
                      loginBox(
                        context: context,
                        text: "Password",
                        child: TextFormField(
                          initialValue: signUpState.password.value,
                          onChanged: (value) =>
                              signUpController.onPasswordChange(value),
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (showErrorPassword)
                        const SizedBox(
                          height: 5,
                        ),
                      if (showErrorPassword)
                        Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              Password.showPasswordErrorMessage(
                                  signUpState.password.error) ??
                                  "",
                              style: const TextStyle(color: Colors.red),
                            )),
                      const SizedBox(
                        height: AppMargin.m14,
                      ),
                      loginBox(
                        context: context,
                        text: "Confirm Password",
                        child: TextFormField(
                          initialValue: signUpState.confirmPassword.value,
                          onChanged: (value) =>
                              signUpController.onConfirmPasswordChange(value),
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Confirm your password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (showErrorConfirmPassword)
                        const SizedBox(
                          height: 5,
                        ),
                      if (showErrorConfirmPassword)
                        Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              ConfirmPassword.showConfirmPasswordErrorMessage(
                                  signUpState.confirmPassword.error) ??
                                  "",
                              style: const TextStyle(color: Colors.red),
                            )),
                      const SizedBox(
                        height: AppMargin.m14,
                      ),
                      isLoading.value
                          ? const SizedBox(
                        width: 90,
                        height: 90,
                        child: LoadingSheet(),
                      )
                          : TextButton(
                        onPressed: () async {
                          if (context.mounted) {
                            context.pushNamed(AppRoutes.login.name);
                          }
                        },
                        child: Text(
                          "Already have an account",
                          style: getRegularStyle(
                              color: AppColors.primary, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () async {
                          signUpAttempted.value = true;
                          isLoading.value = true; // Start loading
                          FirebaseException? error = await signUpController
                              .signUpWithEmailAndPassword();
                          if (error != null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                            } // Show error if any
                          } else {
                            if (context.mounted) {
                              context.pushNamed(AppRoutes.login.name);
                            }
                          }
                        },
                        child: appButton(text: "Create Account"),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
