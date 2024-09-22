import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:shopzy/models/models.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({
    super.key,
    required this.total,
    required this.products,
  });

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var paymentItems = products
        .map(
          (product) => PaymentItem(
            label: product.name,
            amount: product.price.toString(),
            type: PaymentItemType.item,
            status: PaymentItemStatus.final_price,
          ),
        )
        .toList();

    paymentItems.add(
      PaymentItem(
        label: "Total",
        amount: total,
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    // Handle the payment result
    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: FutureBuilder<PaymentConfiguration>(
        future:
            PaymentConfiguration.fromAsset('payment_profile_google_pay.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error loading Google Pay configuration');
          } else if (snapshot.hasData) {
            return GooglePayButton(
              paymentConfiguration: snapshot.data!,
              onPaymentResult: onGooglePayResult,
              paymentItems: paymentItems,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 10),
              loadingIndicator: const CircularProgressIndicator(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
