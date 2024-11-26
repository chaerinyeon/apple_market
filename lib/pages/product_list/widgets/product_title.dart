import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/product_list/product/product.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../product_detail/product_detail_page.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image, size: 50),
        ),
        title: Row(children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Spacer(),
          Text(
            '${product.price} 만원',
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ]),
        trailing: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            final isFavorited =
                productProvider.favoriteProducts.contains(product);
            return IconButton(
              icon: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                if (isFavorited) {
                  productProvider.removeFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('"${product.name}" 찜 목록에서 제거됨'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  productProvider.addFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('"${product.name}" 찜 됨'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
      ),
    );
  }
}
