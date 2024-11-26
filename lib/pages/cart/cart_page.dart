import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/product_list/widgets/data_utils.dart';
import 'package:flutter_application_1/pages/product_list/widgets/product_image.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProducts = Provider.of<ProductProvider>(context).cartProducts;
    final totalPrice = cartProducts.fold<int>(
      0,
      (sum, product) => sum + product.price,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: cartProducts.isEmpty
            ? const Center(
                child: Text('장바구니 상품이 없습니다.'),
              )
            : ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final product = cartProducts[index];
                  return Padding(
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
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15)),
                                const SizedBox(width: 10),
                                Text('|',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15)),
                                const SizedBox(width: 10),
                                Text(product.grade.name,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15)),
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
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text('상품 삭제'),
                                  content: Text('장바구니에서 삭제하시겠습니까?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('취소'),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Provider.of<ProductProvider>(context,
                                                listen: false)
                                            .removeCart(product);
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '"${product.name}" 장바구니 목록에서 제거됨'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      isDestructiveAction: true, // 빨간색으로 표시
                                      child: const Text('삭제'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '총 금액: ${DataUtils.calcToWon(totalPrice)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: cartProducts.isEmpty
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('결제 기능 준비 중입니다.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                '결제하기',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
