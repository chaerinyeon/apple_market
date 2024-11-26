import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/pages/product_list/widgets/data.utils.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/product_list/widgets/product_image.dart';

class ProfilePage extends StatelessWidget {
  final String userid;
  const ProfilePage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userid = authProvider.userid ?? 'Guest';
    final favoriteProducts =
        Provider.of<ProductProvider>(context).favoriteProducts;

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              '프로필',
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                tooltip: '장바구니',
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.person,
                    size: 100,
                    color: Color.fromRGBO(119, 119, 119, 0.196),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          '사용자 ID :',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userid,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )
                      ])),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Center(
                  child: const SizedBox(
                    height: 30,
                  ),
                ),
              ),
              const Text(
                '찜 목록',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              favoriteProducts.isEmpty
                  ? const Center(
                      child: Text('찜한 제품이 없습니다.'),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = favoriteProducts[index];
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
                                                color: Colors.black54,
                                                fontSize: 15)),
                                        const SizedBox(width: 10),
                                        Text('|',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15)),
                                        const SizedBox(width: 10),
                                        Text(product.grade.name,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15)),
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
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: const Text('상품 삭제'),
                                          content: Text('찜 목록에서 삭제하시겠습니까?'),
                                          actions: [
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('취소'),
                                            ),
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                Provider.of<ProductProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeFavorite(product);
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        '"${product.name}" 찜 목록에서 제거됨'),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ),
                                                );
                                              },
                                              isDestructiveAction: true,
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: CupertinoButton(
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("로그아웃"),
                        content: const Text("정말로 로그아웃하시겠습니까?"),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("아니요"),
                          ),
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              '예',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
