import 'dart:io';

import 'package:chat_online/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void _sendMessage({String text, File imgFile}) async {//Para enviar os dados p/ Firebase

    Map<String, dynamic> data = {};

    if(imgFile != null){
      StorageUploadTask task = FirebaseStorage.instance.ref().child(//.child cria pastas
        DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      StorageTaskSnapshot taskSnapshot =  await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgURL'] = url;
    }

    if(text != null) data['text'] = text;

    Firestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá'),
        centerTitle: true,
        elevation: 7,
      ),
      body: TextComposer(_sendMessage),//Sempre que escrever no campo vai
      // chamar e apertar o botão vai chamar o _sendMessage
    );
  }
}
