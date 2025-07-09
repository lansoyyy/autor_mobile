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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Placeholder
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: 'Logo',
                      fontSize: 24,
                      color: black,
                      fontFamily: 'Bold',
                      align: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Title
                TextWidget(
                  text: 'Welcome to AuTour',
                  fontSize: 28,
                  color: primary,
                  fontFamily: 'Bold',
                  align: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  text: 'Explore Aurora Province',
                  fontSize: 16,
                  color: grey,
                  fontFamily: 'Regular',
                  align: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Email Field
                TextFieldWidget(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  borderColor: primary,
                  hintColor: grey,
                  width: 300,
                  height: 65,
                  radius: 10,
                  hasValidator: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Password Field
                TextFieldWidget(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: passwordController,
                  isObscure: true,
                  showEye: true,
                  borderColor: primary,
                  hintColor: grey,
                  width: 300,
                  height: 65,
                  radius: 10,
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
                const SizedBox(height: 20),
                // Login Button
                ButtonWidget(
                  label: 'Login',
                  onPressed: () {
                    // Handle login logic here
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
                  width: 300,
                  height: 55,
                  radius: 10,
                  fontSize: 18,
                ),
                const SizedBox(height: 20),
                // Signup Text Button
                GestureDetector(
                  onTap: () {
                    // Navigate to signup screen (placeholder)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: TextWidget(
                    text: "Don't have an account? Sign Up",
                    fontSize: 16,
                    color: secondary,
                    fontFamily: 'Medium',
                    align: TextAlign.center,
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
