import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../repositories/repositories.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) =>
            BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                authBloc: context.read<AuthBloc>(),
                userRepository: context.read<UserRepository>(),
              )..add(
                  LoadProfile(context.read<AuthBloc>().state.authUser,)
              ),
              child: ProfileScreen(),
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CUSTOMER INFORMATION'),
                  const SizedBox(height: 5,),
                  CustomTextFormField(
                      title: 'Email',
                    initialValue: state.user.email,
                    onChanged: (value) {
                        context.read<ProfileBloc>().add(UpdateProfile(user: state.user.copyWith(email: value)));
                    },
                  ),

                  const SizedBox(height: 5,),
                  CustomTextFormField(
                    title: 'Full Name',
                    initialValue: state.user.fullName,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(user: state.user.copyWith(fullName: value)));
                    },
                  ),


                  const SizedBox(height: 5,),
                  CustomTextFormField(
                    title: 'Address',
                    initialValue: state.user.address,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(user: state.user.copyWith(address: value)));
                    },
                  ),

                  const SizedBox(height: 5,),
                  CustomTextFormField(
                    title: 'City',
                    initialValue: state.user.city,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(user: state.user.copyWith(city: value)));
                    },
                  ),

                  const SizedBox(height: 5,),
                  CustomTextFormField(
                    title: 'Country',
                    initialValue: state.user.country,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(user: state.user.copyWith(country: value)));
                    },
                  ),


                  const SizedBox(height: 5,),
                  CustomTextFormField(
                    title: 'Zip Code',
                    initialValue: state.user.zipCode,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(user: state.user.copyWith(zipCode: value)));
                    },
                  ),


                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthRepository>().signOut();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: Colors.black,
                        fixedSize: Size(200, 40),
                      ),
                      child: Text(
                        'Sign Out',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileUnauthenticated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
              width: double.infinity,
              child: Center(
                child: Text('Youre not logged in.'),
              ),
            ),


                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    backgroundColor: Colors.black,
                    fixedSize: Size(200, 40),
                  ),
                  child: Center(

                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color:Colors.white),
                      )
                  ),
                ),

                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    backgroundColor: Colors.white,
                    fixedSize: Size(200, 40),
                  ),
                  child: Center(

                      child: Text(
                        'Signup',
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                  ),
                )






              ],
            );
          } else {
            return Text('Something went Wrong');
          }
        },
      ),
    );
  }
}
