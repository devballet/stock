import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:scoped_model/scoped_model.dart";
import 'package:stock/core/coreLibrary.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:stock/model/StockModel.dart' show StockModel, stockModel;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class StockList extends StatelessWidget {
  TextEditingController searchContrler = new TextEditingController();

  //-------------------------------------
  // function 명 : StockList
  // function desc : 생성자
  //-------------------------------------
  StockList() {}

  //-------------------------------------
  // function 명 : OnButtonClike
  // function desc : 버튼 클릭시
  //-------------------------------------
  void onButtonClike(BuildContext buildContext) async {
    stockModel.SelectComp(buildContext, "%동화%");
  }

  void onSearch(BuildContext buildContext, String searchKey) async {
    stockModel.SelectComp(buildContext, "%"+ searchKey+"%");
  }

  /*--------------------------
  // name : ShowSnackBar
  // title : 스낵바를 표시한다.
  // desc : 
  ---------------------------*/
  // void ShowSnackBar(String message) {
  //   if (this.buildContext != null) {
  //     final snackBar = SnackBar(
  //         duration: Duration(milliseconds: 1000), content: Text(message));
  //     Scaffold.of(this.buildContext).showSnackBar(snackBar);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StockModel>(
        model: stockModel,
        child: ScopedModelDescendant<StockModel>(builder:
            (BuildContext inContext, Widget inChild, StockModel inModel) {
          return Scaffold(
              bottomNavigationBar: Row(
                children: [
                  FlatButton(
                    child: Text("Save"),
                    onPressed: () {
                      onButtonClike(context);
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    child: Card(
                      //shadowColor: Colors.blue,
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 8,
                      //color: Colors.blue[100],
                      child: Container(
                        height: 60,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: TextFormField(
                          onChanged: (String value) {
                            //titlNm = value;
                          },
                          onFieldSubmitted: (String value) {
                            //firstBloc.setTitleNm(titlNm);
                            this.onSearch(context, value);
                          },
                          controller: searchContrler,
                          style: GoogleFonts.jua(
                            textStyle: TextStyle(
                                color: HexColor("#442C2E"),
                                //fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                          ),
                          textAlignVertical: TextAlignVertical.bottom,
                          textAlign: TextAlign.start,
                          //initialValue: ordrName,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: '검색',
                            hintText: '검색',

                            //prefixText: '타이틀 : ',
                            // labelStyle: TextStyle(
                            //     color: Colors.teal,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 18.0),
                          ),
                        ),
                        // color: Colors.red,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: Card(
                      shadowColor: Colors.blue,
                      color: Colors.blue[100],
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 20,
                      child: ListView.builder(
                          itemCount: stockModel.stockList.length,
                          itemBuilder:
                              (BuildContext inBuildContext, int inIndex) {
                            StockDTO row = stockModel.stockList[inIndex];

                            return Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: .25,
                                    secondaryActions: [
                                      IconSlideAction(
                                        caption: "Delete",
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        //onTap : () => _deleteNote(inContext, note)
                                      )
                                    ],
                                    child: Card(
                                        elevation: 8,
                                        color: Colors.green,
                                        child: ListTile(
                                            title: Text("${row.name}"),
                                            subtitle: Text("${row.code}"),
                                            onTap: () async {
                                              // Get the data from the database and send to the edit view.
                                              //stockModel.selectedDTO = await NotesDBWorker.db.get(note.id);
                                              //stockModel.setColor(stockModel.selectedDTO.color);
                                              stockModel.selectedDTO = row;
                                              stockModel.setStackIndex(1);
                                            }))));
                          }),
                    ),
                  )
                ],
              ));
        }));
  }
}
