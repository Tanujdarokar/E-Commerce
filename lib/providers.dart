import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme Provider
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Cart Provider
class CartNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CartNotifier() : super([]);

  void addToCart(Map<String, dynamic> product) {
    final existingIndex = state.indexWhere(
      (item) => item['name'] == product['name'],
    );
    if (existingIndex >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            {...state[i], 'quantity': (state[i]['quantity'] ?? 1) + 1}
          else
            state[i],
      ];
    } else {
      state = [
        ...state,
        {...product, 'quantity': 1},
      ];
    }
  }

  void removeFromCart(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void updateQuantity(int index, bool increase) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          {
            ...state[i],
            'quantity': increase
                ? (state[i]['quantity'] ?? 1) + 1
                : (state[i]['quantity'] ?? 1) > 1
                ? (state[i]['quantity'] ?? 1) - 1
                : 1,
          }
        else
          state[i],
    ];
  }

  void clearCart() {
    state = [];
  }

  double get totalAmount {
    return state.fold(
      0.0,
      (sum, item) => sum + (item['price'] * (item['quantity'] ?? 1)),
    );
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<Map<String, dynamic>>>((ref) {
      return CartNotifier();
    });

// Orders Provider
class OrdersNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  OrdersNotifier() : super([]);

  void addOrder(Map<String, dynamic> order) {
    state = [...state, order];
  }
}

final ordersProvider =
    StateNotifierProvider<OrdersNotifier, List<Map<String, dynamic>>>((ref) {
      return OrdersNotifier();
    });

