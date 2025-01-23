import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/viewmodel/signup_viewmodel.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpViewModel>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF57C7DB), Color(0xFF0309C8)],
          ),
        ),
        child: Stack(
          children: [
            const Positioned.fill(
              top: -200,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_icon.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create Account',
                      style: _textStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: nameController,
                      decoration: _inputDecoration('Enter your name'),
                      style: _textStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: _inputDecoration('Enter your email'),
                      style: _textStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: _inputDecoration('Enter your password'),
                      style: _textStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    if (viewModel.errorMessage != null)
                      Text(
                        viewModel.errorMessage!,
                        style: _textStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () async {
                          await viewModel.signUp(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (viewModel.errorMessage == null) {
                            context.go('/home');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: viewModel.isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                          'Sign up',
                          style: _textStyle(
                            color: const Color(0xFF0309C8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,  // Makes the button take the full width
                      child: ElevatedButton(
                        onPressed: () => context.go('/'),  // Action when the button is pressed
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),  // Rounded corners
                            side: const BorderSide(  // Apply white border
                              color: Colors.white,  // White border color
                              width: 2.0,  // Border width
                            ),
                          ),
                          backgroundColor: Colors.transparent,  // Remove the background color
                        ),
                        child: const Text(
                          'Go back',  // The text displayed on the button
                          style: TextStyle(
                            fontSize: 16,  // Text size
                            fontWeight: FontWeight.bold,  // Text weight (optional)
                            color: Colors.white,  // Text color (should be white to stand out against transparent background)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle({
    Color color = Colors.white,
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }
}
