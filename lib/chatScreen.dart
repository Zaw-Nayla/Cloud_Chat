import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
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
    super.initState();
    loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C-C'),
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
      body: const Center(
        child: Text('reached'),
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
                      Navigator.pop(context, '/');
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
