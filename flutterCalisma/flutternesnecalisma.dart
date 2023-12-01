void main() {
  ArabaTasarimi araba = ArabaTasarimi();
  print("-------------Araba1-------------");
  print(araba);
  print(araba.uretimYili);
  print(araba.renk);
  araba.renk = "mavi";
  print(araba.renk);

  var araba2 = ArabaTasarimi();
  print("-------------Araba2-------------");
  print(araba2);
  araba2.uretimYili = 1999;
  print(araba2.uretimYili);

  var araba3 = araba;
  print("-------------Araba3-------------");
  print(araba3);
  print(araba3.uretimYili);
}

class ArabaTasarimi {
  String renk = "beyaz";
  int uretimYili = 1972;

  silecekleriCalistir() {
    print("Silecekler Çalışıyor");
  }

  kapilariKilitle() {
    print("kapıları kilitli");
  }
}
