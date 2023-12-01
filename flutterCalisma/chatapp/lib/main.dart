import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Temel Mesajlaşma Uygulaması",
      home: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat App")),
      body: AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController t1 = TextEditingController();
  List<MesajBalonu> mesajListesi = [];

  mesajGonder(String metin) {
    setState(() {
      MesajBalonu mesaj = MesajBalonu(mesaj: metin); //nesne ürettik
      mesajListesi.insert(0, mesaj);
      t1.clear();
    });
  }

  Widget metinGirisAlani() {
    //mesaj yazdığımız kısım
    return Container(
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: t1,
            ),
          ),
          IconButton(
            onPressed: () => mesajGonder(t1.text),
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse:
                  true, //mesajlar aşağıdan yukarı doğru sıralanır defaultu false
              itemCount: mesajListesi.length,
              itemBuilder: (context, index) => mesajListesi[index],
            ),
          ),
          /*Row(
            //burda gönder butonu ile textfield yan yana koyduk
            children: [
              Flexible(
                child: TextField(
                  onSubmitted:
                      mesajGonder, //parametresiz fonk yazamayız parametre bekler ve enter basınca gönderiyor
                  controller: t1,
                ),
              ),
              ElevatedButton(
                onPressed: () => mesajGonder(t1.text),
                child: Text("Gönder"),
              ),
            ],
          ),*/
          Divider(
            thickness: 1,
          ),
          metinGirisAlani(),
        ],
      ),
    );
  }
}

String isim = "Anan";

class MesajBalonu extends StatelessWidget {
  var mesaj;
  MesajBalonu({required this.mesaj}); //constructor
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            child: Text(isim[0]),
          ), //profil resmi olarak ismin 0.indexini yazacak
          Column(
            children: [
              Text(isim),
              Text(mesaj),
            ],
          ),
        ],
      ),
    );
  }
}
