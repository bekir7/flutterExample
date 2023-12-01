import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ilkelblog/anaSayfa.dart';
import 'package:ilkelblog/main.dart';
import 'package:ilkelblog/videoPlayer.dart';
import 'package:ilkelblog/videoResim.dart';
import 'package:ilkelblog/yaziSayfasi.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilEkran extends StatefulWidget {
  final String kullaniciAdi,
      sifre; // Final değişkenler ve constructor parametreleri.
  const ProfilEkran({required this.kullaniciAdi, required this.sifre});
  @override
  State<ProfilEkran> createState() => _ProfilEkranState();
}

class _ProfilEkranState extends State<ProfilEkran> {
  cikisYap() {
    FirebaseAuth.instance.signOut().then((deger) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => GirisEkrani()),
          (Route<dynamic> route) => false);
    });
  } // Profil ekranından çıkış yapar, önceki ekrana döner.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Blog Uygulaması"), actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => VideoApp()),
                  (Route<dynamic> route) => true);
            }, // Çıkış yapma fonksiyonunu çağırır.
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: cikisYap, // Çıkış yapma fonksiyonunu çağırır.
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => VideoResim()),
                  (Route<dynamic> route) => true); //geri butonu aktif ettik
            }),
        body: Container(
            child: Column(
          children: [ProfilTasarim(), KullaniciYazilar()],
        )));
  }
}

class KullaniciYazilar extends StatefulWidget {
  @override
  _KullaniciYazilarState createState() => _KullaniciYazilarState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _KullaniciYazilarState extends State<KullaniciYazilar> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Yazilar')
      .where("kullaniciid", isEqualTo: auth.currentUser?.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['baslik']),
                subtitle: Text(data['icerik']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class ProfilTasarim extends StatefulWidget {
  const ProfilTasarim({super.key});

  @override
  State<ProfilTasarim> createState() => _ProfilTasarimState();
}

class _ProfilTasarimState extends State<ProfilTasarim> {
  late File yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? indirmeBaglantisi;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => baglantiAl());
  }

  baglantiAl() async {
    String baglanti = await FirebaseStorage.instance
        .ref()
        .child("image1")
        .child(auth.currentUser!.uid)
        .child("profilResmi.png")
        .getDownloadURL();

    setState(() {
      indirmeBaglantisi = baglanti;
    });
  }

  kameradanYukle() async {
    var alinanDosya = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya!.path);
    });

    Reference referansYol = FirebaseStorage.instance
        .ref()
        .child("resimler")
        .child(auth.currentUser!.uid)
        .child("profilResmi.png");
    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya);
    String url = await (await yuklemeGorevi).ref.getDownloadURL();
    setState(() {
      indirmeBaglantisi = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipOval(
              child: indirmeBaglantisi == null
                  ? Text("Resim Yok")
                  : Image.network(
                      indirmeBaglantisi!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )),
          ElevatedButton(onPressed: kameradanYukle, child: Text("Resim Yükle"))
        ],
      ),
    );
  }
}
