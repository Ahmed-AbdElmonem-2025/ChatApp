class UserModel {

  String? name;
  String? email;
  String? image;
  String? id;
  
  UserModel({required this.email,required this.id,required this.image,required this.name,});

  UserModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    email = json['email'];
    image = json['image'];
    id = json['id'];
  }


  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'email' : email,
      'image' : image,
      'id' : id,
    };
  }
}