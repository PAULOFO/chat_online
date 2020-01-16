import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text, File imgFile }) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;///Indica se está compondo um texto ou não

  void _reset(){
    _controller.clear();//Apaga o campo de texto após enviar msg
    setState(() {
      _isComposing = false;//Apaga o botão ao limpar o campo text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imgFile =
              await ImagePicker.pickImage(source: ImageSource.camera);
              if(imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            },
          ),
          Expanded(
            child: TextField(//collapsed deixa bem comprimido
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
              onChanged: (text){
                setState(() {//Se o texto não estiver vazio está compondo
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text){//Ao clicar no botão de onSubmitted chama widget.sendMessage
                widget.sendMessage(text: text);//e envia o texto pelo teclado
                _reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),//Se estiver compondo tem uma função, caso senão null
            onPressed: _isComposing ? (){
              widget.sendMessage(text : _controller.text);//envia o texto pelo IconButton
              _reset();
            } : null,//Se null desabilita o botão
          ),
        ],
      ),
    );
  }
}
