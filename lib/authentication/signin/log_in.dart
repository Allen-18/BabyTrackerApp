import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validators/form_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tracker/authentication/components/loading_error.dart';
import 'package:tracker/authentication/signin/forgot_password_button.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/dimen_manager.dart';
import 'package:tracker/helpers/routes_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'controller/signin_controller.dart';


class Login extends HookConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final signInState = ref.watch(signInProvider);
    final showErrorEmail = signInState.email.isNotValid;
    final showErrorPassword = signInState.password.isNotValid;
    final signInController = ref.read(signInProvider.notifier);
    final isLoading = useState(false);

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
                child: Image.asset(AppAssets.logo),
              ),
            ),
            const SizedBox(height: AppMargin.m20),
            Expanded(
              flex: 2,
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(100))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: AppMargin.m12,
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              top: AppMargin.m20, bottom: 40),
                          child: Text(
                            'Login',
                            style: getBoldStyle(
                                color: AppColors.black, fontSize: 40),
                          )),
                      loginBox(
                        context: context,
                        text: "Email",
                        child: TextFormField(
                          initialValue: signInState.email.value,
                          onChanged: (value) =>
                              signInController.onEmailChange(value),
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (showErrorEmail)
                        const SizedBox(
                          height: 5,
                        ),
                      Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Row(children: [
                            Text(
                              Email.showEmailErrorMessage(
                                      signInState.email.error) ??
                                  "",
                              style: const TextStyle(color: Colors.red),
                            )
                          ])),
                      const SizedBox(
                        height: AppMargin.m14,
                      ),
                      loginBox(
                        context: context,
                        text: "Password",
                        child: TextFormField(
                          initialValue: signInState.password.value,
                          onChanged: (value) =>
                              signInController.onPasswordChange(value),
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (showErrorPassword) const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          children: [
                            Text(
                              Password.showPasswordErrorMessage(
                                      signInState.password.error) ??
                                  "",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppMargin.m20,
                      ),
                      const ForgotPasswordButton(),
                      const SizedBox(
                        height: AppMargin.m20,
                      ),
                      isLoading.value
                          ? const SizedBox(
                              width: 90,
                              height: 90,
                              child: LoadingSheet(),
                            )
                          : GestureDetector(
                              onTap: () async {
                                isLoading.value = true; // Start loading
                                FirebaseException? error =
                                    await signInController
                                        .signInWithEmailAndPassword();
                                isLoading.value = false; // Stop loading
                                if (error != null) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error.toString())));
                                  } // Show error if any
                                } else {
                                  if (context.mounted) {
                                    Navigator.pushReplacementNamed(
                                        context, Routes.aboutMother);
                                  }
                                }
                              },
                              child: appButton(text: "Login"),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, Routes.signUp),
                          child: Text(
                            "Don't have an Account?",
                            style: getRegularStyle(
                                color: AppColors.primary, fontSize: 14),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
