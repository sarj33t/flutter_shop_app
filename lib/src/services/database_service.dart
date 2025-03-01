import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 27/02/25
/// @Message : [DatabaseService]
///
class DatabaseService {
  static final DatabaseService _singleton = DatabaseService._();
  DatabaseService._();
  static DatabaseService get instance => _singleton;

  late final FirebaseFirestore firestore;

  // Init Firestore
  void init(FirebaseApp app) {
    firestore = FirebaseFirestore.instanceFor(
      app: app,
    );
    FirebaseFirestore.setLoggingEnabled(true);
  }
}
