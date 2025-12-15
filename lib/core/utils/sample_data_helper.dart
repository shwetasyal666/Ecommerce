import 'package:cloud_firestore/cloud_firestore.dart';

class SampleDataHelper {
  static Future<void> addSampleData() async {
    final firestore = FirebaseFirestore.instance;

    // Add Categories
    final categories = [
      {
        'name': 'Electronics',
        'description': 'Latest gadgets and electronics',
        'imageUrl': 'https://picsum.photos/400/300?random=1',
        'productCount': 10,
      },
      {
        'name': 'Fashion',
        'description': 'Trendy clothing and accessories',
        'imageUrl': 'https://picsum.photos/400/300?random=2',
        'productCount': 15,
      },
      {
        'name': 'Home & Kitchen',
        'description': 'Everything for your home',
        'imageUrl': 'https://picsum.photos/400/300?random=3',
        'productCount': 8,
      },
      {
        'name': 'Sports',
        'description': 'Sports equipment and gear',
        'imageUrl': 'https://picsum.photos/400/300?random=4',
        'productCount': 12,
      },
    ];

    print('Adding categories...');
    final categoryDocs = await firestore.collection('categories').get();
    if (categoryDocs.docs.isEmpty) {
      for (var category in categories) {
        await firestore.collection('categories').add(category);
      }
      print('✅ Categories added');
    } else {
      print('⚠️ Categories already exist');
    }

    // Get category IDs
    final categoriesSnapshot = await firestore.collection('categories').get();
    final categoryMap = {
      for (var doc in categoriesSnapshot.docs) doc['name']: doc.id
    };

    // Add Products
    final products = [
      {
        'name': 'Wireless Headphones',
        'description':
            'Premium noise-cancelling wireless headphones with superior sound quality',
        'price': 299.99,
        'discountPrice': 249.99,
        'imageUrl': 'https://picsum.photos/400/400?random=10',
        'images': [
          'https://picsum.photos/400/400?random=10',
          'https://picsum.photos/400/400?random=11',
          'https://picsum.photos/400/400?random=12',
        ],
        'categoryId': categoryMap['Electronics'],
        'categoryName': 'Electronics',
        'stock': 50,
        'rating': 4.5,
        'reviewCount': 128,
        'isFeatured': true,
        'createdAt': Timestamp.now(),
      },
      {
        'name': 'Smart Watch',
        'description': 'Fitness tracker with heart rate monitor and GPS',
        'price': 399.99,
        'discountPrice': 349.99,
        'imageUrl': 'https://picsum.photos/400/400?random=20',
        'images': [
          'https://picsum.photos/400/400?random=20',
          'https://picsum.photos/400/400?random=21',
        ],
        'categoryId': categoryMap['Electronics'],
        'categoryName': 'Electronics',
        'stock': 30,
        'rating': 4.7,
        'reviewCount': 256,
        'isFeatured': true,
        'createdAt': Timestamp.now(),
      },
      {
        'name': 'Denim Jacket',
        'description': 'Classic blue denim jacket for all seasons',
        'price': 89.99,
        'imageUrl': 'https://picsum.photos/400/400?random=30',
        'images': [
          'https://picsum.photos/400/400?random=30',
          'https://picsum.photos/400/400?random=31',
        ],
        'categoryId': categoryMap['Fashion'],
        'categoryName': 'Fashion',
        'stock': 100,
        'rating': 4.3,
        'reviewCount': 89,
        'isFeatured': false,
        'createdAt': Timestamp.now(),
      },
      {
        'name': 'Running Shoes',
        'description': 'Comfortable running shoes with excellent grip',
        'price': 129.99,
        'discountPrice': 99.99,
        'imageUrl': 'https://picsum.photos/400/400?random=40',
        'images': [
          'https://picsum.photos/400/400?random=40',
          'https://picsum.photos/400/400?random=41',
        ],
        'categoryId': categoryMap['Sports'],
        'categoryName': 'Sports',
        'stock': 75,
        'rating': 4.6,
        'reviewCount': 342,
        'isFeatured': true,
        'createdAt': Timestamp.now(),
      },
      {
        'name': 'Coffee Maker',
        'description': 'Automatic coffee maker with timer function',
        'price': 79.99,
        'imageUrl': 'https://picsum.photos/400/400?random=50',
        'images': [
          'https://picsum.photos/400/400?random=50',
        ],
        'categoryId': categoryMap['Home & Kitchen'],
        'categoryName': 'Home & Kitchen',
        'stock': 45,
        'rating': 4.4,
        'reviewCount': 167,
        'isFeatured': false,
        'createdAt': Timestamp.now(),
      },
    ];

    print('Adding products...');
    final productDocs = await firestore.collection('products').get();
    if (productDocs.docs.isEmpty) {
      for (var product in products) {
        await firestore.collection('products').add(product);
      }
      print('✅ Products added');
    } else {
      print('⚠️ Products already exist');
    }

    print('🎉 Sample data setup complete!');
  }
}