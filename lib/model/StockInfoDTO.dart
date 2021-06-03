//2021.06.02
//박해나 작성
//선택한 종목의 상세 데이터 DTO
class StockInfoDTO {
  String code; //CODe
  String type; //KOSPI, KOSDAQ
  String name; //기업명
  String price; //종가
  String updownprc; //등락액
  String updownper; //퍼센트
  String tddOpnprc; //시가
  String tddHgprc; //고가
  String tddLwprc; //저가
  String wk52HgstPrc; //52주 종가 최고
  String wk52LwstPrc; //52주 종가 최저
  String sbPrc; //대용가
  String accTrdvol; //거래량(주)
  String accTrdval; //거래대금(원)
  String mktcap; //시가총액(백만원)
  String fornRto; //외국인비율
  String perPbr; //ER/PBR
  String divYd; //배당수익률

  StockInfoDTO(
      {this.code,
      this.type,
      this.name,
      this.price,
      this.updownprc,
      this.updownper,
      this.tddOpnprc,
      this.tddHgprc,
      this.tddLwprc,
      this.wk52HgstPrc,
      this.wk52LwstPrc,
      this.sbPrc,
      this.accTrdvol,
      this.accTrdval,
      this.mktcap,
      this.fornRto,
      this.perPbr,
      this.divYd});
} //주식상세정보

StockInfoDTO dummyCreate() {
  StockInfoDTO dummy = new StockInfoDTO();
  dummy.code = "009540";
  dummy.type = "KOSPI";
  dummy.name = "한국조선해양";
  dummy.price = "149500";
  dummy.updownprc = "▲550";
  dummy.updownper = "+0.34";
  dummy.tddOpnprc = "149500";
  dummy.tddHgprc = "150000";
  dummy.tddLwprc = "146000";
  dummy.wk52HgstPrc = "160500";
  dummy.wk52LwstPrc = "77700";
  dummy.sbPrc = "113240";
  dummy.accTrdvol = "363231";
  dummy.accTrdval = "53830665000";
  dummy.mktcap = "10580581";
  dummy.fornRto = "18.16";
  dummy.perPbr = "-/0.97";
  dummy.divYd = "0.00";

  return dummy;
}
