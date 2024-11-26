// lib/pages/product_list/project_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/add_product/add_product_page.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:flutter_application_1/pages/product_list/product/product.dart';
import 'package:flutter_application_1/pages/product_list/widgets/filter_dropdown.dart';

import 'package:flutter_application_1/pages/product_list/widgets/product_title.dart';
import 'package:flutter_application_1/pages/product_list/widgets/profile.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProductListPage> {
  PhoneBrand? _selectedBrand;
  PhoneGrade? _selectedGrade;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    //상품 목록 가져오기
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.apple,
              color: Colors.red,
            ),
            Text(
              '사과마켓',
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text('장바구니 버튼 클릭됨')),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: '장바구니',
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: '프로필',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilePage(
                          userid: '',
                        )),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Products',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FilterDropdown(
              selectedBrand: _selectedBrand,
              selectedGrade: _selectedGrade,
              onBrandChanged: (PhoneBrand? newBrand) {
                setState(() {
                  _selectedBrand = newBrand;
                });
              },
              onGradeChanged: (PhoneGrade? newGrade) {
                setState(() {
                  _selectedGrade = newGrade;
                });
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: products.isEmpty
                ? const Center(child: Text('No products available'))
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      if (_selectedBrand != null &&
                          product.brand != _selectedBrand) {
                        return const SizedBox.shrink();
                      }
                      if (_selectedGrade != null &&
                          product.grade != _selectedGrade) {
                        return const SizedBox.shrink();
                      }
                      if (_searchQuery.isNotEmpty &&
                          !product.name
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase())) {
                        return const SizedBox.shrink();
                      }
                      return ProductTile(product: product);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductPage.routeName);
        },
        // backgroundColor: Colors.red,
        // foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}
