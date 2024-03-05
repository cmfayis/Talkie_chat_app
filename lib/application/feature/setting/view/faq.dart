import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0), // Adjust padding as needed
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text('''About  Talkie
What devices does  Talkie support?
We support all Smartphones that meet the following requirements:
- Android running Android 5.0 and above.
- iPhone running iOS 12 and above.
- Your phone is able to receive SMS during the verification process.
You will also need a data plan in order to receive messages when outside the range of a Wi-Fi network.

Which country/region is  Talkie available in?
 Talkie is globally available in all countries/regions.

How to create a  Talkie account?
Make sure you use an active phone number to create a  Talkie account.
An SMS will be delivered to your phone.
The SMS will contain a 6-digit verification code.
The verification code is unique to your account.
Do not guess the verification code.

Will my  Talkie account work on multiple phones or with multiple numbers?
 Talkie verifies your account on only one device and one number at a time. If your device is dual-SIM, you need to select the number to use with  Talkie

Troubleshooting  Talkie
Contacts management
 Talkie will ask permission to access your device address book so you can see your contacts who also use  Talkie

Displaying contacts correctly:
Make sure that your contacts have active  Talkie accounts
Save the contact details in your device address book with proper formats
Where possible, use the use the full international format: + [country/region code] [full phone number].
Remove any leading zero or special calling codes.
Ensure you accept the  Talkie contact permission request (or go to your device settings and enable it)
If your device address book allows, ensure that all accounts and groups are set to "visible" or "viewable".
Blocking Contacts
Blocking contacts will prevent you from receiving calls or messages from them:

Blocking Contacts: go to Profile -> Settings -> Account ->Privacy
To un-block, follow the same flow and select the contact to un-block
Note: A blocked contact will still show in your address book.

Receiving or Sending Messages
If you have a bad internet connection, you will not receive  Talkie messages

In addition, if you still have issues, check the following:

The contact you are messaging has not blocked your number.
Your  Talkie account registration is complete.
Message Timestamps
If you notice that timestamp on your received messages are incorrect:

Check the time settings on your phone and set it to automatic or network provided.
If you need to set it manually, Make sure you select the correct time zone for your location.'''),
            ),
          ),
        ),
      ),
    );
  }
}
