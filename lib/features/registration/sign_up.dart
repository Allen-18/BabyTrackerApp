import 'package:flutter/material.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/dimen_manager.dart';
import 'package:tracker/helpers/routes_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      style: getBoldStyle(color: AppColors.white, fontSize: 40))),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 70),
                    loginBox(
                      context: context,
                      text: "Email",
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppMargin.m14,
                    ),
                    loginBox(
                      context: context,
                      text: "Password",
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter your password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppMargin.m14,
                    ),
                    loginBox(
                      context: context,
                      text: "Confirm Password",
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Confirm your password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppMargin.m14,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.login),
                      child: Text(
                        "Already have an account",
                        style: getRegularStyle(color: AppColors.primary, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.aboutMother),
                      child: appButton(text: "Create Account"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
