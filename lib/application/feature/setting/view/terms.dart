import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0), // Adjust padding as needed
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text('''Terms of Service
      Terms of Use
      
      Thanks for using our services. These Terms of Use (this Agreement) are provided by Poptin Ltd (the owner of  Talkie.app AKA “We” or “Us” or “ Talkie“) to you (“You” or “User/s“), and regulate the terms under which You shall use the Services (as defined therein). By accessing or using the Website, You sign that You have read, understood and agree to be bound by this Agreement. If you do not agree with the Agreement, You shall discontinue using the Services immediately. This Agreement includes the Privacy Policy (the “Privacy Policy“) as an integral part herein and shall apply to all Users. This Agreement was last updated on 28 December, 2021. It is effective between You and Us as of the date of You accepting this Agreement and in accordance with its terms and conditions as such may be updated from time to time in Our sole discretion.
      
      Definitions
      
      “Account” means the account opened within the Service under Your subscribed name;
      “Content” means, without limitation, text, graphics, and images, including photographs;
      “Malicious Code” means viruses, worms, time bombs, trojan horses and any and all other harmful code, files, scripts, agents or programs;
      “ Talkie” refers to our company, known as Poptin Ltd. our Website, our Service or a combination of all or some of the preceding definitions, depending on the context of the word;
      “Service(s)” refers collectively and/or individually, as the case may be, to the SaaS services that we provide through our Website, any other services we provide, as well as our Website itself;
      “You” or “User/s” includes, without limitation, individuals and entities authorised to use the Service as well as Your employees, consultants, contractors and agents;
      “User Data” includes all Content that a User posts, uploads, publishes, submits or transmits to be made available through the Website.
      “Website” refers to our website, available at https:// Talkie.app/
      
      The Service
      
       Talkie is a SaaS (Software as a Service) software that allows users to display a chat button on their website and easily connect with their customers on their favorite messaging app like Messenger, WhatsApp, Telegram, Skype, Viber, and more!
      Our software is made available online and without requiring the purchase of a physical copy in order to use it;
      We hereby grant to You a non-exclusive, non-transferable license to electronically access and use the Services and the Website in accordance with the terms of this Agreement, subject to Your (i) opening an Account with Us; (ii) subscribing as set forth on the Website and herein; and (iii) adhering to the terms and conditions of this Agreement;
      In order to use the Service, You shall first be required to register with  Talkie by completing the online registration form on the Website. You shall register as a User by providing certain details, such as Your name, password and valid email address. Some features of the Website may contain a specific identification number for the purpose of tracking the number of unique instances of such features being used by You. You must provide true, complete and accurate registration information to Us and notify Us if Your information changes. We encourage You to use Your real name. If You are accessing the Services on behalf of a business, government, or non-profit entity, You must use the actual name of Your organisation and have authorisation to create their account and provide further details such as the office address and the organisation registration number. Furthermore, You agree that You are binding such organisation to this Agreement and undertake to indemnify  Talkie for any breaches caused by that organisation (without limitation on our right to obtain a remedy directly from the organisation in conjunction with or as an alternative to Your indemnification);'''),
            ),
          ),
        ),
      ),
    );
  }
}
