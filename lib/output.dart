import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ssyy/msg.dart';

class OutputPage extends StatefulWidget {
  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/output_banner.png'),
                          fit: BoxFit.fill))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              // 리스트뷰
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                margin: const EdgeInsets.all(20),
                child: _buildBody(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messeges').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          return _buildList(context, snapshot.data!.docs);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final currTrash = Msg.fromDocumnet(data);
    DateTime currTime = currTrash.date.toDate();
    String timeString = DateFormat('MM-dd kk:mm').format(currTime);
    double tileWidth = MediaQuery.of(context).size.width * 0.8;
    double tileHeight = MediaQuery.of(context).size.height * 0.08;

    return GestureDetector(
      onDoubleTap: () {
        deleteTile(data.get("docId"));
      },
      child: Container(
        width: tileWidth,
        height: tileHeight,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1.0, color: new Color(0xffafabab)),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: tileWidth * 0.8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(currTrash.text),
              ),
            ),
            Container(
              width: tileWidth * 0.2,
              child: Center(
                child: Text(timeString,
                    style: TextStyle(color: new Color(0xffafabab))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTile(String docId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('messeges').doc(docId).delete();
  }
}
