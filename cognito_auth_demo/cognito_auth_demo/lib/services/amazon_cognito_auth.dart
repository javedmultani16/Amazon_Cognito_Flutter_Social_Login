import 'package:cognito_auth_demo/services/amazon_cognito_auth_impl.dart';
import 'package:flutter/material.dart';


/// Create User pool Document: [https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-as-user-directory.html]

abstract class AmazonCognitoAuth {
  static final AmazonCognitoAuth _instance = AmazonCognitoAuthImpl();

 // AWS Config data parser
  void setOptions({
    required String userPoolDomin,
    required String appClientSecret,
    required String redirectCallbackUrl,
  });

  Widget signInWithGoogleView({VoidCallback? onSuccess, VoidCallback? onError});

  Widget signInWithFacebookView({
    VoidCallback? onSuccess,
    VoidCallback? onError,
  });

  Widget signInWithAmazonView({VoidCallback? onSuccess, VoidCallback? onError});

  static AmazonCognitoAuth get instance => _instance;
}
