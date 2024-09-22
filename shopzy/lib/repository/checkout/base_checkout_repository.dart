import 'package:shopzy/models/models.dart';

abstract class BaseCheckoutRespository{
  Future<void> addCheckout(Checkout checkout);
}