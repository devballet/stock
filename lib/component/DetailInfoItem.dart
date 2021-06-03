//2021.06.02
//박해나 작성
//Item 항목 공통 위젯으로 추출

import 'package:flutter/material.dart';

class itemInfoDTO {
  String name;
  String value;
  bool isNumber;

  itemInfoDTO({this.name, this.value, this.isNumber});
}

class DetailInfoItem extends StatefulWidget {
  final String name;
  final String value;
  final bool isNumber;
  final String fontSize;

  const DetailInfoItem(
      {Key key, this.name, this.value, this.isNumber, this.fontSize})
      : super(key: key);

  @override
  _DetailInfoItemState createState() => _DetailInfoItemState();
}

class _DetailInfoItemState extends State<DetailInfoItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                border: Border.all(color: Colors.grey.shade200),
              ),
              height: 35,
              alignment: Alignment.center,
              // color: Colors.grey.shade400,
              child: Text(widget.name),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200)),
              alignment: widget.isNumber
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Text(widget.value),
            ),
          )
        ],
      ),
    );
  }
}
