void main() {
  Map mapAdi1 = Map();
  mapAdi1["anahtar1"] = "değer1";
  mapAdi1["anahtar2"] = "değer2";
  //mapAdi1["anahtar2"] = "değer3";
  print(mapAdi1);
  print(mapAdi1["anahtar1"]);

  ////////////////////////////////////
  Map mapAdi2 = {"anahtar1": "değer1", "anahtar2": "değer2"};
  print(mapAdi2);
  print(mapAdi2["anahtar1"]);
  mapAdi2["anahtar3"] = "değer3";
  mapAdi2["anahtarNum"] = 3;
  mapAdi2[4] = 4;
  mapAdi2["anahtar4"] = ["değer4", "değer5", "değer6"];
  print(mapAdi2);
  print(mapAdi2.length);
  print(mapAdi2.keys);
  print(mapAdi2.values);
  mapAdi2.remove("anahtar1");
  print(mapAdi2);
  mapAdi2.clear();
  print(mapAdi2);
}
