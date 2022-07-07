import 'dart:developer';
import 'dart:io';

import 'package:cognito_auth_demo/services/amazon_cognito_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AmazonCognitoAuthImpl extends AmazonCognitoAuth {
  String? _userPoolDomin;
  String? _appClientSecret;
  String? _redirectCallbackUrl;

  @override
  void setOptions({
    required String userPoolDomin,
    required String appClientSecret,
    required String redirectCallbackUrl,
  }) {
    _userPoolDomin = userPoolDomin;
    _appClientSecret = appClientSecret;
    _redirectCallbackUrl = redirectCallbackUrl;
  }

  @override
  Widget signInWithGoogleView({VoidCallback? onSuccess, VoidCallback? onError}) {
    assert(
        canSignIn, 'Call setOptions() before calling signInWithGoogleView()');
    String url = '$_prefixUrl?identity_provider=Google&$suffixUrl';
    return _SignInWebView(
      userPoolDomin: _userPoolDomin,
      initialUrl: url,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  @override
  Widget signInWithAmazonView({VoidCallback? onSuccess, VoidCallback? onError}) {
    assert(
        canSignIn, 'Call setOptions() before calling signInWithAmazonView()');
    String url = '$_prefixUrl?identity_provider=LoginWithAmazon&$suffixUrl';
    return _SignInWebView(
      userPoolDomin: _userPoolDomin,
      initialUrl: url,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  @override
  Widget signInWithFacebookView(
      {VoidCallback? onSuccess, VoidCallback? onError}) {
    assert(
        canSignIn, 'Call setOptions() before calling signInWithFacebookView()');
    String url = '$_prefixUrl?identity_provider=Facebook&$suffixUrl';
    return _SignInWebView(
      userPoolDomin: _userPoolDomin,
      initialUrl: url,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  String get _prefixUrl => '$_userPoolDomin/oauth2/authorize';

  String get suffixUrl {
    return 'response_type=token&client_id=$_appClientSecret&redirect_uri=$_redirectCallbackUrl';
  }

  // Check if value null or not
  bool get canSignIn {
    return _userPoolDomin != null &&
        _appClientSecret != null &&
        _redirectCallbackUrl != null;
  }
}

class _SignInWebView extends StatefulWidget {
  final String? userPoolDomin;
  final String initialUrl;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;

  const _SignInWebView({
    required this.userPoolDomin,
    required this.initialUrl,
    this.onSuccess,
    this.onError,
  });

  @override
  State<_SignInWebView> createState() => __SignInWebViewState();
}

// SignIn page with selected media plateform
class __SignInWebViewState extends State<_SignInWebView> {
  late final String _successCode = 'https://www.google.com/#access_token';
  late final String _errorCode = '${widget.userPoolDomin}/error?code=';

  int processing = 0;

  String userAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N)'
      'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  @override
  void initState() {
    super.initState();
    log(widget.initialUrl);
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.initialUrl,
                userAgent: userAgent,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {},
                onProgress: (value) {
                  setState(() {
                    processing = value;
                  });
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith(_successCode)) {
                    widget.onSuccess?.call();
                  } else {
                    if (request.url.startsWith(_errorCode)) {
                      widget.onError?.call();
                    }
                  }
                  return NavigationDecision.navigate;
                },
              ),
              if (processing < 100)
                const Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
