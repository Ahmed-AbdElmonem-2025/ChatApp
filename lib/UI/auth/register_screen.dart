import 'dart:io';

import 'package:chat_app/UI/auth/auth_cubit.dart';
import 'package:chat_app/UI/auth/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
    RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state) {
          if (state is UserCreatedErrorState) {
             ScaffoldMessenger.of(context).showSnackBar( SnackBar(backgroundColor: Colors.red ,content: Text(state.message)),);
          } 
          if (state is UserCreatedSuccessState) {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return LoginScreen();
            }));
          }
        },
        builder: (context, state) {
          return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            BlocProvider.of<AuthCubit>(context).userImageFile != null ? 
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(BlocProvider.of<AuthCubit>(context).userImageFile!),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    
                    onTap: () {
                        BlocProvider.of<AuthCubit>(context).getImage();
                    },
                    child: Text('change photo'),
                  )
                ],
              ),
            ) : OutlinedButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).getImage();
              },
              child:Row(
                children: [
                  Icon(Icons.image,color: Colors.green,),
                  SizedBox(width: 7,),
                  Text('select image'),
                ],
              ) ,
            ),
             SizedBox(height: 10,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'name',
              ),
            ),
            SizedBox(height: 10,),
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
              obscureText: true,
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
                 BlocProvider.of<AuthCubit>(context).register(email: emailController.text, password: passwordController.text,name: nameController.text);
               } else {
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(backgroundColor: Colors.red ,content: Text('please fill form and try agaign'),),);
               }
            },
            child: Text(state is RegisterLoadingState ? 'loading...' : 'Register'),
            minWidth: double.infinity,
            ),
          ],
        ),
      );
        }, ),
    );
  }
}
