abstract class LoginBlocState {}

class LoginInitial extends LoginBlocState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginBlocState {
  @override
  String toString() => 'LoginLoading';
}

class LoginFailure extends LoginBlocState {
  final String error;

  LoginFailure(this.error);

  @override
  String toString() => 'LoginFailure (error: $error)';
}

class LoginSuccess extends LoginBlocState {
  @override
  String toString() => 'LoginSuccess';
}
