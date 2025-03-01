import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop_app/src/services/database_service.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 27/02/25
/// @Message : [BaseService]
///
abstract class BaseService {
  String collectionName();

  CollectionReference reference(String reference) {
    return DatabaseService.instance.firestore.collection(reference);
  }
}
