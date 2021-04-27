import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stock/core/widgets.dart';
import 'package:stock/model/NoteDTO.dart';
import 'package:stock/model/StockDTO.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock/model/StockModel.dart' show StockModel, stockModel;

class StockDetailNoti extends StatelessWidget {
  //const StockDetailInfo({Key key}) : super(key: key);
  StockDetailNoti() {
    _noteEditingController.addListener(() {
      //stockModel.entityBeingEdited.title = _titleEditingController.text;
    });
  }
  final TextEditingController _noteEditingController =
      new TextEditingController();
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
              //color: Colors.pink,
              child: Card(
                elevation: 2,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: inModel.notiList.length,
                          itemBuilder: (BuildContext inContext, int i) {
                            NoteDTO note = inModel.notiList.elementAt(i);

                            Color color = Colors.white;
                            switch (note.color) {
                              case "red":
                                color = Colors.red;
                                break;
                              case "green":
                                color = Colors.green;
                                break;
                              case "blue":
                                color = Colors.blue;
                                break;
                              case "yellow":
                                color = Colors.yellow;
                                break;
                              case "grey":
                                color = Colors.grey;
                                break;
                              case "purple":
                                color = Colors.purple;
                                break;
                            }

                            String title = note.title == null ? "" : note.title;
                            String contents =
                                note.content == null ? "" : note.content;

                            return Container(
                              child: Slidable(
                                direction: Axis.vertical,
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                // secondaryActions: [
                                //   IconSlideAction(
                                //       caption: "Delete",
                                //       color: Colors.red,
                                //       icon: Icons.delete,
                                //       //onTap: () => _deleteNote(inContext, note)
                                //       )
                                // ],
                                child: Container(
                                  child: Card(
                                    elevation: 1,
                                    color: Colors.white30,
                                    child: Container(
                                      width: 70,
                                      margin : EdgeInsets.only(left: 5, right: 5, top: 2),
                                      height: 25,
                                      child: Text(contents)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        //color: Colors.red,
                        height: 30,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: "내용을 입력하세요."),
                                  controller: _noteEditingController,
                                  validator: (String inValue) {
                                    if (inValue.length == 0) {
                                      return "내용을 입력하세요.";
                                    }
                                    return null;
                                  }),
                            ),
                            SizedBox(width: 10,),
                            // RaisedButton(
                            //   child: Text("입력"),
                            //   onPressed: () {
                            //     //키보드를 감춘다.
                            //     FocusScope.of(inContext)
                            //         .requestFocus(FocusNode());
                            //     //model.setStackIndex(0);
                            //     //NoteDTO note = inModel.notiList
                            //     NoteDTO newRow = new NoteDTO();
                            //     newRow.content = _noteEditingController.text;

                            //     inModel.notiList.add(newRow);
                            //     inModel.setNoti();
                            //   },
                            // ),
                            SimpleOutlineButton(
                            buttonText: "입력",
                            isTokenIconVisible: false,
                            onPressed: () {
                              //키보드를 감춘다.
                                FocusScope.of(inContext)
                                    .requestFocus(FocusNode());
                                NoteDTO newRow = new NoteDTO();
                                newRow.content = _noteEditingController.text;

                                inModel.notiList.add(newRow);
                                inModel.setNoti();
                            },
                          ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
