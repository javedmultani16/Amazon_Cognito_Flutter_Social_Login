import 'package:cognito_auth_demo/auth_type.dart';
import 'package:cognito_auth_demo/authentication_page.dart';
import 'package:cognito_auth_demo/social_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cognito Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // Generate SignIn Button press event
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cognito Auth Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleSignInButton(onPressed: () {
              navigateToAuthenticationPage(context, AuthType.google);
            }),
            const SizedBox(height: 20),
            FacebookSignInButton(onPressed: () {
              navigateToAuthenticationPage(context, AuthType.facebook);
            }),
            const SizedBox(height: 20),
            AmazonSignInButton(onPressed: () {
              navigateToAuthenticationPage(context, AuthType.amazon);
            }),
          ],
        ),
      ),
    );
  }

  // Navigate To Authentication Page on button click
  void navigateToAuthenticationPage(BuildContext context, AuthType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationPage(type),
      ),
    );
  }
}
