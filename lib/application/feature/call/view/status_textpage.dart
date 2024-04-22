import 'package:chat_app/application/feature/call/bloc/bloc/status_bloc.dart';
import 'package:chat_app/application/feature/call/view/imagedisplay.dart';
import 'package:chat_app/application/feature/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class StatusTextPage extends StatefulWidget {
  final image;
  final name;
  final id;
  StatusTextPage({required this.image, required this.name, required this.id});

  @override
  State<StatusTextPage> createState() => _StatusTextPageState();
}

class _StatusTextPageState extends State<StatusTextPage> {
  bool showImage = true;
  final String camera = 'camera';
  final String addStatus = 'addstatus';
  User? user = FirebaseAuth.instance.currentUser;
  Color backgroundColor = Colors.white; // Store color in the state
  final datacontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: backround,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<StatusBloc>(context).add(ColorPick());
              },
              icon: const Icon(
                Icons.color_lens,
                size: 30,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              heroTag: camera,
              backgroundColor: backround,
              shape: const CircleBorder(),
              onPressed: () async {
                final imagePicker = ImagePicker();
                try {
                  final pickedFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayImageScreen(
                          imagePath: pickedFile.path,
                          userId: user!.uid,
                          userName: widget.name,
                        ),
                      ),
                    );
                  } else {
                    // emit(ProfileImagePickedErrorState());
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: const Center(
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 55,
            width: 55,
            child: FloatingActionButton(
              heroTag: addStatus,
              shape: const CircleBorder(),
              backgroundColor: backround,
              onPressed: () {
                if (datacontroller.text.isNotEmpty) {
                  FirebaseFirestore.instance
                      .collection('status')
                      .doc(user!.uid)
                      .set({
                    "uid": user!.uid,
                    'image': widget.image,
                    'name': widget.name,
                  });
                  FirebaseFirestore.instance
                      .collection('status')
                      .doc(user!.uid)
                      .collection('status')
                      .doc()
                      .set({
                    "Data": datacontroller.text,
                    'color': backgroundColor.value,
                    'timestamp': DateTime.now().toUtc(),
                  });
                  Future.delayed(const Duration(seconds: 24), () {
                    FirebaseFirestore.instance
                        .collection('status')
                        .doc(user!.uid)
                        .collection('status')
                        .where('timestamp',
                            isLessThan: DateTime.now()
                                .subtract(const Duration(seconds: 24)))
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        doc.reference.delete();
                      });
                    });
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a status before sending.'),
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<StatusBloc, StatusState>(
        listener: (context, state) {
          if (state is ColorPickState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Pick Your Color',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildColorPicker(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("SELECT"),
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
            backgroundColor =
                state.color; // Update backgroundColor in the state
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
                    hintText: 'Type your status',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              datacontroller.text.isEmpty
                  ? Text("Tap here to write status ☝🏻",
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.grey.withOpacity(0.8)))
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }

  buildColorPicker() {
    return ColorPicker(
      pickerColor: backgroundColor, // Use backgroundColor from state
      onColorChanged: (Color colors) {
        setState(() {
          BlocProvider.of<StatusBloc>(context)
              .add(ColorPickerEvent(color: colors));
          showImage = false;
          backgroundColor = colors; // Update backgroundColor in the state
        });
      },
    );
  }
}
