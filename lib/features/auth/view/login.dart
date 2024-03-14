import 'dart:developer';
import 'package:chat_app/utils/validator.dart';
import 'package:chat_app/widget/app_text_field.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth_provider.dart';
import '../../home/view/home.dart';
import 'registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  void toggleLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void login() async {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      await authProvider
          .loginInWithEmailAndPassword(email, password)
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
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        return Validate.validateEmail(email!);
                      },
                      hintText: "Email",
                      controller: emailController,
                    ),
                    SizedBox(height: height * 0.02),
                    AppTextField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (password) {
                        return Validate.password(password!);
                      },
                      obscureText: true,
                      hintText: "Password",
                      controller: passwordController,
                    ),
                    SizedBox(height: height * 0.02),
                    AppCustomButton(
                      loading: loading,
                      onTap: () {
                        // signInWithGoogle();

                        if (formKey.currentState!.validate()) {
                          toggleLoading(true);
                          login();
                          toggleLoading(false);
                        }
                      },
                      title: "Login",
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
                              text: "Don't have an account?",
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen(),
                                    ),
                                  );
                                },
                              text: " Register",
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
