import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_login/blocs/loginBloc/bloc.dart';
import 'package:simple_bloc_login/blocs/loginBloc/event.dart';
import 'package:simple_bloc_login/blocs/loginBloc/state.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(
            display4: TextStyle(fontSize: 112),
            display3: TextStyle(fontSize: 56),
            display2: TextStyle(fontSize: 45),
            display1: TextStyle(fontSize: 34),
            headline: TextStyle(fontSize: 24),
            title: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            subhead: TextStyle(fontSize: 16),
            body2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            body1: TextStyle(fontSize: 14),
            caption: TextStyle(fontSize: 12),
            button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            subtitle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            overline: TextStyle(fontSize: 10),
          ),
          primaryColor: Color(0xff6CABDD),
          colorScheme: ColorScheme(
            primary: Color(0xff6CABDD),
            primaryVariant: Color(0xff7979E2),
            brightness: Brightness.light,
            error: Colors.red,
            onBackground: Color(0xff000000),
            onError: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Color(0xff4F4F4F),
            secondary: Color(0xffFFDC74),
            secondaryVariant: Color(0xffFFC374),
            surface: Color(0xffF2F2F2),
            background: Color(0xffF9FAFB),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool autoValidate;
  bool isValidated;

  final loginBloc = LoginBloc();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    autoValidate = false;
    isValidated = false;
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }

  _checkValidate() {
    setState(() {
      isValidated = formKey.currentState.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: BlocListener(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: colorScheme.error,
              ),
            );
          } else if (state is LoginSuccess) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Success'),
                backgroundColor: colorScheme.primary,
              ),
            );
          }
        },
        child: BlocBuilder(
          bloc: loginBloc,
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(900),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Image.asset(
                          'assets/images/default.png',
                          fit: BoxFit.cover,
                        ),
                        width: 200,
                        imageUrl:
                            'https://avatars1.githubusercontent.com/u/36977998?s=460&v=4',
                      ),
                    ),
                    Form(
                      key: formKey,
                      autovalidate: autoValidate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 68,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email!';
                              } else if (!value.isEmail()) {
                                return 'Please enter the valid email!';
                              }
                              return null;
                            },
                            onChanged: (_) {
                              _checkValidate();
                            },
                            onTap: () {
                              setState(() {
                                autoValidate = true;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 14,
                              ),
                              labelText: 'Email',
                              labelStyle: textTheme.body1.merge(
                                TextStyle(color: colorScheme.onSurface),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password!';
                              } else if (!value.isPassword()) {
                                return 'Please enter the valid password!';
                              }
                              return null;
                            },
                            onChanged: (_) {
                              _checkValidate();
                            },
                            onTap: () {
                              setState(() {
                                autoValidate = true;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 14,
                              ),
                              labelText: 'Password',
                              labelStyle: textTheme.body1.merge(
                                TextStyle(color: colorScheme.onSurface),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 43,
                          ),
                          FlatButton(
                            child: state is LoginLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: textTheme.button.merge(
                                      TextStyle(color: colorScheme.onPrimary),
                                    ),
                                  ),
                            disabledColor: colorScheme.onSurface,
                            onPressed: state is LoginLoading || !isValidated
                                ? null
                                : () {
                                    if (formKey.currentState.validate()) {
                                      loginBloc.add(Login(emailController.text,
                                          passwordController.text));
                                    }
                                  },
                            color: colorScheme.primary,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

extension StringValidator on String {
  bool isEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool isPassword() {
    return this.length >
        6; //RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})").hasMatch(this);
  }
}
