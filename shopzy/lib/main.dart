import 'package:shopzy/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/config/theme.dart';
import '/config/app_router.dart';
import '/blocs/blocs.dart';
import '/repositories/repositories.dart';
import '/screens/screens.dart';
import '/simple_bloc_observer.dart';
import '/models/models.dart';
import 'cubits/login/login_cubit.dart';
import 'cubits/signup/signup_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopzy',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),

          RepositoryProvider(
            create: (context) => AuthRepository(
              userRepository: context.read<UserRepository>(), // Updated
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AuthBloc(
                    authRepository: context.read<AuthRepository>(),
                    userRepository: context.read<UserRepository>(),
                  ),
            ),
            BlocProvider(
              create: (_) =>
              CartBloc()
                ..add(LoadCart()),
            ),
            BlocProvider(
              create: (_) =>
              PaymentBloc()
                ..add(LoadPaymentMethod()),
            ),
            BlocProvider(
              create: (context) =>
                  CheckoutBloc(
                    authBloc: context.read<AuthBloc>(),
                    cartBloc: context.read<CartBloc>(),

                    paymentBloc: context.read<PaymentBloc>(),
                    checkoutRepository: CheckoutRepository(),
                  ),
            ),
            BlocProvider(
              create: (_) =>
              WishlistBloc(
                localStorageRepository: LocalStorageRepository(),
              )
                ..add(StartWishlist()),
            ),
            BlocProvider(
              create: (_) =>
              CategoryBloc(
                categoryRepository: CategoryRepository(),
              )
                ..add(
                  LoadCategories(),
                ),
            ),

            BlocProvider(
              create: (_) =>
              ProductBloc(
                productRepository: ProductRepository(),
              )
                ..add(LoadProducts()),
            ),

            BlocProvider(
              create: (context) =>
              SearchBloc(
                productBloc: context.read<ProductBloc>(),
              )
                ..add(LoadSearch())
              ,
            ),

            BlocProvider(
                create: (context) => LoginCubit(
                    authRepository: context.read<AuthRepository>()
                )
            ),
            BlocProvider(
                create: (context) => SignupCubit(
                    authRepository: context.read<AuthRepository>()
                )
            ),



          ],
          child: MaterialApp(
            title: 'Shopzy',
            debugShowCheckedModeBanner: false,
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: SplashScreen.routeName,
          ),
        ),
      ),
    );
  }
}