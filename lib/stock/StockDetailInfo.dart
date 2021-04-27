import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel, stockModel;

class StockDetailInfo extends StatelessWidget {
  //const StockDetailInfo({Key key}) : super(key: key);
  StockDetailInfo() {}

  // InitData(){
  //   if ( stockModel != null && stockModel.selectedDTO != null)
  //   {
  //     StockDTO selectedDTO = stockModel.selectedDTO;
  //     selectedDTO.name;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StockModel>(
      model: stockModel,
      child: ScopedModelDescendant<StockModel>(
        builder: (BuildContext inContext, Widget inChild, StockModel inModel) {
          if (inModel.selectedDTO == null) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return Container(
              //color: Colors.black38,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          
                          alignment: FractionalOffset.center,
                          child: Text(
                            inModel.selectedDTO.name,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  Expanded(
                        child: Align(
                          
                          alignment: FractionalOffset.center,
                          child: Text(
                            inModel.selectedDTO.code,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
