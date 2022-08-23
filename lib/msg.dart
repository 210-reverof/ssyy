import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  // 필드
  late String text;
  late Timestamp date;

  // 생성자
  Msg({
    required this.text,
    required this.date,
  });

  // firebase docs를 매개변수로 받아서 새로운 Trash 객체를 반환하는 메서드
  factory Msg.fromDocumnet(DocumentSnapshot doc) {
    Map? getDocs = doc.data() as Map?;
    return Msg(
      text: getDocs!["text"],
      date: getDocs["date"],
    );
  }
}
