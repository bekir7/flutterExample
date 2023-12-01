import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo Uygulaması",
      home: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alışveriş Listesi")),
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
  List liste = [];

  listeEkle() {
    setState(() {
      liste.add(t1.text);
      t1.clear(); //metin giriş alanını temizler
    });
  }

  listeSil() {
    setState(() {
      liste.remove(t1.text);
      t1.clear(); //metin giriş alanını temizler
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Flexible(
          child: ListView.builder(
            itemCount: liste.length,
            itemBuilder: (context, indexNumarasi) => ListTile(
              subtitle: Text("Liste"),
              title: Text(liste[indexNumarasi]),
            ),
          ),
        ), //kaydırmalı liste
        TextField(
          controller: t1,
        ),
        ElevatedButton(onPressed: listeEkle, child: Text("Ekle")),
        ElevatedButton(onPressed: listeSil, child: Text("Sil"))
      ]),
    );
  }
}
