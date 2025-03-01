import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop_app/src/core/firebase_keys.dart';
import 'package:flutter_shop_app/src/models/api_response.dart';
import 'package:flutter_shop_app/src/services/base_service.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 27/02/25
/// @Message : [ProductService]
///
class ProductService extends BaseService {
  static final ProductService singleton = ProductService._();
  ProductService._();
  static ProductService get instance => singleton;

  DocumentSnapshot? lastDocument;
  bool hasMore = false;

  @override
  String collectionName() {
    return FirebaseKeys.products;
  }

  // Product Reference
  CollectionReference<Product> getModelReference() {
    final productRef = reference(collectionName()).withConverter<Product>(
        fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
        toFirestore: (product, _) => product.toJson());
    return productRef;
  }

  // Fetch Products
  Future<ApiResponse> getProducts() async {
    final List<Product> products = <Product>[];
    if (lastDocument == null) {
      try {
        QuerySnapshot<Product> snapshot =
            await getModelReference().orderBy('id').limit(20).get();
        lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
        products.addAll(snapshot.docs.map((doc) => doc.data()).toList());
        hasMore = products.length == 20;
        return ApiResponse(status: true, message: 'success', data: products);
      } catch (ex) {
        return ApiResponse(
          status: false,
          message: ex.toString(),
          data: null,
        );
      }
    } else {
      if (hasMore) {
        try {
          QuerySnapshot<Product> snapshot = await getModelReference()
              .orderBy('id')
              .startAfterDocument(lastDocument!)
              .limit(20)
              .get();
          lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
          products.addAll(snapshot.docs.map((doc) => doc.data()).toList());
          hasMore = products.length == 20;
          return ApiResponse(status: true, message: 'success', data: products);
        } catch (ex) {
          return ApiResponse(
            status: false,
            message: ex.toString(),
            data: null,
          );
        }
      }
      return ApiResponse(
        status: false,
        message: 'failed',
        data: null,
      );
    }
  }
}
