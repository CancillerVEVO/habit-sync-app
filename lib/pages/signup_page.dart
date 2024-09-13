import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habit_sync_frontend/main.dart';
import 'package:habit_sync_frontend/pages/dashboard_page.dart';
import 'package:habit_sync_frontend/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _formKey = GlobalKey<FormState>();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Variables

  bool _isLoading = false;
  bool _redirecting = false;
  bool _isObscured = true;

  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _confirmPasswordController =
      TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signUp() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      if (mounted) {
        context.showSnackBar('Auth succeeded!');
      }
    } on AuthException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar("Unexpected error occured", isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _emailValidation() {
    if (_emailController.text.isEmpty) {
      emailFocusNode.requestFocus();
      return 'Please enter some text';
    }

    if (!_emailController.text.contains('@')) {
      emailFocusNode.requestFocus();
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidation() {
    if (_passwordController.text.isEmpty) {
      passwordFocusNode.requestFocus();
      return 'Please enter some text';
    }

    if (_passwordController.text.length < 6) {
      passwordFocusNode.requestFocus();
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? confirmPasswordValidation() {
    if (_confirmPasswordController.text.isEmpty) {
      confirmPasswordFocusNode.requestFocus();
      return 'Please enter some text';
    }

    if (_confirmPasswordController.text != _passwordController.text) {
      confirmPasswordFocusNode.requestFocus();
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      }
    }, onError: (error) {
      if (error is AuthException) {
        context.showSnackBar(error.message, isError: true);
      } else {
        context.showSnackBar("Unexpected error occurred", isError: true);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // email form field
                TextFormField(
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    return _emailValidation();
                  },
                ),
                // password form field
                TextFormField(
                  obscureText: _isObscured,
                  focusNode: passwordFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        icon: _isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      )),
                  validator: (value) {
                    return passwordValidation();
                  },
                ),
                TextFormField(
                  obscureText: _isObscured,
                  focusNode: confirmPasswordFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Re-enter Password',
                    prefixIcon: Padding(padding: EdgeInsets.all(12)),
                  ),
                  validator: (value) {
                    return confirmPasswordValidation();
                  },
                ),

                const SizedBox(
                  height: 18,
                ),
                // sign up button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signUp();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text(
                    _isLoading ? 'Sending...' : 'Sign Up',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text("Alredy have an account?"))
              ],
            )),
      ),
    );
  }
}
