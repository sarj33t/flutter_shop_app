///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ProductCategory]
///
class CategoryListResponse {
  String? status;
  String? message;
  List<String>? categories;

  CategoryListResponse({this.status, this.message, this.categories});

  CategoryListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    categories = json['categories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['categories'] = categories;
    return data;
  }
}

