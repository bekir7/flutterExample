import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/", //başlangıç ekranını belirlememizi sağlıyor
      routes: {
        "/": (context) => GirisEkrani(),
        "/ProfilSayfasi": (context) => ProfilEkrani(),
      },
    );
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController(); //kullanıcı adı
  TextEditingController t2 = TextEditingController(); //şifre

  girisYap() {
    if (t1.text == "admin" && t2.text == "1234") {
      Navigator.pushNamed(
          context, "/ProfilSayfasi", //profil sayfasına yönlendiriyor
          arguments: VeriModeli(
              //veri aktarımı
              kullaniciAdi: t1.text,
              sifre: t2.text));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Yanlış kullanıcı adı veya şifre"), // 'new' kelimesi gereksiz ve eski Dart sürümlerinden kalma. Artık kullanılmıyor.
            content: Text(
                "Lütfen giriş bilgilerinizi gözden geçirin."), // 'const' kullanımı performans için önerilir fakat şart değil.
            actions: [
              // 'FlatButton' kullanımı eskidi, 'TextButton' kullanılmalı.
              TextButton(
                child: Text("Kapat"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Giriş Ekranı")),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(100),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Kullanıcı Adı"),
                controller: t1,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Şifre"),
                controller: t2,
              ),
              ElevatedButton(onPressed: girisYap, child: Text("Giriş Yap")),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});

  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  cikisYap() {
    Navigator.pop(context, "/"); //son açılan ekranı kapatır
  }

  @override
  Widget build(BuildContext context) {
    final VeriModeli veri =
        ModalRoute.of(context)!.settings.arguments as VeriModeli;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Sayfası"),
      ),
      body: Container(
        child: Column(children: [
          ElevatedButton(onPressed: cikisYap, child: Text("Çıkış Yap")),
          Text(veri.kullaniciAdi!),
          Text(veri.sifre!),
        ]),
      ),
    );
  }
}

class VeriModeli {
  String? kullaniciAdi, sifre;
  VeriModeli({required this.kullaniciAdi, required this.sifre});
}
