import 'package:autour_mobile/screens/auth/signup_screen.dart';
import 'package:autour_mobile/screens/home_screen.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:autour_mobile/widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Logo Placeholder
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: 'Logo',
                      fontSize: 24,
                      color: primary,
                      fontFamily: 'Bold',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Title
                TextWidget(
                  text: 'Welcome Back!',
                  fontSize: 26,
                  color: primary,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 8),
                TextWidget(
                  text: 'Login to explore Aurora with us',
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                ),
                const SizedBox(height: 32),
                // Email Field
                TextFieldWidget(
                  label: 'Email Address',
                  hint: 'example@email.com',
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  borderColor: primary,
                  hintColor: grey,
                  width: double.infinity,
                  height: 65,
                  radius: 12,
                  hasValidator: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password Field
                TextFieldWidget(
                  label: 'Password',
                  hint: '••••••••',
                  controller: passwordController,
                  isObscure: true,
                  showEye: true,
                  borderColor: primary,
                  hintColor: grey,
                  width: double.infinity,
                  height: 65,
                  radius: 12,
                  hasValidator: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Login Button
                ButtonWidget(
                  label: 'Login',
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    }
                  },
                  color: primary,
                  textColor: white,
                  width: double.infinity,
                  height: 55,
                  radius: 12,
                  fontSize: 18,
                ),
                const SizedBox(height: 24),
                // Divider and signup prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: "Don't have an account? ",
                      fontSize: 14,
                      color: black,
                      fontFamily: 'Regular',
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: TextWidget(
                        text: "Sign Up",
                        fontSize: 14,
                        color: secondary,
                        fontFamily: 'Bold',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
