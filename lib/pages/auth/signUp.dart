import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../services/user_service.dart';
import 'login.dart';
// import '../login.dart';

class Signup extends StatefulWidget {
  final BirthDetails updatedDetails;

  Signup({Key? key, required this.updatedDetails}) : super(key: key);
  // const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final UserService userService = UserService();

  bool acceptTerms = false;
  String? selectedGender;
  final List<String> genders = ['Male', 'Female', 'Other'];

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print('Signed in as: ${account.displayName}');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Color(0xFFBCC4FF).withOpacity(0.1),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _submitForm() async {
    try {
      // Sign up the user
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
      final user = userCredential.user;

      if (user != null) {
        // Save user and birth details
        userService.saveToFirestore(
          widget.updatedDetails,
          context,
          name: _nameController.text.trim(),
          gender: selectedGender?.trim() ?? '',
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
    // if (_formKey.currentState!.validate()) {
    //   if (!acceptTerms) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content: Text('Please accept the Terms and Conditions')),
    //     );
    //     return;
    //   }

    //   try {
    //     final userCredential = await _auth.createUserWithEmailAndPassword(
    //       email: _emailController.text,
    //       password: _passwordController.text,
    //     );

    //     final userId = userCredential.user?.uid;

    //     await _firestore.collection("users").doc(userId).set(
    //           FirebaseUser(
    //             email: _emailController.text,
    //             name: _nameController.text,
    //             gender: selectedGender,
    //             userId: userId ?? '',
    //           ).toMap(),
    //         );

    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('User saved successfully!')),
    //     );

    //     Navigator.pop(context);
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(e.toString())),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
            center: Alignment.center,
            radius: 0.5,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Set your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(255, 126, 172, 196),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFF5D3FD3).withOpacity(0.11),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Full Name Field
                        const Text('Name',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration(
                              'How should we address you?'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Your Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Email Field
                        const Text('Email',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration('Enter your email'),
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        const Text('Password',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration:
                              _buildInputDecoration('Set your password'),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Gender Field
                        const Text('Gender',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField(
                          value: selectedGender,
                          items: genders
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          decoration:
                              _buildInputDecoration('Select your gender'),
                          dropdownColor: Color(0xFFBCC4FF),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a gender';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Terms and Conditions
                        Row(
                          children: [
                            Checkbox(
                              value: acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  acceptTerms = value!;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                            const Flexible(
                              child: Text(
                                'I agree to the Terms and Conditions',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 27, 61, 88),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Signup',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton.icon(
                    onPressed: handleGoogleSignIn,
                    icon: Image.asset(
                      'assets/images/google.png',
                      width: 24,
                      height: 24,
                    ),
                    label: const Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
