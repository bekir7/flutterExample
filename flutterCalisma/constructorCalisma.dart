void main() {
  ArabaTasarimi araba = ArabaTasarimi("beyaz", 1111, "çalışıyor");
  print(araba.renk);
  print(araba.uretimYili);
  araba.silecekCalis();

  var araba2 = ArabaTasarimi("siyah", 2222, "çalışmıyor");
  print(araba2.renk);
  print(araba2.uretimYili);
  araba.silecekCalis();
}

class ArabaTasarimi {
  String? renk;
  int? uretimYili;
  String? silecekDurumu;
  silecekCalis() {
    print("$renk Arabanın silecekleri $silecekDurumu");
  }

  ArabaTasarimi(this.renk, this.uretimYili,
      this.silecekDurumu); //constructor ([bu şekilde yazarsak değer vermek zorunda değiliz]) [{bu şekilde karışık değer verebiliriz sıra önemli değil}]
}
