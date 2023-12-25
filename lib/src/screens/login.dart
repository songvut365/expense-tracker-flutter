import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final passWordController = TextEditingController();

    bool isEmailValid(String email) {
      // Define a regular expression for a valid email address
      final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );

      // Use the `hasMatch` method to check if the email matches the regex pattern
      return emailRegex.hasMatch(email);
    }

    return Scaffold(
      body: Center(
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 36),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 12),
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
                    controller: passWordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Password'),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 44))),
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      // call api POST /login
                      var title = emailController.text;
                      var location = "Bangkok, Thailand";
                      Navigator.pushReplacementNamed(context, '/home', arguments: {
                        'title': title,
                        'location': location
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ?"),
                  TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/signup');
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign-up',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
