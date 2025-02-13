///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ApiResponse]
///
class ApiResponse{
  final bool status;
  final String message;
  final Object? data;

  ApiResponse({required this.message, required this.status, required this.data});
}