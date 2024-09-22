import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/login/login_cubit.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => LoginScreen()
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Login'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            const SizedBox(height: 10,),

            _PasswordInput(),
            ElevatedButton(onPressed: () {
              context.read<LoginCubit>().logInWithCredentials();
            },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.black,
                  fixedSize: Size(200, 40),
                ),

                child: Text(
                  'Login',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white),
                )
            ),
            const SizedBox(height: 5),
            _GoogleLoginButton(),
          ],
        ),

      ),

    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(
              labelText: 'Email'
          ),


        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(
              labelText: 'Password'
          ),
          obscureText: true,
        );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget{
  const _GoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        context.read<LoginCubit>().logInWithGoogle();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          backgroundColor: Colors.white,
          fixedSize: Size(200, 40)
      ),
      child: Text('Sign In with Google',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),),);
  }
}