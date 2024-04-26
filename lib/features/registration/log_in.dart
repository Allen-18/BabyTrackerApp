import 'package:flutter/material.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/dimen_manager.dart';
import 'package:tracker/helpers/routes_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        height: AppMargin.m20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, Routes.home),
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
