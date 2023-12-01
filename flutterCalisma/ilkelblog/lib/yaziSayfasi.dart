import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ilkelblog/main.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YaziEkran extends StatefulWidget {
  const YaziEkran();
  @override
  State<YaziEkran> createState() => _YaziEkranState();
}

class _YaziEkranState extends State<YaziEkran> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  yaziEkle() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).set({
      'kullaniciid': auth.currentUser?.uid,
      'baslik': t1.text,
      'icerik': t2.text
    }).whenComplete(() => print("Yazı eklendi"));
  }

  yaziGuncelle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .update({'baslik': t1.text, 'icerik': t2.text}).whenComplete(
            () => print("Yazı güncellendi"));
  }

  yaziSil() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).delete();
  }

  yaziGetir() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziBasligi = gelenVeri.data()!['baslik'];
        gelenYaziIcerigi = gelenVeri.data()!['icerik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Uygulaması"),
      ),
      body: Container(
        margin: EdgeInsets.all(50), //boşluk verirken kullandığımız parametre
        child: Center(
            child: Column(
          children: [
            TextField(
              controller: t1,
            ),
            TextField(
              controller: t2,
            ),
            Row(
              children: [
                ElevatedButton(onPressed: yaziEkle, child: Text("Ekle")),
                ElevatedButton(
                    onPressed: yaziGuncelle, child: Text("Güncelle")),
                ElevatedButton(onPressed: yaziSil, child: Text("Sil")),
                ElevatedButton(onPressed: yaziGetir, child: Text("Getir")),
              ],
            ),
            ListTile(
              title: Text(gelenYaziBasligi),
              subtitle: Text(gelenYaziIcerigi),
            ),
          ],
        )),
      ),
    );
  }
}
