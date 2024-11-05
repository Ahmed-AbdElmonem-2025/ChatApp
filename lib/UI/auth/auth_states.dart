abstract class AuthStates {}

class InitialState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}
class UserCreatedSuccessState extends AuthStates {}
class UserCreatedErrorState extends AuthStates {
  String  message;
  UserCreatedErrorState({required this.message});
}

 
class UserPickedImageSuccessState extends AuthStates {}
class UserPickedImageErrorState extends AuthStates {}


class SaveUserDataToFireStoreSuccessState extends AuthStates {}
class SaveUserDataToFireStoreErrorState extends AuthStates {}


class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class LoginErrorState extends AuthStates{}