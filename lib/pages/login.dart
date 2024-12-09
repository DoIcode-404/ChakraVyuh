// import 'package:chakravyuh/pages/location.dart';
// import 'package:chakravyuh/services/location_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:chakravyuh/pages/user_profile.dart';
// import 'navigation.dart';
// import 'signUp.dart ';
// import 'dashboard.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool rememberMe = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       // Show loader dialog
//       showDialog(
//         context: context,
//         barrierDismissible: false, // Prevent dismissing the dialog
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );

//       try {
//         // Attempt to sign in
//         UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: _emailController.text,
//           password: _passwordController.text,
//         );

//         // Close the loader
//         Navigator.of(context).pop();

//         // Check if the user is authenticated
//         if (userCredential.user != null) {
//           // Redirect to the UserProfile screen
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const UserProfile()),
//           );
//         }
//       } catch (e) {
//         // Close the loader
//         Navigator.of(context).pop();

//         // Show error message if sign-in fails
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.toString()}')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
//             center: Alignment.bottomRight,
//             radius: 1,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Page Title
//                   const Text(
//                     'Welcome Back!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 31,
//                       color: Color.fromARGB(255, 126, 172, 196),
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // Subtitle
//                   const Text(
//                     'Log in to your account to access your data and enjoy personalized features',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Login Form Box
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF5D3FD3).withOpacity(0.11),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Email Field
//                         const Text(
//                           'Email',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         const SizedBox(height: 8),
//                         TextFormField(
//                           controller: _emailController,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: const Color(0xFFBCC4FF).withOpacity(0.1),
//                             hintText: 'Enter your email',
//                             hintStyle: const TextStyle(color: Colors.white70),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Email is required';
//                             }
//                             if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                                 .hasMatch(value)) {
//                               return 'Enter a valid email address';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Password Field
//                         const Text(
//                           'Password',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         const SizedBox(height: 8),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: true,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: const Color(0xFFBCC4FF).withOpacity(0.1),
//                             hintText: 'Enter your password',
//                             hintStyle: const TextStyle(color: Colors.white70),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Password is required';
//                             }
//                             if (value.length < 6) {
//                               return 'Password must be at least 6 characters';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Remember Me
//                         Row(
//                           children: [
//                             Checkbox(
//                               value: rememberMe,
//                               onChanged: (value) {
//                                 setState(() {
//                                   rememberMe = value!;
//                                 });
//                               },
//                               activeColor: Colors.blue,
//                             ),
//                             const Expanded(
//                               child: Text(
//                                 'Remember me',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Login Button
//                   ElevatedButton(
//                     onPressed: _login,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 27, 61, 88),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 23,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),

//                   // Continue Without Login
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const Navigation()),
//                       ); // Handle continue without login action
//                     },
//                     child: const Text(
//                       'Continue without login',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // Don't have an account? Signup
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account?",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Signup()),
//                           );
//                         },
//                         child: const Text(
//                           'Signup',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:chakravyuh/pages/location.dart';
import 'package:chakravyuh/services/location_service.dart';
import 'package:chakravyuh/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chakravyuh/pages/user_profile.dart';
import 'navigation.dart';
import 'signUp.dart ';
import 'dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;

  final userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  // Load saved credentials from shared preferences
  _loadRememberedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');
    bool savedRememberMe = prefs.getBool('rememberMe') ?? false;

    if (savedRememberMe && savedEmail != null && savedPassword != null) {
      setState(() {
        _emailController.text = savedEmail;
        _passwordController.text = savedPassword;
        rememberMe = savedRememberMe;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Show loader dialog
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing the dialog
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        // Attempt to sign in
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Save credentials if "Remember Me" is checked
        if (rememberMe) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _emailController.text);
          prefs.setString('password', _passwordController.text);
          prefs.setBool('rememberMe', true);
        } else {
          // Clear saved credentials if "Remember Me" is unchecked
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('email');
          prefs.remove('password');
          prefs.remove('rememberMe');
        }

        // Close the loader
        Navigator.of(context).pop();

        // Check if the user is authenticated
        if (userCredential.user != null) {
          // Redirect to the UserProfile screen
          userService.onLoginSuccess(context);
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      } catch (e) {
        // Close the loader
        Navigator.of(context).pop();

        // Show error message if sign-in fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
            center: Alignment.bottomRight,
            radius: 1,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Page Title
                  const Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 31,
                      color: Color.fromARGB(255, 126, 172, 196),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  const Text(
                    'Log in to your account to access your data and enjoy personalized features',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Form Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5D3FD3).withOpacity(0.11),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email Field
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFBCC4FF).withOpacity(0.1),
                            hintText: 'Enter your email',
                            hintStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFBCC4FF).withOpacity(0.1),
                            hintText: 'Enter your password',
                            hintStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Remember Me
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                            const Expanded(
                              child: Text(
                                'Remember me',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    onPressed: _login,
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
                      'Login',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Continue Without Login
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Navigation()),
                      ); // Handle continue without login action
                    },
                    child: const Text(
                      'Continue without login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Don't have an account? Signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //   builder: (context) =>
                          //       Signup(updatedDetails: updatedDetails),
                          // ),
                          // );
                        },
                        child: const Text(
                          'Signup',
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
