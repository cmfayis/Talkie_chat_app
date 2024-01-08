
import 'package:flutter/material.dart';
import '../widget/heading.dart';
import '../widget/sizedbox.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
             ),
             Opacity(
              opacity: .6,
               child: Padding(
                 padding: const EdgeInsets.only(right: 50,bottom: 320),
                 child: Container(
                             width: double.infinity,
                             height: 650.0,
                             decoration:const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: .7,
                    colors: [Color.fromARGB(255, 76, 34, 129), Colors.black],
                  ),
                             ),
                             ),
               ),
             ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
            const    CustomSizedBox(
                  hieght: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "asset/images/splash.png",
                      width: 55,
                    ),
                    const Text(
                      'Chat App',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              const  HeadingText(),
            
                const CustomSizedBox(
                  hieght: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        print('clicked facebook');
                      },
                      child: Container(
                        padding:const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(color: Colors.grey)),
                        child: CircleAvatar(
                            radius: 17,
                            child: Image.asset('asset/images/face.webp')),
                      ),
                    ),
                    const CustomSizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding:const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(color: Colors.grey)),
                        child: CircleAvatar(
                            radius: 17,
                            child: Image.asset('asset/images/google.jpg')),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 25),
                  child: Row(
                    children: [
                      Container(
                        height: 2,
                        width: 172,
                        color:const Color.fromARGB(255, 55, 55, 55),
                      ),
                      const CustomSizedBox(
                        width: 10,
                      ),
                      const Text(
                        'or',
                        style: TextStyle(color: Colors.white),
                      ),
                      const CustomSizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 2,
                        width: 172,
                        color: const Color.fromARGB(255, 55, 55, 55),
                      )
                    ],
                  ),
                ),
              const  CustomSizedBox(hieght: 35,),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Container(
                    width: 385,
                    height: 55,
                    decoration:const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child:const Center(child: Text("Sign up withn mail"),),
                  ),
                ),
               const CustomSizedBox(hieght: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const Text('Existing account? ',style: TextStyle(color: Colors.grey,)),
                    TextButton(onPressed: (){}, child:const Text('Log in',style: TextStyle(color: Colors.white),)),
                  ],
                )
              ],
            ),
          
        ],
      ),
    );
  }
}

