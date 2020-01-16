import 'package:chat_online/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(MyApp());

  Firestore.instance.collection('mensagens').snapshots().listen((dados){
    dados.documents.forEach((d){
      print(d.data);
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat OnLine Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
      home: ChatScreen(),
      );
  }
}

///Firestore acessa banco de dados
///.instance possui uma instância do Firestore, usa padrão singleton, qunado
///executamos .instance ele está buscando essa instância, podendo ser buscado
///de qualquer lugar do app
///.collection  pode acessar um objeto Firestore especificando qual coleção quer acessar
///no caso a coleção mensagens
///e.document especificar qual documento deseja acessar, no caso msg1
///.setData para especificar qual dado quer inserir
///recebendo sempre um map e uma chave
///a chave nesse caso é o texto :
///getdocuments faz a leitura dos documentos, que vai retornar o dado no futuro,
///por isso await Firestore e QuerySnapshot snapshot
///Se chama snapshot porque ele vai dar uma fotografia de como estão os documentos
///forEach um nome para cada documento, no caso se chama d
///QuerySnapshot é para quando quer obtera leitura de vários documentos de uma coleção
///DocumentSnapshot é para obter apenas a leitura de um documento
///documentID para saber o id do documento
/// d.reference.updateData({'lido' : false}); Atualiza a coleção mensagens e obtem os documentos
/// snapshots Sempre que algum documento mudar tem a atualização em tempo real com listen
///

/// Firestore accesses database
///.instance has a Firestore instance, uses default singleton, when
/// we run .instance he is looking for this instance and can be searched
/// from anywhere in the app
///.collection can access a Firestore object by specifying which collection it wants to access
/// in case the message collection
///e.document specify which document you want to access, in this case msg1
///.setData to specify which data to insert
/// always receiving a map and a key
/// the key in this case is the text:
/// updateData({}) Modifica apenas um determinado campo escolhido
/// getdocuments reads documents