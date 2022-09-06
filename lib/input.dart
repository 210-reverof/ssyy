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
            const Text('방명록을 자유롭게 적어주세요', style: TextStyle(fontSize: 30)),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 700,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color.fromARGB(255, 167, 167, 167),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    style: TextStyle(fontSize: 20.0),
                    controller: myController,
                    decoration: new InputDecoration.collapsed(
                        hintText: 'ex. 오늘 전시 너무 멋있는 것 같아요!'),
                    keyboardType: TextInputType.multiline,
                    maxLines: null),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                DocumentReference docRef = await firestore
                    .collection('messeges')
                    .add({
                  'date': DateTime.now(),
                  'text': myController.text,
                  'docId': ""
                });

                firestore
                    .collection('messeges')
                    .doc(docRef.id)
                    .set({'docId': docRef.id}, SetOptions(merge: true));

                myController.clear();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('등록하기', style: TextStyle(fontSize: 20)),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 70, 70, 70),
              ),
            )
          ],
        ),
      ),
    );
  }
}
