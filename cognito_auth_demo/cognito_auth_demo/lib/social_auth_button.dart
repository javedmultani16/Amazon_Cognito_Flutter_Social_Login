import 'package:cognito_auth_demo/auth_type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// onClick of GoogleSignInButton
class GoogleSignInButton extends _BaseSocialAuthButton {
  const GoogleSignInButton({Key? key, required VoidCallback onPressed})
      : super(
          key: key,
          type: AuthType.google,
          onPressed: onPressed,
          iconSize: 20,
          expanded: false,
        );
}

// onClick of FacebookSignInButton
class FacebookSignInButton extends _BaseSocialAuthButton {
  const FacebookSignInButton({Key? key, required VoidCallback onPressed})
      : super(
          key: key,
          type: AuthType.facebook,
          onPressed: onPressed,
          iconSize: 20,
          expanded: false,
        );
}

// onClick of AmazonSignInButton
class AmazonSignInButton extends _BaseSocialAuthButton {
  const AmazonSignInButton({Key? key, required VoidCallback onPressed})
      : super(
          key: key,
          type: AuthType.amazon,
          onPressed: onPressed,
          iconSize: 24,
          expanded: false,
        );
}

// Create Social Authentication screen UI
abstract class _BaseSocialAuthButton extends StatelessWidget {
  final AuthType type;
  final double iconSize;
  final VoidCallback onPressed;
  final bool expanded;

  const _BaseSocialAuthButton({
    Key? key,
    required this.type,
    required this.onPressed,
    required this.iconSize,
    required this.expanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String label;
    late IconData icon;
    late Color backgroundColor;

    // Create Sign In Button
    switch (type) {
      case AuthType.google:
        label = 'Sign in with Google';
        icon = FontAwesomeIcons.google;
        backgroundColor = Colors.red;
        break;
      case AuthType.facebook:
        label = 'Sign in with Facebook';
        icon = FontAwesomeIcons.facebookF;
        backgroundColor = Colors.indigo;
        break;
      case AuthType.amazon:
        label = 'Sign in with Amazon';
        icon = FontAwesomeIcons.amazon;
        backgroundColor = Colors.amber;

        break;
      default:
    }

    var button = MaterialButton(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      height: 48,
      textColor: Colors.white,
      splashColor: Colors.grey.shade400.withOpacity(0.3),
      highlightColor: Colors.grey.shade400.withOpacity(0.3),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
          ),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    return expanded ? Expanded(child: button) : button;
  }
}
