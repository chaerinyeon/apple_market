// lib/providers/product_provider.dart

import 'package:flutter/foundation.dart';

import '../pages/product_list/product/product.dart';

class ProductProvider with ChangeNotifier {
  int _currentID = 1;
  List<Product> _products = [
    Product(
        id: 10000000,
        name: '아이폰',
        price: 120,
        brand: PhoneBrand.iPhone,
        imageUrl:
            'https://kream-phinf.pstatic.net/MjAyMzEwMTFfMjE2/MDAxNjk2OTg4MzIwOTE0.dg6UAYIYf5oa8XlYs8XJMLoLeFgcgX9le6x_hprkZUwg.MxmZvpMu_raB8BjVx8VGGimyxGwp4ojOryS8dBYXJ-gg.JPEG/a_28596be85bbd44a0b89702b95c060fb6.jpg?type=l_webp'),
    Product(
        id: 200000000,
        name: '삼성폴더폰',
        price: 12,
        brand: PhoneBrand.Samsung,
        imageUrl:
            'https://kream-phinf.pstatic.net/MjAyMzEwMTFfMjE2/MDAxNjk2OTg4MzIwOTE0.dg6UAYIYf5oa8XlYs8XJMLoLeFgcgX9le6x_hprkZUwg.MxmZvpMu_raB8BjVx8VGGimyxGwp4ojOryS8dBYXJ-gg.JPEG/a_28596be85bbd44a0b89702b95c060fb6.jpg?type=l_webp'),
    Product(
        id: 300000000,
        name: '삼성폴더폰',
        price: 12,
        brand: PhoneBrand.Samsung,
        imageUrl:
            'https://kream-phinf.pstatic.net/MjAyMzEwMTFfMjE2/MDAxNjk2OTg4MzIwOTE0.dg6UAYIYf5oa8XlYs8XJMLoLeFgcgX9le6x_hprkZUwg.MxmZvpMu_raB8BjVx8VGGimyxGwp4ojOryS8dBYXJ-gg.JPEG/a_28596be85bbd44a0b89702b95c060fb6.jpg?type=l_webp'),
    Product(
        id: 40000000,
        name: '삼성폴더폰',
        price: 12,
        brand: PhoneBrand.Samsung,
        imageUrl:
            'https://kream-phinf.pstatic.net/MjAyMzEwMTFfMjE2/MDAxNjk2OTg4MzIwOTE0.dg6UAYIYf5oa8XlYs8XJMLoLeFgcgX9le6x_hprkZUwg.MxmZvpMu_raB8BjVx8VGGimyxGwp4ojOryS8dBYXJ-gg.JPEG/a_28596be85bbd44a0b89702b95c060fb6.jpg?type=l_webp')
  ];

// _로 시작하는건 외부에서 접근 불가. 클래스 내부에서만 사용
  final List<Product> _favoriteProducts = [];

  final List<Product> _cartProducts = [];
  //_products 라는 이름의 getter 정의. 이 메서드 호출하면 _products 리스트 반환. 즉 상품 목록을 외부에서 쉽게 접근 가능
  List<Product> get products => _products;
  //favoriteProducts 라는 이름의 getter 정의. 이 메서드 호출하면 _favoriteProducts 반환. 즉 즐겨찾기 한 상품 목록을 외부에서 쉽게 접근 가능
  List<Product> get favoriteProducts => _favoriteProducts;
  List<Product> get cartProducts => _cartProducts;

  void setProducts(List<Product> products) {
    _products = products;
    // _products가 비어있으면 _currentID 값을 _products 리스트에 있는 상품 id 중 가장 큰 값에 1을 더한 값으로 설정
    if (_products.isEmpty) {
      _currentID =
          _products.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
    }
    // _products가 비어있지 않으면 _currentID 값을 1로 설정
    else {
      _currentID = 1;
    }

    // 데이터 변경 알림. 이렇게 하면 상품 목록이 변경될 때 화면도 자동으로 변경됨
    notifyListeners();
  }

  void addProduct({
    required String name,
    required int price,
    required String imageUrl,
    required PhoneBrand brand,
  }) {
    final newProduct = Product(
      id: _currentID,
      name: name,
      price: price,
      imageUrl: imageUrl,
      brand: brand,
    );
    _products.add(newProduct);
    _currentID++;
    notifyListeners();
  }

  void addFavorite(Product product) {
    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
      notifyListeners();
    }
  }

  void addCart(Product product) {
    if (!_cartProducts.contains(product)) {
      _cartProducts.add(product);
      notifyListeners();
    }
  }

  void removeCart(Product product) {
    if (_cartProducts.contains(product)) {
      _cartProducts.remove(product);
      notifyListeners();
    }
  }
}
