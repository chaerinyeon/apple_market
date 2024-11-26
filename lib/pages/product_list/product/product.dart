// ignore: constant_identifier_names
// ignore_for_file: constant_identifier_names, duplicate_ignore

enum PhoneBrand { Samsung, iPhone }

enum PhoneGrade {
  UNOPENED, // 미개봉
  S_GRADE, // S급
  A_GRADE, // A급
  B_GRADE, // B급
}

class Product {
  final int id;
  final String name;
  final int price;
  final PhoneBrand brand;
  final String imageUrl;
  final PhoneGrade grade;
  final int likeCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.brand,
    required this.imageUrl,
    required this.grade,
    required this.likeCount,
  });

//두 상품이 같은 상품인지 판별
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

//두 상품이 같은 id를 가질 경우 같은 해시코드를 갖도록 해준다. 상품 효율적으로 찾기위해서..
  @override
  int get hashCode => id.hashCode;
}
