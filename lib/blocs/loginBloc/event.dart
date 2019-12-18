abstract class LoginBlocEvent {}

class Login extends LoginBlocEvent {
  final String username;
  final String password;

  Login(this.username, this.password);

  @override
  String toString() => 'Login($username, $password)';
}

class InitLogin extends LoginBlocEvent {
  @override
  String toString() => 'InitLogin';
}
