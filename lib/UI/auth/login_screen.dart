import 'package:chat_app/UI/auth/auth_states.dart';
import 'package:chat_app/UI/auth/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

    LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit,AuthStates>(
        listener:  (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){
             return HomeScreen();
            }));
          }  
        },
        builder: (context, state) {
          return  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),

               SizedBox(height: 10,),

              MaterialButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: (){
                 if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                   BlocProvider.of<AuthCubit>(context).login(email: emailController.text, password: passwordController.text,);
                 } else {
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(backgroundColor: Colors.red ,content: Text('please fill form and try agaign'),),);
                 }
              },
              child: Text(state is LoginLoadingState ? 'loading...' : 'Login'),
              minWidth: double.infinity,
              ),
          ],
        ),
      );
        }, )
    );
  }
}