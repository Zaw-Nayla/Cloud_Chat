import 'dart:html';

import 'package:flutter/material.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 170,
              width: 270,
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  // color: Colors.amber,
                  image: DecorationImage(image: AssetImage('images/Text.png'))),
            ),
            const Text('Cloud Chat',
                style: TextStyle(
                    fontSize: 27,
                    fontFamily: 'Libre',
                    color: Color.fromARGB(255, 0, 0, 0),
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                        color: Color.fromARGB(157, 9, 237, 176),
                      ),
                    ])),
            const SizedBox(
              height: 100,
            ),
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/login');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: const Color.fromARGB(157, 9, 237, 176),
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      elevation: 10,
                    ),
                    child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Get Started ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
