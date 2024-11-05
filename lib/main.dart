import 'package:chat_app/Layout/layout_cubit.dart';
import 'package:chat_app/UI/auth/auth_cubit.dart';
import 'package:chat_app/UI/auth/login_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/auth/home/home_screen.dart';
import 'UI/auth/register_screen.dart';
 
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );

  SharedPreferences sharedPref = await SharedPreferences.getInstance();
   
   userId = sharedPref.getString('userId')  ;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit(),),
        BlocProvider(create: (context)=>LayoutCubit(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        
          primarySwatch: Colors.blue,
        ),
        home: userId !=null ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
 