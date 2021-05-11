enum ResultState {
  confirm,
  cancel,
  yes,
  no,
}


class ResultData{
  String _resultString;
  String _resultString2;
  String _resultString3;
  String _resultString4;
  String _resultString5;
  Object _resultObject;
  ResultState _resultState;

  String get resultString => _resultString;

  set resultString(String resultString) {
    _resultString = resultString;
  }

  String get resultString2 => _resultString2;

  set resultString2(String resultString2) {
    _resultString2 = resultString2;
  }

  String get resultString3 => _resultString3;

  set resultString3(String resultString3) {
    _resultString3 = resultString3;
  }

  String get resultString4 => _resultString4;

  set resultString4(String resultString4) {
    _resultString4 = resultString4;
  }

  String get resultString5 => _resultString5;

  set resultString5(String resultString5) {
    _resultString5 = resultString5;
  }

  Object get resultObject => _resultObject;

  set resultObject(Object resultObject) {
    _resultObject = resultObject;
  }

  ResultState get resultState => _resultState;

  set resultState(ResultState resultState) {
    _resultState = resultState;
  }


}