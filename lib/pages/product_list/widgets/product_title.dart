// lib/product_widgets/product_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/product_list/product/product.dart';
import 'package:flutter_application_1/pages/product_list/widgets/data_utils.dart';
import 'package:flutter_application_1/pages/product_list/widgets/product_image.dart';
import '../../product_detail/product_detail_page.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ProductImage(product: product),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(product.brand.name,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                      const SizedBox(width: 10),
                      Text('|',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                      const SizedBox(width: 10),
                      Text(product.grade.name,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                      const SizedBox(width: 10),
                      Text('|',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                      const SizedBox(width: 10),
                      Icon(Icons.favorite_outline,
                          color: Colors.black54, size: 15),
                      const SizedBox(width: 5),
                      Text(product.likeCount.toString(),
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                  Text(
                    DataUtils.calcToWon(product.price),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
