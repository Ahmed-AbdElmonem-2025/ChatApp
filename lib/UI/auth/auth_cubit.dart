 
import 'dart:io';

import 'package:chat_app/UI/auth/auth_states.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialState());
  

// register

void register({required String email,required String name, required String password })async {
try {
   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  if (userCredential.user!.uid != null) {
   String imageurl =await uploadImageToFireStorage();
  await sendUserDataToFireStore(name: name, email: email, password: password,imageUrl:imageurl  ,userId: userCredential.user!.uid);
    emit(UserCreatedSuccessState());
  }  
} on  FirebaseAuthException catch (e) {
   print(e.code);
   if (e.code == "email-already-in-use") {
     emit(UserCreatedErrorState(message: 'email-already-in-use'));
   }  
   
}
 
}








 File? userImageFile;
 
void getImage()async{
   
  var imagepicked = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (imagepicked !=null) {
    userImageFile = File(imagepicked.path) ;
    emit(UserPickedImageSuccessState());
  } else {

 emit(UserPickedImageErrorState());

  }

 }








Future<String>  uploadImageToFireStorage()async{
  // بجيب الاسم بتاع الصورة عشان تتخزن فى الفايرستورج باسم لوحدها
  Reference  imgref = await  FirebaseStorage.instance.ref(basename(userImageFile!.path),);
  // برفع الملف كله على الفايرستورج
    await imgref.putFile(userImageFile!);
   // برجع لينك الصورة بعد ماترفعت على الفايرستورج
   return await imgref.getDownloadURL();
  }











 Future<void> sendUserDataToFireStore({required String name,required String imageUrl,required String email,required String password,required String userId, })async {
 
 UserModel userModel = UserModel(email: email, id: userId, image: imageUrl, name: name);

try {
  
   await FirebaseFirestore.instance.collection('Users').doc(userId).set( userModel.toJson(),);
  
  emit(SaveUserDataToFireStoreSuccessState());

} catch (e) {

emit(SaveUserDataToFireStoreErrorState());

}



  }






 Future< void> login({required String email, required String password})async {

  emit(LoginLoadingState());
  try {
    
     UserCredential userCredential = 
     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   if (userCredential.user?.uid != null) {

   SharedPreferences sharedPref = await SharedPreferences.getInstance();
   await sharedPref.setString('userId' , userCredential.user!.uid);
   userId = sharedPref.getString('userId')  ;

     emit(LoginSuccessState());
   }  

  }on FirebaseAuthException catch (e) {
    emit(LoginErrorState());
  }
 
  }
}