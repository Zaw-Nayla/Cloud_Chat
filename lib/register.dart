import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userregistController = TextEditingController();
  TextEditingController passwordregistController = TextEditingController();
  TextEditingController confirmpasswordregistController =
      TextEditingController();

  bool pass = true;
  bool confirmpass = true;
  bool submitted = false;
  bool isloading = false;

  final _formKey = GlobalKey<FormState>();

  final emialValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'enter a valid email address'),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/Sign Up.png'))),
                ),
                SizedBox(
                  height: 80,
                  width: 300,
                  child: TextFormField(
                    controller: userregistController,
                    autovalidateMode: submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    validator: emialValidator,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color.fromARGB(157, 9, 237, 176)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(157, 9, 237, 176)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter Your Email ',
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 300,
                  child: TextFormField(
                    controller: passwordregistController,
                    obscureText: pass,
                    autovalidateMode: submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    validator: passwordValidator,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color.fromARGB(157, 9, 237, 176)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(157, 9, 237, 176)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              pass = !pass;
                            });
                          },
                          splashRadius: 2,
                          icon: pass
                              ? const Icon(
                                  Icons.remove_red_eye,
                                  color: Color.fromARGB(163, 20, 20, 20),
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Color.fromARGB(163, 19, 18, 18),
                                )),
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 300,
                  child: TextFormField(
                    controller: confirmpasswordregistController,
                    obscureText: confirmpass,
                    autovalidateMode: submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    validator: (val) =>
                        MatchValidator(errorText: 'passwords do not match')
                            .validateMatch(val!, passwordregistController.text),
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromARGB(157, 9, 237, 176)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(157, 9, 237, 176)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10)),
                        // filled: true,
                        // fillColor: const Color.fromARGB(157, 9, 237, 176),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmpass = !confirmpass;
                              });
                            },
                            splashRadius: 2,
                            icon: confirmpass
                                ? const Icon(
                                    Icons.remove_red_eye,
                                    color: Color.fromARGB(163, 20, 20, 20),
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Color.fromARGB(163, 19, 18, 18),
                                  )),
                        hintText: 'Comfirm Your Password'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        submitted = true;
                        isloading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          final auth = FirebaseAuth.instance;

                          final newUser =
                              await auth.createUserWithEmailAndPassword(
                                  email: userregistController.text,
                                  password: passwordregistController.text);
                          print(newUser.user!.uid);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString('UserID', newUser.user!.uid);
                          setState(() {
                            isloading = false;
                            Navigator.pushNamed(context, '/login');
                            userregistController.clear();
                            passwordregistController.clear();
                          });
                        } catch (e) {
                          print('Error >>>>>>>> $e');
                          isloading = false;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(157, 9, 237, 176),
                      padding: const EdgeInsets.only(left: 120, right: 120),
                      elevation: 15,
                    ),
                    child: isloading
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                CircularProgressIndicator(color: Colors.white,
                                ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Libre',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          )),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, '/login');
                              });
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 8, 254, 4)),
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
