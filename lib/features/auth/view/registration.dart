import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth_provider.dart';
import '../../../utils/validator.dart';
import '../../../widget/app_text_field.dart';
import '../../../widget/custom_button.dart';
import '../../home/view/home.dart';
import 'login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  void toggleLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void signUp() async {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      await authProvider
          .signUpInWithEmailAndPassword(name, email, password)
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      });
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    AppTextField(
                      validator: (name) {
                        return Validate.name(name!);
                      },
                      hintText: "Name",
                      keyboardType: TextInputType.name,
                      controller: nameController,
                    ),
                    SizedBox(height: height * 0.02),
                    AppTextField(
                      validator: (email) {
                        return Validate.validateEmail(email!);
                      },
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(height: height * 0.02),
                    AppTextField(
                      validator: (password) {
                        return Validate.password(password!);
                      },
                      obscureText: true,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                    SizedBox(height: height * 0.02),
                    AppTextField(
                      validator: (confirmPassword) {
                        return Validate.matchPassword(
                            passwordController.text.trim(), confirmPassword!);
                      },
                      obscureText: true,
                      hintText: "Confirm Password",
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                    ),
                    SizedBox(height: height * 0.02),
                    AppCustomButton(
                      loading: loading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          toggleLoading(true);
                          signUp();
                          toggleLoading(true);
                        }
                      },
                      title: "Register",
                    ),
                    SizedBox(height: height * 0.02),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 16,
                          ),
                          children: [
                            const TextSpan(
                              text: "Already have an account?",
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                              text: " Login",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
