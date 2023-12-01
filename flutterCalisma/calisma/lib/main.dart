import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Uygulama", //başlık

      home: Body(), //Material Appte başka widget çağırmak için home kullanılır
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ekran
      appBar: AppBar(
        title: Text("BABAN"),
        foregroundColor: Colors.deepOrange,
        backgroundColor: Colors.amber,
      ),
      body: AnaEkran(), //Scaffold başka widget çağırmak için body kullanılır
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  //State kısmı ekranın durumunu tutan kısım

  String blogYazisi = "ANAN'A Hoşgeldin";

  AnanGoster() {
    setState(() {
      //statein durumunu değiştirir
      blogYazisi = "Anana Bastık";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // eksen hizalaması
          children: <Widget>[
            Text(blogYazisi),
            ElevatedButton(
              onPressed: AnanGoster,
              child: Text("Anana Bas"),
            ),
          ],
        ),
      ),
    );
  }
}
