import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/application/feature/call/bloc/bloc/status_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class StatusTextPage extends StatefulWidget {
  const StatusTextPage({super.key});

  @override
  State<StatusTextPage> createState() => _StatusTextPageState();
}

class _StatusTextPageState extends State<StatusTextPage> {
  User? user= FirebaseAuth.instance.currentUser;
  Color color = Colors.red;
  final datacontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<StatusBloc>(context).add(ColorPick());
              },
              icon: Icon(
                Icons.color_lens,
                size: 30,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          FirebaseFirestore.instance.collection('Status').doc(user!.uid).collection('Datas').doc().set({
            "Data":datacontroller.text,
            "color":color.toString(),
          });
          Navigator.pop(context);
        },
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<StatusBloc, StatusState>(
        listener: (context, state) {
          if (state is ColorPickState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Pick Your Color'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildColorPicker(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("SELECT"),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is ColorPickerState) {
            color = state.color;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: datacontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a status',
                    hintStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildColorPicker() {
    return ColorPicker(
      pickerColor: color,
      onColorChanged: (Color colors) {
        setState(() {
          BlocProvider.of<StatusBloc>(context)
            .add(ColorPickerEvent(color: colors));
        });
        
      },
    );
  }
}