// Products Provider
final productsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    // --- BISCUITS ---
    {
      'name': 'Chocolate Cookies',
      'price': 30.0,
      'image':
          'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80',
      'desc': 'Crispy chocolate chip cookies.',
      'category': 'Biscuits',
    },
    {
      'name': 'Butter Biscuits',
      'price': 25.0,
      'image':
          'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=500&q=80',
      'desc': 'Classic butter biscuits.',
      'category': 'Biscuits',
    },
    {
      'name': 'Oatmeal Cookies',
      'price': 40.0,
      'image':
          'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=500&q=80',
      'desc': 'Healthy oatmeal cookies.',
      'category': 'Biscuits',
    },
    {
      'name': 'Digestive Biscuits',
      'price': 45.0,
      'image':
          'https://images.unsplash.com/photo-1590080875515-8a3a8dc5735e?w=500&q=80',
      'desc': 'High-fiber biscuits.',
      'category': 'Biscuits',
    },
    {
      'name': 'Coconut Macaroons',
      'price': 50.0,
      'image':
          'https://images.unsplash.com/photo-1597131628347-c769fc631754?w=500&q=80',
      'desc': 'Sweet coconut cookies.',
      'category': 'Biscuits',
    },
    {
      'name': 'Ginger Snaps',
      'price': 35.0,
      'image':
          'https://images.unsplash.com/photo-1600861194802-a2b11076bc51?w=500&q=80',
      'desc': 'Spicy ginger biscuits.',
      'category': 'Biscuits',
    },
    {
      'name': 'Shortbread',
      'price': 60.0,
      'image':
          'https://images.unsplash.com/photo-1530610476181-d83430b64dcd?w=500&q=80',
      'desc': 'Rich buttery shortbread.',
      'category': 'Biscuits',
    },
    {
      'name': 'Vanilla Wafers',
      'price': 20.0,
      'image':
          'https://images.unsplash.com/photo-1599599810694-b5b37304c041?w=500&q=80',
      'desc': 'Crispy vanilla wafers.',
      'category': 'Biscuits',
    },
    {
      'name': 'Cream Crackers',
      'price': 30.0,
      'image':
          'https://images.unsplash.com/photo-1551462147-37885acc3c41?w=500&q=80',
      'desc': 'Light cream crackers.',
      'category': 'Biscuits',
    },
    {
      'name': 'Marie Gold',
      'price': 15.0,
      'image':
          'https://images.unsplash.com/photo-1590080875515-8a3a8dc5735e?w=500&q=80',
      'desc': 'Tea time favorite biscuits.',
      'category': 'Biscuits',
    },

    // --- SPICES ---
    {
      'name': 'Turmeric Powder',
      'price': 45.0,
      'image':
          'https://images.unsplash.com/photo-1615485290382-441e4d0c9cb5?w=500&q=80',
      'desc': 'Pure Turmeric Powder.',
      'category': 'Spices',
    },
    {
      'name': 'Red Chili Powder',
      'price': 55.0,
      'image':
          'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500&q=80',
      'desc': 'Extra hot chili powder.',
      'category': 'Spices',
    },
    {
      'name': 'Black Pepper',
      'price': 80.0,
      'image':
          'https://images.unsplash.com/photo-1509358271058-acd22cc93898?w=500&q=80',
      'desc': 'Whole black peppercorns.',
      'category': 'Spices',
    },
    {
      'name': 'Cumin Seeds',
      'price': 65.0,
      'image':
          'https://images.unsplash.com/photo-1532336414038-cf19250c5757?w=500&q=80',
      'desc': 'Fresh aromatic cumin.',
      'category': 'Spices',
    },
    {
      'name': 'Coriander Powder',
      'price': 40.0,
      'image':
          'https://images.unsplash.com/photo-1514733670139-4d87a19b1773?w=500&q=80',
      'desc': 'Ground coriander seeds.',
      'category': 'Spices',
    },
    {
      'name': 'Cardamom Pods',
      'price': 250.0,
      'image':
          'https://images.unsplash.com/photo-1599940824399-b87987cb9724?w=500&q=80',
      'desc': 'Green cardamom pods.',
      'category': 'Spices',
    },
    {
      'name': 'Cinnamon Sticks',
      'price': 90.0,
      'image':
          'https://images.unsplash.com/photo-1599443015574-be5fe8a38383?w=500&q=80',
      'desc': 'Aromatic cinnamon bark.',
      'category': 'Spices',
    },
    {
      'name': 'Cloves',
      'price': 120.0,
      'image':
          'https://images.unsplash.com/photo-1599940778173-e276d4acb2bb?w=500&q=80',
      'desc': 'Strong flavored cloves.',
      'category': 'Spices',
    },
    {
      'name': 'Fenugreek Seeds',
      'price': 35.0,
      'image':
          'https://images.unsplash.com/photo-1532336414038-cf19250c5757?w=500&q=80',
      'desc': 'Nutritious fenugreek seeds.',
      'category': 'Spices',
    },
    {
      'name': 'Mustard Seeds',
      'price': 25.0,
      'image':
          'https://images.unsplash.com/photo-1615484477778-ca3b77940c25?w=500&q=80',
      'desc': 'Black mustard seeds.',
      'category': 'Spices',
    },

    // --- RICE ---
    {
      'name': 'Basmati Rice',
      'price': 150.0,
      'image':
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&q=80',
      'desc': 'Premium Long Grain Basmati.',
      'category': 'Rice',
    },
    {
      'name': 'Brown Rice',
      'price': 180.0,
      'image':
          'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=500&q=80',
      'desc': 'Healthy brown rice.',
      'category': 'Rice',
    },
    {
      'name': 'Jasmine Rice',
      'price': 160.0,
      'image':
          'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=500&q=80',
      'desc': 'Fragrant Jasmine rice.',
      'category': 'Rice',
    },
    {
      'name': 'Sona Masuri',
      'price': 110.0,
      'image':
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&q=80',
      'desc': 'Standard Sona Masuri rice.',
      'category': 'Rice',
    },
    {
      'name': 'Idli Rice',
      'price': 90.0,
      'image':
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&q=80',
      'desc': 'Rice for making idlis.',
      'category': 'Rice',
    },

    // --- BODY CARE ---
    {
      'name': 'Aloe Face Wash',
      'price': 120.0,
      'image':
          'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=500&q=80',
      'desc': 'Gentle Aloe face wash.',
      'category': 'Body Care',
    },
    {
      'name': 'Lavender Soap',
      'price': 35.0,
      'image':
          'https://images.unsplash.com/photo-1600857544200-b2f666a9a2ec?w=500&q=80',
      'desc': 'Relaxing lavender soap.',
      'category': 'Body Care',
    },
    {
      'name': 'Hand Cream',
      'price': 90.0,
      'image':
          'https://images.unsplash.com/photo-1515377905703-c4788e51af15?w=500&q=80',
      'desc': 'Moisturizing hand cream.',
      'category': 'Body Care',
    },
    {
      'name': 'Sandalwood Soap',
      'price': 40.0,
      'image':
          'https://images.unsplash.com/photo-1546938267-f93504859a67?w=500&q=80',
      'desc': 'Traditional sandalwood soap.',
      'category': 'Body Care',
    },
    {
      'name': 'Herbal Shampoo',
      'price': 180.0,
      'image':
          'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500&q=80',
      'desc': 'Anti-dandruff shampoo.',
      'category': 'Body Care',
    },
    {
      'name': 'Hair Conditioner',
      'price': 200.0,
      'image':
          'https://images.unsplash.com/photo-1592136957897-b2b6ca21e10d?w=500&q=80',
      'desc': 'Silky hair conditioner.',
      'category': 'Body Care',
    },
    {
      'name': 'Body Lotion',
      'price': 250.0,
      'image':
          'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=500&q=80',
      'desc': 'Daily body moisturizer.',
      'category': 'Body Care',
    },
    {
      'name': 'Fresh Deodorant',
      'price': 150.0,
      'image':
          'https://images.unsplash.com/photo-1594122230689-45899d9e6f69?w=500&q=80',
      'desc': 'Long lasting fragrance.',
      'category': 'Body Care',
    },
    {
      'name': 'Toothpaste',
      'price': 60.0,
      'image':
          'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=500&q=80',
      'desc': 'Herbal toothpaste.',
      'category': 'Body Care',
    },
    {
      'name': 'Mouthwash',
      'price': 130.0,
      'image':
          'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=500&q=80',
      'desc': 'Cool mint mouthwash.',
      'category': 'Body Care',
    },

    // --- KITCHEN ITEMS ---
    {
      'name': 'Non-Stick Pan',
      'price': 450.0,
      'image':
          'https://images.unsplash.com/photo-1584946914183-515cc478b033?w=500&q=80',
      'desc': 'Durable non-stick pan.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Steel Spatula',
      'price': 60.0,
      'image':
          'https://images.unsplash.com/photo-1594385208934-2c3b2f9b0c70?w=500&q=80',
      'desc': 'Stainless steel spatula.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Knife Set',
      'price': 350.0,
      'image':
          'https://images.unsplash.com/photo-1593618998160-e34014e67546?w=500&q=80',
      'desc': 'Sharp knife set.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Cutting Board',
      'price': 120.0,
      'image':
          'https://images.unsplash.com/photo-1544967082-d9d25d867d66?w=500&q=80',
      'desc': 'Wooden cutting board.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Steel Whisk',
      'price': 80.0,
      'image':
          'https://images.unsplash.com/photo-1581339393374-9b882310134c?w=500&q=80',
      'desc': 'Steel balloon whisk.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Veggie Peeler',
      'price': 45.0,
      'image':
          'https://images.unsplash.com/photo-1594385208934-2c3b2f9b0c70?w=500&q=80',
      'desc': 'Fruit and vegetable peeler.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Kitchen Grater',
      'price': 110.0,
      'image':
          'https://images.unsplash.com/photo-1581339393374-9b882310134c?w=500&q=80',
      'desc': 'Multi-purpose grater.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Measuring Cups',
      'price': 200.0,
      'image':
          'https://images.unsplash.com/photo-1581339393374-9b882310134c?w=500&q=80',
      'desc': 'Set of measuring cups.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Kitchen Tongs',
      'price': 70.0,
      'image':
          'https://images.unsplash.com/photo-1581339393374-9b882310134c?w=500&q=80',
      'desc': 'Steel kitchen tongs.',
      'category': 'Kitchen Item',
    },
    {
      'name': 'Storage Box',
      'price': 150.0,
      'image':
          'https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500&q=80',
      'desc': 'Airtight food storage.',
      'category': 'Kitchen Item',
    },

    // --- SOAPS & DETERGENTS ---
    {
      'name': 'Detergent Powder',
      'price': 95.0,
      'image':
          'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=500&q=80',
      'desc': 'Stain removing powder.',
      'category': 'Clothes Soap',
    },
    {
      'name': 'Liquid Detergent',
      'price': 150.0,
      'image':
          'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=500&q=80',
      'desc': 'Fabric liquid detergent.',
      'category': 'Clothes Soap',
    },
    {
      'name': 'Fabric Softener',
      'price': 120.0,
      'image':
          'https://images.unsplash.com/photo-1584622781564-1d9876a13d00?w=500&q=80',
      'desc': 'Softening fabric liquid.',
      'category': 'Clothes Soap',
    },
    {
      'name': 'Dish Soap',
      'price': 55.0,
      'image':
          'https://images.unsplash.com/photo-1584622781564-1d9876a13d00?w=500&q=80',
      'desc': 'Dishwashing liquid.',
      'category': 'Kitchen Soap',
    },
    {
      'name': 'Scrub Pad',
      'price': 15.0,
      'image':
          'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=500&q=80',
      'desc': 'Scrubbing pad.',
      'category': 'Kitchen Soap',
    },
    {
      'name': 'Surface Cleaner',
      'price': 110.0,
      'image':
          'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500&q=80',
      'desc': 'Kitchen surface cleaner.',
      'category': 'Kitchen Soap',
    },
    {
      'name': 'Glass Cleaner',
      'price': 90.0,
      'image':
          'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500&q=80',
      'desc': 'Sparkling glass cleaner.',
      'category': 'Kitchen Soap',
    },
    {
      'name': 'Floor Cleaner',
      'price': 140.0,
      'image':
          'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500&q=80',
      'desc': 'Disinfectant floor cleaner.',
      'category': 'Kitchen Soap',
    },
    {
      'name': 'Toilet Cleaner',
      'price': 85.0,
      'image':
          'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500&q=80',
      'desc': 'Deep toilet cleaner.',
      'category': 'Kitchen Soap',
    },
    {
      'name': 'Bar Soap',
      'price': 25.0,
      'image':
          'https://images.unsplash.com/photo-1600857544200-b2f666a9a2ec?w=500&q=80',
      'desc': 'Laundry bar soap.',
      'category': 'Clothes Soap',
    },

    // --- STATIONERY ---
    {
      'name': 'Pencil Set',
      'price': 50.0,
      'image':
          'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=500&q=80',
      'desc': 'Set of 10 HB pencils.',
      'category': 'Pencil',
    },
    {
      'name': 'Mechanical Pencil',
      'price': 40.0,
      'image':
          'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?w=500&q=80',
      'desc': '0.5mm mechanical pencil.',
      'category': 'Pencil',
    },
    {
      'name': 'Gel Pen',
      'price': 20.0,
      'image':
          'https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=500&q=80',
      'desc': 'Quick dry gel pen.',
      'category': 'Pen',
    },
    {
      'name': 'Ball Pen',
      'price': 150.0,
      'image':
          'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500&q=80',
      'desc': 'Premium ballpoint pen.',
      'category': 'Pen',
    },
    {
      'name': 'A5 Notebook',
      'price': 70.0,
      'image':
          'https://images.unsplash.com/photo-1531346878377-a5be20888e57?w=500&q=80',
      'desc': 'A5 size notebook.',
      'category': 'Stationery',
    },
    {
      'name': 'Erasers',
      'price': 15.0,
      'image':
          'https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=500&q=80',
      'desc': 'Dust free erasers.',
      'category': 'Stationery',
    },
    {
      'name': 'Sharpener',
      'price': 10.0,
      'image':
          'https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=500&q=80',
      'desc': 'Steel blade sharpener.',
      'category': 'Stationery',
    },
    {
      'name': 'Plastic Ruler',
      'price': 20.0,
      'image':
          'https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=500&q=80',
      'desc': '30cm plastic ruler.',
      'category': 'Stationery',
    },
    {
      'name': 'Highlighters',
      'price': 100.0,
      'image':
          'https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=500&q=80',
      'desc': 'Set of neon highlighters.',
      'category': 'Stationery',
    },
    {
      'name': 'Glue Stick',
      'price': 30.0,
      'image':
          'https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=500&q=80',
      'desc': 'Fast sticking glue.',
      'category': 'Stationery',
    },

    // --- SNACKS ---
    {
      'name': 'Potato Chips',
      'price': 20.0,
      'image':
          'https://images.unsplash.com/photo-1566478431375-71436a548dee?w=500&q=80',
      'desc': 'Salted potato chips.',
      'category': 'Snacks',
    },
    {
      'name': 'Mixed Nuts',
      'price': 250.0,
      'image':
          'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
      'desc': 'Roasted mixed nuts.',
      'category': 'Snacks',
    },
    {
      'name': 'Popcorn',
      'price': 40.0,
      'image':
          'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=500&q=80',
      'desc': 'Premium kernels.',
      'category': 'Snacks',
    },
    {
      'name': 'Dark Chocolate',
      'price': 80.0,
      'image':
          'https://images.unsplash.com/photo-1511381939415-e44015466834?w=500&q=80',
      'desc': '70% cocoa chocolate.',
      'category': 'Snacks',
    },
    {
      'name': 'Roasted Chickpeas',
      'price': 45.0,
      'image':
          'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
      'desc': 'Healthy salted chickpeas.',
      'category': 'Snacks',
    },
    {
      'name': 'Corn Flakes',
      'price': 120.0,
      'image':
          'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
      'desc': 'Breakfast corn flakes.',
      'category': 'Snacks',
    },
    {
      'name': 'Peanut Butter',
      'price': 160.0,
      'image':
          'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
      'desc': 'Creamy peanut butter.',
      'category': 'Snacks',
    },
    {
      'name': 'Fruit Jam',
      'price': 90.0,
      'image':
          'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
      'desc': 'Mixed fruit jam.',
      'category': 'Snacks',
    },
    {
      'name': 'Energy Bar',
      'price': 50.0,
      'image':
          'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
      'desc': 'Granola energy bar.',
      'category': 'Snacks',
    },
    {
      'name': 'Cookies',
      'price': 30.0,
      'image':
          'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
      'desc': 'Choco chip cookies.',
      'category': 'Snacks',
    },
  ];
});
