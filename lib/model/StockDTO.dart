class StockDTO {
  String code;
  String name;

  /// Just for debugging, so we get something useful in the console.
  String toString() {
    return "{ code=$code, name=$name }";
  }

  //StockDTO();
  StockDTO({this.code, this.name});
} /* End class. */
