import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/signup/signup_cubit.dart';
import '../../widgets/widgets.dart';


class SignupScreen extends StatelessWidget{
  static const String routeName = '/signup';

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> SignupScreen()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Signup'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                _UserInput(
                    onChanged: (value){
                      context.read<SignupCubit>()
                          .userChanged(
                          state.user!
                              .copyWith(email: value));
                    }, labelText: 'Email'),
                const SizedBox(height: 10,),


                _UserInput(onChanged: (value){
                  context.read<SignupCubit>()
                      .userChanged(
                      state.user!
                          .copyWith(fullName: value));
                }, labelText: 'Full Name'),
                const SizedBox(height: 10,),


                _UserInput(onChanged: (value){
                  context.read<SignupCubit>()
                      .userChanged(
                      state.user!
                          .copyWith(country: value));
                }, labelText: 'Country'),
                const SizedBox(height: 10,),

                _UserInput(onChanged: (value){
                  context.read<SignupCubit>()
                      .userChanged(
                      state.user!
                          .copyWith(city: value));
                }, labelText: 'City'),
                const SizedBox(height: 10,),



                _UserInput(onChanged: (value){
                  context.read<SignupCubit>()
                      .userChanged(
                      state.user!
                          .copyWith(address: value));
                }, labelText: 'Address'),

                _UserInput(onChanged: (value){
                  context.read<SignupCubit>()
                      .userChanged(
                      state.user!
                          .copyWith(zipCode: value));
                }, labelText: 'Zip Code'),
                const SizedBox(height: 10,),

                _PasswordInput(),
                const SizedBox(height: 10,),


                ElevatedButton(onPressed: () {
                  context.read<SignupCubit>().signUpWithCredentials();
                },
                    child: Text(
                      'Signup',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                    )
                ),
              ],
            );
          },
        ),

      )

      ,

    );
  }


}

class _UserInput extends StatelessWidget{
  const _UserInput({
    Key? key,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;
  @override
  Widget build(BuildContext context){
    return  BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),

        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return  BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(labelText: 'Password'),

        );
      },
    );
  }
}