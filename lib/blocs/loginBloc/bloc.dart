import 'package:bloc/bloc.dart';
import 'package:simple_bloc_login/blocs/loginBloc/event.dart';
import 'package:simple_bloc_login/blocs/loginBloc/state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  @override
  LoginBlocState get initialState => LoginInitial();

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    if (event is Login) {
      yield LoginLoading();
      await Future.delayed(Duration(seconds: 3));

      if (event.username == 'demo@mcom.app' && event.password == '12345678') {
        yield LoginSuccess();
      } else {
        yield LoginFailure(event.username != 'demo@mcom.app'
            ? 'Username incorrect'
            : 'Password incorrect');
      }
    }
  }
}
