import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/blocs.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({
    super.key,
    required this.screen,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: (screen == '/product')
            ? AddToCartNavBar(product: product!)
            : (screen == '/cart')
                ? const GoToCheckoutNavBar()
                : (screen == '/checkout')
                    ? const OrderNowNavBar()
                    : const HomeNavBar(),
      ),
    );
  }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
        IconButton(
          icon: const Icon(Icons.person, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        )
      ],
    );
  }
}

class AddToCartNavBar extends StatelessWidget {
  const AddToCartNavBar({
    super.key,
    required this.product,
  });

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const CircularProgressIndicator();
            }
            if (state is WishlistLoaded) {
              return IconButton(
                icon: const Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to your Wishlist!'),
                    ),
                  );
                  context
                      .read<WishlistBloc>()
                      .add(AddProductToWishlist(product));
                },
              );
            }
            return const Text('Something went wrong!');
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const CircularProgressIndicator();
            }
            if (state is CartLoaded) {
              return ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddProduct(product));
                  Navigator.pushNamed(context, '/cart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                child: Text(
                  'ADD TO CART',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            }
            return const Text('Something went wrong!');
          },
        ),
      ],
    );
  }
}

class GoToCheckoutNavBar extends StatelessWidget {
  const GoToCheckoutNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/checkout');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(
            'GO TO CHECKOUT',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}

class OrderNowNavBar extends StatelessWidget {
  const OrderNowNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is CheckoutLoaded) {
              if (state.paymentMethod == PaymentMethod.credit_card) {
                return Container(
                  child: Text(
                    'Pay with Credit Card',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                );
              }
              if (Platform.isAndroid &&
                  state.paymentMethod == PaymentMethod.google_pay) {
                return GooglePay(
                  products: state.products!,
                  total: state.total!,
                );
              }
              if (Platform.isIOS &&
                  state.paymentMethod == PaymentMethod.apple_pay) {
                return const SizedBox();
                // ApplePay(
                //   products: state.products!,
                //   total: state.total!,
                // );
              } else {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment-selection');
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    'CHOOSE PAYMENT',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                );
              }
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ],
    );
  }
}
