import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import '../constants/constants.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

   signIn(WidgetRef ref,BuildContext context)async{
     ref.watch(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: ()=> signIn(ref,context),
          icon: Image.asset(
            Constants.googlePath,
            width: 35,
          ),
          label: const Text(
            'Continue with google',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
