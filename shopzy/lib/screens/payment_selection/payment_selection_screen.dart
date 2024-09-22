import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '/blocs/blocs.dart';
import '/widgets/widgets.dart';
import '/models/models.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  const PaymentSelection({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Payment Selection'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [

                //Google pay Selection for IOS -----------------------------------------
                if (Platform.isIOS)
                  RawApplePayButton(
                    type: ApplePayButtonType.inStore,
                    onPressed: () {
                      context.read<PaymentBloc>().add(
                            const SelectPaymentMethod(
                                paymentMethod: PaymentMethod.apple_pay),
                          );
                      Navigator.pop(context);
                    },
                  ),
                const SizedBox(height: 10),

                // Google pay selection for android  --------------------------------------------
                if (Platform.isAndroid)
                  FutureBuilder<PaymentConfiguration>(
                    future: PaymentConfiguration.fromAsset(
                        'assets/payment_profile_google_pay.json'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Text(
                            'Error loading Google Pay configuration');
                      } else if (snapshot.hasData) {
                        return RawGooglePayButton(
                          paymentConfiguration: snapshot.data!,
                          type: GooglePayButtonType.pay,
                          onPressed: () {
                            context.read<PaymentBloc>().add(
                                  const SelectPaymentMethod(
                                      paymentMethod: PaymentMethod.google_pay),
                                );
                            Navigator.pop(context);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                          const SelectPaymentMethod(
                              paymentMethod: PaymentMethod.credit_card),
                        );
                    Navigator.pop(context);
                  },
                  child: const Text('Pay with Credit Card'),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
