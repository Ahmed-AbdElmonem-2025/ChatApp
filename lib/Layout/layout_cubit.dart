import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit( ) : super(InitialState());


  UserModel? userModel;
  getMyData()async{
  
  try {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = 
    await  FirebaseFirestore.instance.collection('Users').doc(userId).get() ;
  userModel =  UserModel.fromJson(json: documentSnapshot.data()!);
   emit(LayoutSuccessState());
  } on FirebaseException catch (e) {
    emit(LayoutErrorState());
  }
  }



 List<UserModel> users=[];
  getUsers()async{
   users.clear();
emit(   GetUsersDataLoadingState());
   try {
     await FirebaseFirestore.instance.collection('Users').get().then((value){
      for (var item in value.docs) {

        if (item.id != userId) {
           users.add(UserModel.fromJson(json: item.data()),);
        }
       
      }
      emit(GetUsersDataSuccessState());
    });
   }on FirebaseException catch (e) {
    users=[];
    emit(GetUsersDataErrorState());
   }
  }





List<UserModel> filteredUsers=[];
 void searchAboutUser({required String name}){
   
filteredUsers = users.where((element) => element.name!.toLowerCase().startsWith(name)).toList();
 
 emit(FilteredUsersSuccessState());
 }


 bool searchEnabled = false;

 void changeSearchStatus(){

  searchEnabled = !searchEnabled;

  if (searchEnabled == false) 
    filteredUsers.clear();
  
  emit(ChangeSearchStatusSuccessState());
 }


 sendMessage({required String message, required String recieverId})async {
  MessageModel messageModel = MessageModel(content: message, date: DateTime.now().toString(), senderID: userId);
  // save data on my document
await FirebaseFirestore.instance.collection("Users").doc( userId)
    .collection("Chat")
    .doc(recieverId).collection("Messages").add(messageModel.toJson());
 
 // save data on receiver document
await FirebaseFirestore.instance.collection("Users").doc( recieverId)
    .collection("Chat")
    .doc(userId).collection("Messages").add(messageModel.toJson());
 emit(SendMessageSuccessState());

 }






List<MessageModel> messages=[]; 
 getMessages({required String recieverId}){
  messages=[];
  emit(GetMessagesLoadingState());
  FirebaseFirestore.instance.collection('Users').doc(userId).collection('Chat').doc(recieverId).collection('Messages')
  .snapshots().listen((value) {
    messages=[];
    for (var item in value.docs) {
      messages.add(MessageModel.fromJson(data: item.data()));
    }
     emit(GetMessagesSuccessState());
   });
 }







}