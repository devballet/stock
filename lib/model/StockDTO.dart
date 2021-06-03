class StockDTO {
  String code;
  String name;
  String market;
  bool isfavorite;

  /// Just for debugging, so we get something useful in the console.
  String toString() {
    return "{ code=$code, name=$name, market=$market, isfavorite=$isfavorite }";
  }

  //StockDTO();
  StockDTO({this.code, this.name, this.market, this.isfavorite});
} /* End class. */
