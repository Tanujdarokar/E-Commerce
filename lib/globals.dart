import 'package:flutter/material.dart';

List<Map<String, dynamic>> globalCartItems = [];
ValueNotifier<int> globalCartCount = ValueNotifier<int>(0);

// Global list for orders
List<Map<String, dynamic>> globalOrders = [];

// Global Theme Notifier
ValueNotifier<ThemeMode> globalThemeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

// Expanded Shared product list with variety for all categories
final List<Map<String, dynamic>> allProducts = [
  // BISCUITS
  {
    'name': 'Chocolate Cookies',
    'price': 30.0,
    'image': 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80',
    'desc': 'Crispy chocolate chip cookies, baked fresh.',
    'category': 'Biscuits',
  },
  {
    'name': 'Butter Biscuits',
    'price': 25.0,
    'image': 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=500&q=80',
    'desc': 'Classic salty and sweet butter biscuits.',
    'category': 'Biscuits',
  },
  {
    'name': 'Oatmeal Cookies',
    'price': 40.0,
    'image': 'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=500&q=80',
    'desc': 'Healthy oatmeal and raisin cookies.',
    'category': 'Biscuits',
  },
  {
    'name': 'Digestive Biscuits',
    'price': 45.0,
    'image': 'https://images.unsplash.com/photo-1590080875515-8a3a8dc5735e?w=500&q=80',
    'desc': 'High-fiber digestive biscuits for health.',
    'category': 'Biscuits',
  },
  
  // SPICES
  {
    'name': 'Turmeric Powder',
    'price': 45.0,
    'image': 'https://images.unsplash.com/photo-1615485290382-441e4d0c9cb5?w=500&q=80',
    'desc': 'Pure Organic Turmeric Powder.',
    'category': 'Spices',
  },
  {
    'name': 'Red Chili Powder',
    'price': 55.0,
    'image': 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500&q=80',
    'desc': 'Extra hot red chili powder.',
    'category': 'Spices',
  },
  {
    'name': 'Whole Black Pepper',
    'price': 80.0,
    'image': 'https://images.unsplash.com/photo-1509358271058-acd22cc93898?w=500&q=80',
    'desc': 'Aromatic whole black peppercorns.',
    'category': 'Spices',
  },
  {
    'name': 'Cumin Seeds',
    'price': 65.0,
    'image': 'https://images.unsplash.com/photo-1532336414038-cf19250c5757?w=500&q=80',
    'desc': 'Fresh and aromatic cumin seeds.',
    'category': 'Spices',
  },
  
  // RICE
  {
    'name': 'Basmati Rice',
    'price': 150.0,
    'image': 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&q=80',
    'desc': 'Premium Long Grain Basmati Rice.',
    'category': 'Rice',
  },
  {
    'name': 'Brown Rice',
    'price': 180.0,
    'image': 'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=500&q=80',
    'desc': 'Healthy unpolished brown rice.',
    'category': 'Rice',
  },
  {
    'name': 'Jasmine Rice',
    'price': 160.0,
    'image': 'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=500&q=80',
    'desc': 'Fragrant and soft Jasmine rice.',
    'category': 'Rice',
  },
  
  // BODY CARE
  {
    'name': 'Aloe Face Wash',
    'price': 120.0,
    'image': 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=500&q=80',
    'desc': 'Gentle Aloe Vera face wash.',
    'category': 'Body Care',
  },
  {
    'name': 'Lavender Soap',
    'price': 35.0,
    'image': 'https://images.unsplash.com/photo-1600857544200-b2f666a9a2ec?w=500&q=80',
    'desc': 'Refreshing Lavender soap.',
    'category': 'Body Care',
  },
  {
    'name': 'Hand Cream',
    'price': 90.0,
    'image': 'https://images.unsplash.com/photo-1515377905703-c4788e51af15?w=500&q=80',
    'desc': 'Moisturizing cream for soft hands.',
    'category': 'Body Care',
  },
  {
    'name': 'Sandalwood Soap',
    'price': 40.0,
    'image': 'https://images.unsplash.com/photo-1546938267-f93504859a67?w=500&q=80',
    'desc': 'Traditional Sandalwood soap.',
    'category': 'Body Care',
  },

  // KITCHEN ITEM
  {
    'name': 'Non-Stick Pan',
    'price': 450.0,
    'image': 'https://images.unsplash.com/photo-1584946914183-515cc478b033?w=500&q=80',
    'desc': 'Durable non-stick pan.',
    'category': 'Kitchen Item',
  },
  {
    'name': 'Steel Spatula',
    'price': 60.0,
    'image': 'https://images.unsplash.com/photo-1594385208934-2c3b2f9b0c70?w=500&q=80',
    'desc': 'Stainless steel kitchen spatula.',
    'category': 'Kitchen Item',
  },
  {
    'name': 'Knife Set',
    'price': 350.0,
    'image': 'https://images.unsplash.com/photo-1593618998160-e34014e67546?w=500&q=80',
    'desc': 'Sharp stainless steel knife set.',
    'category': 'Kitchen Item',
  },

  // CLOTHES SOAP
  {
    'name': 'Detergent Powder',
    'price': 95.0,
    'image': 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=500&q=80',
    'desc': 'Tough stain removing detergent powder.',
    'category': 'Clothes Soap',
  },
  {
    'name': 'Liquid Detergent',
    'price': 150.0,
    'image': 'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=500&q=80',
    'desc': 'Fabric friendly liquid detergent.',
    'category': 'Clothes Soap',
  },
  {
    'name': 'Fabric Softener',
    'price': 120.0,
    'image': 'https://images.unsplash.com/photo-1584622781564-1d9876a13d00?w=500&q=80',
    'desc': 'Leaves clothes soft and smelling fresh.',
    'category': 'Clothes Soap',
  },

  // KITCHEN SOAP
  {
    'name': 'Dish Soap Liquid',
    'price': 55.0,
    'image': 'https://images.unsplash.com/photo-1584622781564-1d9876a13d00?w=500&q=80',
    'desc': 'Lemon fresh dishwashing liquid.',
    'category': 'Kitchen Soap',
  },
  {
    'name': 'Scrub Pad',
    'price': 15.0,
    'image': 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=500&q=80',
    'desc': 'Heavy duty scrub pad for utensils.',
    'category': 'Kitchen Soap',
  },
  {
    'name': 'Kitchen Cleaner',
    'price': 110.0,
    'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500&q=80',
    'desc': 'Multi-surface kitchen cleaner spray.',
    'category': 'Kitchen Soap',
  },

  // STATIONERY (Pencil & Pen)
  {
    'name': 'HB Pencil Set',
    'price': 50.0,
    'image': 'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=500&q=80',
    'desc': 'Set of 10 smooth HB pencils.',
    'category': 'Pencil',
  },
  {
    'name': 'Mechanical Pencil',
    'price': 40.0,
    'image': 'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?w=500&q=80',
    'desc': 'Fine lead 0.5mm mechanical pencil.',
    'category': 'Pencil',
  },
  {
    'name': 'Blue Gel Pen',
    'price': 20.0,
    'image': 'https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=500&q=80',
    'desc': 'Fast drying blue gel ink pen.',
    'category': 'Pen',
  },
  {
    'name': 'Luxury Ball Pen',
    'price': 150.0,
    'image': 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500&q=80',
    'desc': 'Elegant matte finish ballpoint pen.',
    'category': 'Pen',
  },

  // SNACKS
  {
    'name': 'Potato Chips',
    'price': 20.0,
    'image': 'https://images.unsplash.com/photo-1566478431375-71436a548dee?w=500&q=80',
    'desc': 'Classic salted crispy potato chips.',
    'category': 'Snacks',
  },
  {
    'name': 'Mixed Nuts',
    'price': 250.0,
    'image': 'https://images.unsplash.com/photo-1511067007398-7e4b90cfa4bc?w=500&q=80',
    'desc': 'Healthy mix of roasted nuts and raisins.',
    'category': 'Snacks',
  },
  {
    'name': 'Popcorn Kernel',
    'price': 40.0,
    'image': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=500&q=80',
    'desc': 'High quality kernels for popcorn.',
    'category': 'Snacks',
  },
];
