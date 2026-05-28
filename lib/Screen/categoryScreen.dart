import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_vinaya_ecommerce/Screen/mainProductScreen.dart';
import 'package:k_vinaya_ecommerce/providers.dart';

class CategoryScreen extends ConsumerWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Biscuits", "icon": Icons.cookie, "color": Colors.orange, "image": "https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=200&q=80"},
    {"name": "Clothes Soap", "icon": Icons.wash, "color": Colors.blue, "image": "https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=200&q=80"},
    {"name": "Kitchen Soap", "icon": Icons.flatware, "color": Colors.green, "image": "https://images.unsplash.com/photo-1584622781564-1d9876a13d00?w=200&q=80"},
    {"name": "Spices", "icon": Icons.grain, "color": Colors.red, "image": "https://images.unsplash.com/photo-1615485290382-441e4d0c9cb5?w=200&q=80"},
    {"name": "Pencil", "icon": Icons.edit, "color": Colors.brown, "image": "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=200&q=80"},
    {"name": "Pen", "icon": Icons.history_edu, "color": Colors.blueGrey, "image": "https://images.unsplash.com/photo-1585336261022-69c66d11efcc?w=200&q=80"},
    {"name": "Body Care", "icon": Icons.self_improvement_outlined, "color": Colors.pink, "image": "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=200&q=80"},
    {"name": "Snacks", "icon": Icons.fastfood, "color": Colors.amber, "image": "https://images.unsplash.com/photo-1566478431375-71436a548dee?w=200&q=80"},
  ];

  CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Explore Categories",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Find everything you need in one place",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = categories[index];
                  final productCount = allProducts
                      .where((p) => p['category'] == item['name'])
                      .length;

                  return Hero(
                    tag: 'category_${item['name']}',
                    child: GestureDetector(
                      onTap: () {
                        final filteredProducts = allProducts
                            .where((p) => p['category'] == item['name'])
                            .toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailScreen(
                              categoryName: item['name'],
                              categoryProducts: filteredProducts,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: item['color'].withOpacity(0.15),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              // Decorative Background Circle
                              Positioned(
                                top: -20,
                                right: -20,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: item['color'].withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: item['color'].withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        item['icon'],
                                        color: item['color'],
                                        size: 30,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C3E50),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "$productCount Products",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Text(
                                          "View All",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: item['color'],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 14,
                                          color: item['color'],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: categories.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCategoryDialog(context),
        backgroundColor: const Color(0xFFE67E22),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          "New Category",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Add New Category"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Category Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Note: This category will be added locally for this session.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE67E22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
