import 'package:cognito_auth_demo/auth_type.dart';
import 'package:cognito_auth_demo/configs.dart';
import 'package:cognito_auth_demo/services/amazon_cognito_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  final AuthType type;

  const AuthenticationPage(this.type, {super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final AmazonCognitoAuth _cognitoAuth = AmazonCognitoAuth.instance;

  VoidCallback? onSuccess;
  VoidCallback? onError;

  @override
  void initState() {
    super.initState();
    _cognitoAuth.setOptions(
      userPoolDomin: AuthConfigs.userPoolDomin,
      appClientSecret: AuthConfigs.appClientSecret,
      redirectCallbackUrl: AuthConfigs.redirectCallbackUrl,
    );

    // Signup Success
    onSuccess = () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (route) => false,
      );
    };

    // Signup Fail
    onError = () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication failed')),
      );
    };
  }

  Widget _buildView() {
    switch (widget.type) {
      case AuthType.google:
        return _cognitoAuth.signInWithGoogleView(
          onSuccess: onSuccess,
          onError: onError,
        );
      case AuthType.facebook:
        return _cognitoAuth.signInWithFacebookView(
          onSuccess: onSuccess,
          onError: onError,
        );
      case AuthType.amazon:
        return _cognitoAuth.signInWithAmazonView(
          onSuccess: onSuccess,
          onError: onError,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildView());
  }
}

// After successfully login redirect to home screen
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
