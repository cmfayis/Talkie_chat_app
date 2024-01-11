import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/profileview/profilebloc/profile_bloc.dart';
import 'package:chat_app/application/feature/profileview/widget/textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewWrapper extends StatelessWidget {
  const ProfileViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final namecontroller =TextEditingController();
  final descriptioncontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
           const    CustomSizedBox(hieght: 50,),
             const  Text(
                'Upload info',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
          const   CustomSizedBox(hieght: 30,),
          
              GestureDetector(
                onTap: (){},
                child: DottedBorder(
                  dashPattern: const [15, 5],
                  borderType: BorderType.Circle,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SizedBox(
                      width: 130,
                      height: 150,
                      child: Center(
                        child: Image.asset('asset/images/profile.png'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            Padding(
              padding:const   EdgeInsets.all(23.0),
              child: TextFieldWidget(
                controller:namecontroller ,
                hintText: 'Name',),
            ),
            Padding(
              padding:const   EdgeInsets.only(left: 23,right: 23),
              child: TextFieldWidget(
                controller:descriptioncontroller,
                hintText: 'Description',
                lines: 4,),
            ),
         const   CustomSizedBox(hieght: 95,),
          Padding(
            padding: const EdgeInsets.all(23.0),
            child: InkWell(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                height: 55,
                child: Center(child: Text("Continue")),
              ),
            ),
          )    ,
          Padding(
            padding: const EdgeInsets.only(left: 300,top: 20),
            child: TextButton(onPressed: (){}, child: Text('Skip >>')),
          )
            ],
          ),
        ),
      ),
    );
  }
}