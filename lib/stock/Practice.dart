import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/datatable/resultDataDTO.dart';
import 'package:stock/model/NoteDTO.dart';
import 'package:stock/model/PracticeInputDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel, stockModel;
import 'package:stock/popup/PracticeInputPopup.dart';
import 'package:stock/stock/PracticeDetailValue.dart';

class Practice extends StatelessWidget {
  //const Practice({Key key}) : super(key: key);

  PracticeDetailValue practiceDetailValue = new PracticeDetailValue();

  @override
  Widget build(BuildContext context) {
    return practiceDetailValue;
  }
}
