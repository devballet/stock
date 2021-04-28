import 'dart:ui';

class MenuDTO {
  final Color color;
  final String title;
  final String url;

  MenuDTO(this.color, this.title, this.url);
}

// List<Color> themeColors = [
//   Color(0xfff39805),
//   Color(0xfff37806),
//   Color(0xff044f4d),
//   Color(0xff123b3a),
// ];
List<MenuDTO> getMenuList() {
  List<MenuDTO> list = [];
  list.add(new MenuDTO(Color(0xfff39805), '종목검색', '/search'));
  list.add(new MenuDTO(Color(0xfff37806), '모의투자', '/virtualinvestment'));
  list.add(new MenuDTO(Color(0xff044f4d), '관련뉴스모음', '/issue'));
  list.add(new MenuDTO(Color(0xff123b3a), 'AI종목', '/ai'));
  return list;
}
