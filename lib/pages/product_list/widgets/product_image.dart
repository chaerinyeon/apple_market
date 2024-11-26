import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/product_list/product/product.dart';

class ProductImage extends StatelessWidget {
  final Product product;

  const ProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return _buildProductImage();
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: product.imageUrl.startsWith('assets/') ||
              !product.imageUrl.contains('/')
          ? Image.asset(
              product.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(product.imageUrl),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
    );
  }
}
