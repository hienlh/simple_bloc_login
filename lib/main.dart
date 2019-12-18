import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 68,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 14,
                        ),
                        labelText: 'Username',
                        labelStyle: textTheme.body1.merge(
                          TextStyle(color: colorScheme.onSurface),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    TextField(
                      obscureText: true,
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
                      child: Text(
                        'Login',
                        style: textTheme.button.merge(
                          TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                      onPressed: () {},
                      color: colorScheme.primary,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
