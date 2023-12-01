import 'package:flutter/material.dart';

void main() => runApp(MyApp()); // Uygulamanın başlangıç noktası.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp, material tasarım kütüphanesini uygulama genelinde kullanılabilir yapar.
    return MaterialApp(
      home: GirisEkrani(), // GirişEkrani widget'ını ana ekran olarak ayarlar.
    );
  }
}

class GirisEkrani extends StatefulWidget {
  // Durumlu bir widget olduğu için StatefulWidget.
  @override
  _GirisEkraniState createState() =>
      _GirisEkraniState(); // State nesnesini oluşturur.
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 =
      TextEditingController(); // Kullanıcı adını kontrol etmek için.
  TextEditingController t2 =
      TextEditingController(); // Şifreyi kontrol etmek için.

  // Giriş yapma işlevselliğini tanımlar.
  girisYap() {
    // t1 ve t2 kontrolleri ile girilen kullanıcı adı ve şifreyi kontrol eder.
    if (t1.text == "admin" && t2.text == "1234") {
      // Doğruysa, ProfilEkrani'na yönlendirir.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilEkrani(
            kullaniciAdi: t1.text,
            sifre: t2.text,
          ),
        ),
      );
    } else {
      // Yanlışsa, hata mesajını bir AlertDialog ile gösterir.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Yanlış kullanıcı adı veya şifre"),
            content: Text("Lütfen giriş bilgilerinizi gözden geçirin."),
            actions: <Widget>[
              TextButton(
                // [FlatButton] kullanımı deprecated olduğu için [TextButton] kullanıldı.
                child: Text("Kapat"),
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog penceresini kapatır.
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
      // Temel görsel iskeleti oluşturur.
      appBar: AppBar(title: Text("Giriş Ekrani")),
      body: Container(
        margin: EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Kullanıcı Adı"),
              controller:
                  t1, // t1 controller'ını bu text field ile ilişkilendirir.
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Şifre"),
              controller:
                  t2, // t2 controller'ını bu text field ile ilişkilendirir.
            ),
            ElevatedButton(
                // [RaisedButton] kullanımı deprecated olduğu için [ElevatedButton] kullanıldı.
                onPressed: () {
                  girisYap(); // Butona basıldığında girisYap fonksiyonunu çağırır.
                },
                child: Text("Giriş Yap")),
          ],
        ),
      ),
    );
  }
}

class ProfilEkrani extends StatefulWidget {
  final String kullaniciAdi,
      sifre; // Final değişkenler ve constructor parametreleri.
  const ProfilEkrani({required this.kullaniciAdi, required this.sifre});

  @override
  _ProfilEkraniState createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  cikisYap() {
    Navigator.pop(
        context); // Profil ekranından çıkış yapar, önceki ekrana döner.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: cikisYap, // Çıkış yapma fonksiyonunu çağırır.
              child: Text("Çıkış Yap"),
            ),
            // Kullanıcı adı ve şifreyi ekranda gösterir.
            Text("Kullanıcı Adınız: ${widget.kullaniciAdi}"),
            Text("Şifreniz: ${widget.sifre}"),
          ],
        ),
      ),
    );
  }
}
