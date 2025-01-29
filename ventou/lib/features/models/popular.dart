class PopularCategory {
  final String category;
  final String id;

  PopularCategory({this.category = '', this.id = ''});
}

class Product {
  final String title;
  final double star;
  final int sold;
  final double price;
  final String icon;
  final String id;

  Product(
      {this.title = '',
      this.star = 0.0,
      this.sold = 0,
      this.price = 0.0,
      this.icon = '',
      this.id = '0'});
}

final homePopularCategories = [
  PopularCategory(category: 'All', id: '1'),
  PopularCategory(category: 'Chair', id: '2'),
  PopularCategory(category: 'Kitchen', id: '3'),
  PopularCategory(category: 'Table', id: '4'),
  PopularCategory(category: 'Lamp', id: '5'),
  PopularCategory(category: 'Cupboard', id: '6'),
  PopularCategory(category: 'Vase', id: '7'),
  PopularCategory(category: 'Others', id: '8'),
];

final homePopularProducts = [
  Product(
    title: 'Sac',
    star: 4.5,
    sold: 8374,
    price: 120.00,
    icon: 'assets/sac.webp',
  ),
  Product(
    title: 'Shapo mixte',
    star: 4.7,
    sold: 7483,
    price: 145.40,
    icon: 'assets/icons/products/chapo.jpg',
  ),
  Product(
    title: 'Sac femme',
    star: 4.3,
    sold: 6937,
    price: 40.00,
    icon: 'assets/sac4.jpg',
  ),
  Product(
    title: 'Talon Femme',
    star: 4.9,
    sold: 8174,
    price: 55.00,
    icon: 'assets/talonf.jpg',
  ),
  Product(
    title: 'Polo homme',
    star: 4.6,
    sold: 6843,
    price: 65.00,
    icon: 'assets/polo.png',
  ),
  Product(
    title: 'Shapo feminin',
    star: 4.5,
    sold: 7758,
    price: 69.00,
    icon: 'assets/shapof.webp',
  ),
];
