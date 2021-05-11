class AiDTO {

  int days = 0;
  int percent = 0;



  //1. A 거래일 하락시 구매
  bool ifdayDown = false;
  void onIfdayDown(int days)
  {
      ifdayDown = true;
      this.days = days;
  }

  //2. A 거래일 상승시 구매
  bool ifdayUp = false;
  void onIfdayUp(int days)
  {
      ifdayUp = true;
      this.days = days;
  }

  //3. A거래일 합산 퍼센트 B이하일때 구매
  bool ifDayPercentDown = false;
  void onIfDayPercentDown(int days, int percent)
  {
      ifDayPercentDown = true;
      this.days = days;
      this.percent = percent;
  }

 
 
}
