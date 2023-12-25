import 'package:flutter/material.dart';
import './home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final signupFormKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final passWordController = TextEditingController();
    final confirmPassWordController = TextEditingController();

    bool isEmailValid(String email) {
      // Define a regular expression for a valid email address
      final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );

      // Use the `hasMatch` method to check if the email matches the regex pattern
      return emailRegex.hasMatch(email);
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[200],
      //   foregroundColor: Colors.black87,
      // ),
      body: Center(
        child: Form(
          key: signupFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 36),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 12, top: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }

                        if (!isEmailValid(value)) {
                          return 'Invalid email format. example: john@doe.com';
                        }

                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Email'),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }

                        return null;
                      },
                      obscureText: true,
                      controller: passWordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Password'),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    child: TextFormField(
                      validator: (value) {
                        if (value != passWordController.text) {
                          return 'Password do not match. Please make sure they are the same.';
                        }

                        return null;
                      },
                      obscureText: true,
                      controller: confirmPassWordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Confirm Password'),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 44))),
                    onPressed: () {
                      if (signupFormKey.currentState!.validate()) {
                        // call api POST /login
                        var title = emailController.text;
                        var location = "Bangkok, Thailand";

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home(title: title, location: location)));
                      }
                    },
                    child: const Text('Create Account'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Login',
                            style: TextStyle(
                                decoration: TextDecoration.underline)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
