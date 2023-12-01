import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ilkelblog/ProfilEkran.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "İlkel Blog Uygulaması",
      home: GirisEkrani(),
    );
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 =
      TextEditingController(); // Kullanıcı adını kontrol etmek için.
  TextEditingController t2 =
      TextEditingController(); // Şifreyi kontrol etmek için.

  // Giriş yapma işlevselliğini tanımlar.
  Future<void> girisYap() async {
    // t1 ve t2 kontrolleri ile girilen kullanıcı adı ve şifreyi kontrol eder.
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: t1.text, password: t2.text);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => const ProfilEkran(
                    kullaniciAdi: '',
                    sifre: '',
                  )),
          (Route<dynamic> route) => false);
    }
    // Doğruysa, ProfilEkrani'na yönlendirir.

    // Yanlışsa, hata mesajını bir AlertDialog ile gösterir.
    on FirebaseAuthException catch (e) {
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

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc(t1.text)
          .set({"KullaniciEposta": t1.text, "KullaniciSifre": t2.text});
    });
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
            ElevatedButton(
                // [RaisedButton] kullanımı deprecated olduğu için [ElevatedButton] kullanıldı.
                onPressed: () {
                  kayitOl(); // Butona basıldığında girisYap fonksiyonunu çağırır.
                },
                child: Text("Kayıt Ol")),
          ],
        ),
      ),
    );
  }
}
