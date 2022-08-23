import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ssyy',
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color.fromARGB(255, 108, 148, 201),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: myController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                firestore
                    .collection('messeges')
                    .add({'date': DateTime.now(), 'text': myController.text});
                myController.clear();
              },
              child: Text('등록하기'),
            )
          ],
        ),
      ),
    );
  }
}
