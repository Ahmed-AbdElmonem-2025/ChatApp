abstract class LayoutStates {}

class InitialState extends LayoutStates {
  
}

class LayoutSuccessState extends LayoutStates {
  
}


class LayoutErrorState extends LayoutStates {
  
}




class GetUsersDataSuccessState extends LayoutStates {}
class GetUsersDataErrorState extends LayoutStates {}
 class GetUsersDataLoadingState extends LayoutStates {}
 




class FilteredUsersSuccessState extends LayoutStates {}
class ChangeSearchStatusSuccessState extends LayoutStates {}





class SendMessageSuccessState extends LayoutStates {}


class GetMessagesSuccessState extends LayoutStates {}
class GetMessagesLoadingState extends LayoutStates {}
class GetMessagesErrorState extends LayoutStates {}