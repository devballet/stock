//import 'dart:html';

class StockValueDTO {
  String code;
  String date;
  String open;
  String high;
  String low;
  String close;
  String valume;
  String value;
  String percent;



  bool isSelected = false;

  bool isBuy1 = false;
  int buyValue;
  String currentPercent; //수익률
  /// Just for debugging, so we get something useful in the console.
  
  StockValueDTO Clone()
  {
    StockValueDTO item = new StockValueDTO();
    item.code = this.code;
    item.date = this.date;
    item.open = this.open;
    item.high = this.high;
    item.low = this.low;
    item.close = this.close;
    item.valume = this.valume;
    item.value = this.value;
    item.percent = this.percent;

    return item;
  }

  StockValueDTO();
  
} /* End class. */