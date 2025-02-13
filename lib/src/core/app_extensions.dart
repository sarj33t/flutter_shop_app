///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message :
///
extension CapitalizeInitialChar on String {
  String capitalizeEachWord() {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((word) =>
      word.isNotEmpty? '${word[0].toUpperCase()}${word.substring(1)}' : '')
      .join(' ');
  }
}