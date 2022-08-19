import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  TextEditingController massagecontroller = TextEditingController();

  bool submitted = false;
  bool istexted = false;

  final _formKey = GlobalKey<FormState>();

  void loginCheck() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushNamed(context, '/');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void initState() {
    massagecontroller.addListener(() {
      if (massagecontroller.text.isNotEmpty) {
        setState(() {
          istexted = true;
        });
      } else {
        setState(() {
          istexted = false;
        });
      }
    });

    loginCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'chats',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Libre',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return const LogoutDialog();
                    }));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    controller: massagecontroller,
                    autovalidateMode: AutovalidateMode.always,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.grey,
                        hintText: 'Enter a massage'),
                  ),
                ),
              ),
              istexted
                  ? IconButton(
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser;
                        String? username = user?.displayName;
                        print(username);

                        FirebaseFirestore.instance.collection('cloud_msg').add({
                          'sender': user!.email,
                          'text': massagecontroller.text,
                          'group': 'class_8'
                        });
                      },
                      icon: const Icon(Icons.send))
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up),
                    ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: ListView(
                    children: [
                      Chat(
                        text: 'How was the concert?',
                        isCurrentUser: false,
                      ),
                      Chat(
                        text: 'Awesome! Next time you gotta come as well!',
                        isCurrentUser: true,
                      ),
                      Chat(
                        text: 'Ok, when is the next date?',
                        isCurrentUser: false,
                      ),
                      Chat(
                        text: 'They\'re playing on the 20th of November',
                        isCurrentUser: true,
                      ),
                      Chat(
                        text: 'Let\'s do it!',
                        isCurrentUser: false,
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: Container(
                //         alignment: Alignment.centerLeft,
                //         height: 40,
                //         width: MediaQuery.of(context).size.width * 0.5,
                //         child: TextFormField(
                //           controller: massagecontroller,
                //           autovalidateMode: AutovalidateMode.always,
                //           cursorColor: Colors.black,
                //           decoration: InputDecoration(
                //               errorBorder: OutlineInputBorder(
                //                 borderSide: const BorderSide(
                //                     width: 1, color: Colors.redAccent),
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //               focusedBorder: OutlineInputBorder(
                //                   borderSide:
                //                       const BorderSide(color: Colors.grey),
                //                   borderRadius: BorderRadius.circular(15)),
                //               enabledBorder: OutlineInputBorder(
                //                   borderSide:
                //                       const BorderSide(color: Colors.grey),
                //                   borderRadius: BorderRadius.circular(15)),
                //               filled: true,
                //               fillColor: Colors.grey,
                //               hintText: 'Enter a massage'),
                //         ),
                //       ),
                //     ),
                //     istexted
                //         ? IconButton(
                //             onPressed: () {
                //               final user = FirebaseAuth.instance.currentUser;
                //               String? username = user?.displayName;
                //               print(username);

                //               FirebaseFirestore.instance
                //                   .collection('cloud_msg')
                //                   .add({
                //                 'sender': user!.email,
                //                 'text': massagecontroller.text,
                //                 'group': 'class_8'
                //               });
                //             },
                //             icon: const Icon(Icons.send))
                //         : IconButton(
                //             onPressed: () {},
                //             icon: Icon(Icons.thumb_up),
                //           ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        width: 300,
        decoration: BoxDecoration(
            color: const Color.fromARGB(239, 253, 253, 253),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('images/Log-out.png'))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Are you Sure?',
                style: TextStyle(fontFamily: 'Libre', fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                    ),
                    child: const Text('Sure')),
                const SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(226, 253, 253, 253),
                      padding: const EdgeInsets.all(8),
                    ),
                    child: const Text(
                      'Nope',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Chat extends StatelessWidget {
  String text;
  bool isCurrentUser;
  Chat({Key? key, required this.text, required this.isCurrentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(isCurrentUser ? 'username' : 'membername'),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.greenAccent : Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
