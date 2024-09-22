import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final bool isRecommended;
  @HiveField(6)
  final bool isPopular;
  @HiveField(7)
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
    this.description,
  });

  // factory Product.fromSnapshot(DocumentSnapshot snap) {
  //   var data = snap.data() as Map<String, dynamic>;
  //
  //   return Product(
  //     id: (data['id'] ).toInt() ?? 0,
  //     name: data['name'],
  //     category: data['category'],
  //     imageUrl: data['imageUrl'],
  //     price: (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0,
  //     isRecommended: data['isRecommended'] ?? false,
  //     isPopular: data['isPopular'] ?? false,
  //     description: data['description'],
  //   );
  //
  // }


  factory Product.fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return Product(
      id: (data['id'] ?? 0).toInt(), // Default to 0 if 'id' is null
      name: data['name'] ?? 'Unknown', // Default to 'Unknown' if 'name' is null
      category: data['category'] ?? 'Uncategorized', // Default to 'Uncategorized'
      imageUrl: data['imageUrl'] ?? 'https://via.placeholder.com/150', // Placeholder image if 'imageUrl' is missing
      price: (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0, // Default to 0.0 if 'price' is null
      isRecommended: data['isRecommended'] ?? false, // Default to false if missing
      isPopular: data['isPopular'] ?? false, // Default to false if missing
      description: data['description'] ?? 'No description available', // Default to 'No description' if missing
    );
  }







  @override
  List<Object?> get props => [
    id,
    name,
    category,
    imageUrl,
    price,
    isRecommended,
    isPopular,
    description,
  ];

  static List<Product> products = [
    const Product(
      id: 1,
      name: 'Soft Drink #1',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 2.99,
      description: 'description l l  ',
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      id: 2,
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      description: 'description l l  ',
      imageUrl:
      'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
      price: 2.99,
      isRecommended: false,
      isPopular: true,
    ),
    const Product(
      id: 3,
      name: 'Soft Drink #3',
      category: 'Soft Drinks',
      description: 'description l l  ',
      imageUrl:
      'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
      price: 2.99,
      isRecommended: true,
      isPopular: true,
    ),
    const Product(
      id: 4,
      name: 'Smoothies #1',
      description: 'description l l  ',
      category: 'Smoothies',
      imageUrl:
      'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', //https://unsplash.com/photos/kcYXj4tBtes
      price: 2.99,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      id: 5,
      name: 'Smoothies #2',
      category: 'Smoothies',
      imageUrl:
      'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80', //https://unsplash.com/photos/CrK843Pl9a4
      price: 2.99,
      isRecommended: false,
      description: 'description l l  ',
      isPopular: false,
    ),
    const Product(
      id: 6,
      name: 'Soft Drink #1',
      category: 'Soft Drinks',
      description: 'description l l  ',
      imageUrl:
      'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 2.99,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      id: 7,
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      description: 'description l l  ',
      imageUrl:
      'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
      price: 2.99,
      isRecommended: false,
      isPopular: true,
    ),
    const Product(
      id: 8,
      name: 'Soft Drink #3',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
      price: 2.99,
      description: 'description l l  ',
      isRecommended: true,
      isPopular: true,
    ),
    const Product(
      id: 9,
      name: 'Smoothies #1',
      category: 'Smoothies',
      description: 'description l l  ',
      imageUrl:
      'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', //https://unsplash.com/photos/kcYXj4tBtes
      price: 2.99,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      id: 10,
      name: 'Smoothies #2',
      category: 'Smoothies',
      imageUrl:
      'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80', //https://unsplash.com/photos/CrK843Pl9a4
      price: 2.99,
      description: 'description l l  ',
      isRecommended: false,
      isPopular: false,
    ),
    const Product(
      id: 11,
      name: 'Soft Drink #1',
      category: 'Soft Drinks',
      description: 'description l l  ',
      imageUrl:
      'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 2.99,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      id: 12,
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
      price: 2.99,
      isRecommended: false,
      description: 'description l l  ',
      isPopular: true,
    ),
    const Product(
      id: 13,
      name: 'Soft Drink #3',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
      price: 2.99,
      isRecommended: true,
      description: 'description l l  ',
      isPopular: true,
    ),
    const Product(
      id: 14,
      name: 'Smoothies #2',
      category: 'Smoothies',
      imageUrl:
      'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80', //https://unsplash.com/photos/CrK843Pl9a4
      price: 2.99,
      isRecommended: false,
      description: 'description l l  ',
      isPopular: false,
    ),
  ];
}
