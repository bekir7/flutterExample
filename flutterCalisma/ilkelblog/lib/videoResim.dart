import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoResim extends StatelessWidget {
  const VideoResim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ButonEkrani(),
    );
  }
}

class ButonEkrani extends StatefulWidget {
  const ButonEkrani({super.key});

  @override
  State<ButonEkrani> createState() => _ButonEkraniState();
}

class _ButonEkraniState extends State<ButonEkrani> {
  File? yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? indirmeBaglantisi;
  final ImagePicker picker = ImagePicker();
  kameradanVideoYukle() async {
    final XFile? cameraVideo =
        await picker.pickVideo(source: ImageSource.camera);
    setState(() {
      if (cameraVideo != null) {
        yuklenecekDosya = File(cameraVideo!.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
            const SnackBar(content: Text('Nothing is selected')));
      }
    });

    Reference referansYol = FirebaseStorage.instance
        .ref()
        .child("videolar")
        .child(auth.currentUser!.uid)
        .child("video.mp4");
    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya!);
    String url = await (await yuklemeGorevi).ref.getDownloadURL();
    setState(() {
      indirmeBaglantisi = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: kameradanVideoYukle, child: Text("Video Yükle"))
        ],
      ),
    );
  }
}
