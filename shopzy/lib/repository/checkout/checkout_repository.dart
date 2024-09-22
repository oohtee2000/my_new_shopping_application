import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopzy/models/models.dart';
// import 'package:shopzy/repository/category/base_category_repository.dart';
import 'package:shopzy/repository/checkout/base_checkout_repository.dart';

class CheckoutRepository extends BaseCheckoutRespository {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }
}
