import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rhs_app/AllScreens/loginScreen.dart';
import 'package:rhs_app/AllScreens/mainscreen.dart';
import 'package:rhs_app/AllScreens/registrationScreen.dart';
import 'package:rhs_app/DataHandler/appData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users ");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
          title: 'Taxi Rider App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RegistrationScreen.idScreen,
          routes:
          {
            RegistrationScreen.idScreen: (context) => RegistrationScreen(),
            LoginScreen.idScreen: (context) => LoginScreen(),
            MainScreen.idScreen: (context) => MainScreen(),
          },
          debugShowCheckedModeBanner: false,
      ),
    );
  }
}