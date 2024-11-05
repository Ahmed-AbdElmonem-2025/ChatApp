import 'package:chat_app/Layout/layout_cubit.dart';
import 'package:chat_app/Layout/layout_states.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
 final UserModel userModel;
 final messageController = TextEditingController() ;
    ChatScreen({ Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context)..getMessages(recieverId: userModel.id!);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:false,
          title: Text(userModel.name!),
        ),
        body: BlocConsumer<LayoutCubit,LayoutStates>(
          listener:  (context, state) {
            if (state is SendMessageSuccessState) {
              messageController.clear();
            }
          } ,
          builder: (context, state) {
            return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                 itemCount: cubit.messages.length,
                 itemBuilder: (context, index) {
                   return 
                   cubit.messages[index].senderID == userId ?


Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(.2),
      borderRadius: BorderRadiusDirectional.only(
        bottomStart: Radius.circular(10.0),
        topStart: Radius.circular(10.0),
        topEnd: Radius.circular(10.0),
      ),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 5.0,
      horizontal: 10.0,
    ),
    child: Text(
      cubit.messages[index].content!,
    ),
  ),
) : 

Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(.2),
      borderRadius: BorderRadiusDirectional.only(
        bottomStart: Radius.circular(10.0),
        topStart: Radius.circular(10.0),
        topEnd: Radius.circular(10.0),
      ),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 5.0,
      horizontal: 10.0,
    ),
    child: Text(
      cubit.messages[index].content!,
    ),
  ),
) ;

                  /* Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    child:Text(cubit.messages[index].content!) ,
                   );*/
                 },
              ),
              ),

              TextField(
                controller: messageController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // send message
                      cubit.sendMessage(message: messageController.text, recieverId: userModel.id!);
                    },
                  child: Icon(Icons.send)),
                  border: OutlineInputBorder( ),
                ),
              ),
            ],
          ),
        );
          }, )
    );
  }
}