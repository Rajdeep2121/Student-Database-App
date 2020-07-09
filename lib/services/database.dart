import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/models/item.dart';
import 'package:login/models/user.dart';

class DatabaseService {
  final String uid;
  final CollectionReference newCollection =
      Firestore.instance.collection('items');
  DatabaseService({this.uid});

  Future updateUserData(String item, String count) async {
    return await newCollection.document(uid).setData({
      'item': item,
      'count': count,
    });
  }

  List<Item> _itemListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Item(
        item: doc.data['item'] ?? '',
        count: doc.data['count'] ?? '0',
      );
    }).toList();
  }

  UserData _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.data['uid'],
      item: snapshot.data['item'],
      count: snapshot.data['count'],
    );
  }

  Stream<List<Item>> get items {
    return newCollection.snapshots().map(_itemListfromSnapshot);
  }

  Stream<UserData> get userData {
    return newCollection.document(uid).snapshots().map(_userDatafromSnapshot);
  }
}
