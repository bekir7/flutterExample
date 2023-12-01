void main() {
  ArabaTasarimi araba = ArabaTasarimi("beyaz", 1111, "çalışıyor");
  print(araba.renk);
  print(araba.uretimYili);

  var araba2 = ArabaTasarimi.ikinciMetot();
}

class ArabaTasarimi {
  String? renk;
  int? uretimYili;
  String? silecekDurumu;

  ArabaTasarimi(this.renk, this.uretimYili, this.silecekDurumu) {
    print("$renk Arabanın silecekleri $silecekDurumu");
  } //diğer constructor kullanım şekli

  ArabaTasarimi.ikinciMetot() {
    print("ikinci constructor çalıştı");
  }

  ArabaTasarimi.ucuncuMetot(String boya, int modelYili) {
    //this. yerine yazılabilir.ama gereksiz

    renk = boya;
    uretimYili = modelYili;
  }
}
