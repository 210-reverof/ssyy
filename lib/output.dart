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
            // 리스트뷰
            Container(
              color: Colors.white,
              width: 500,
              height: 550,
              margin: const EdgeInsets.all(20),
              child: _buildBody(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        //동적 데이터 활용을 위해 스트림 형성
        stream: FirebaseFirestore.instance.collection('messeges').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          return _buildList(context, snapshot.data!.docs); //리스트뷰 생성 함수(생성자) 호출
        });
  }

  //쿼리문 스냅샷 문서를 인자로 갖고 리스트뷰를 반환하는 함수
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: snapshot
          .map((data) => _buildListItem(context, data))
          .toList(), //문서마다 리스트뷰_타일 생성 함수(생성자) 호출
    );
  }

  //각 문서의 데이터를 인자로 갖고 리스트뷰_타일(각 사각항목)을 반환하는 함수
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final currTrash = Msg.fromDocumnet(data);
    DateTime currTime = currTrash.date.toDate();
    String timeString = DateFormat('MM-dd kk:mm').format(currTime);

    // 리스트뷰 한 칸 꾸미기
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: new Color(0xffafabab)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(currTrash.text),
          SizedBox(width: 100),
          Text(timeString, style: TextStyle(color: new Color(0xffafabab))),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
