import 'package:chat_app/Layout/layout_cubit.dart';
import 'package:chat_app/Layout/layout_states.dart';
import 'package:chat_app/UI/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldKey =GlobalKey<ScaffoldState>();

    HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = BlocProvider.of<LayoutCubit >(context)..getMyData()..getUsers();
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener:  (context, state) {
        
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cubit.userModel != null)  

                   UserAccountsDrawerHeader(
                    accountName: Text(cubit.userModel!.name!),
                     accountEmail: Text(cubit.userModel!.email!),
                     currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(cubit.userModel!.image!),
                     ),
                     ),

                     Expanded(
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                           ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('log out'),
                           )
                        ]
                       ),
                     )
              ],

              
            ),
          ),
          appBar:AppBar(
            actions:[
              GestureDetector(child:  Icon(cubit.searchEnabled ? Icons.clear : Icons.search) , 
              onTap: () {
                cubit.changeSearchStatus();
              },
              ),
              
            ],
            title:
            
            GestureDetector(
            child: cubit.searchEnabled ?  TextField(
              onChanged: (value) {
                cubit.searchAboutUser(name: value);
              },
                 
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'search about user',
                   
                ),
              )   : Text('chat'),
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            ),
            ),


            body: state is GetUsersDataLoadingState ? Center(child:CircularProgressIndicator(), ) : 

            cubit.users.isNotEmpty ?
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 5,),
                itemCount: cubit.filteredUsers.isEmpty ? cubit.users.length : cubit.filteredUsers.length,
                itemBuilder: (context,index){
                return  ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                     return ChatScreen(userModel: cubit.filteredUsers.isEmpty ? cubit.users[index] : cubit.filteredUsers[index]);
                    }));
                  },
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(cubit.filteredUsers.isEmpty ? cubit.users[index].image! : cubit.filteredUsers[index].image!),
                    ),
                    title: Text(cubit.filteredUsers.isEmpty ? cubit.users[index].name! : cubit.filteredUsers[index].name!),
                  );

              }),
            ) : Center(child: Text('there is no users yet'),),
        );
      }  );
  }
}