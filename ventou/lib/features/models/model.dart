import 'package:flutter/material.dart';

class ProductModel {
  final String title;
  final String image;
  final String? desc;
  final int price;
  final int phone;
  final Color? catColor;

  const ProductModel({
    required this.title,
    this.catColor,
    required this.image,
    this.desc,
    required this.price,
    required this.phone,
  });
  static List<ProductModel> products() {
    return [
      const ProductModel(
        title: 'assets/shapof.webp',
        catColor: Color(0xFF2C2C2C),
        image: 'assets/shapof.webp',
        phone: 0,
        price: 16000,
      ),
      const ProductModel(
        title: 'Banane plantin',
        catColor: Colors.cyan,
        image: 'assets/sac2.webp',
        phone: 0,
        price: 1250,
      ),
      const ProductModel(
        title: 'Tareau blanc',
        catColor: Color(0xffe5f4f5f),
        image: 'assets/polo.png',
        phone: 0,
        price: 2700,
      ),
      const ProductModel(
        title: 'Ozeille frais',
        catColor: Colors.orangeAccent,
        image: 'assets/sac.webp',
        phone: 0,
        price: 25000,
      ),
      const ProductModel(
        title: 'Follon vert',
        catColor: Color(0xFF2C2C2C),
        image: 'assets/shapof.webp',
        phone: 0,
        price: 17000,
      ),
      const ProductModel(
        title: 'Obergine blanche',
        catColor: Colors.purple,
        image: 'assets/short.jpeg',
        phone: 0,
        price: 8500,
      ),
      const ProductModel(
        title: 'Pasteque',
        catColor: Color(0xFF2C2C2C),
        image: 'assets/talonf.jpg',
        phone: 0,
        price: 1000,
      ),
      const ProductModel(
        title: 'Maîs frais',
        catColor: Colors.green,
        image: 'assets/sac2.webp',
        phone: 0,
        price: 850,
      ),
      const ProductModel(
        title: 'Maîs frais',
        catColor: Colors.green,
        image: 'assets/talonfe.jpg',
        phone: 0,
        price: 850,
      ),
      const ProductModel(
        title: 'Maîs frais',
        catColor: Colors.green,
        image: 'assets/polo.png',
        phone: 0,
        price: 850,
      ),
      const ProductModel(
        title: 'Maîs frais',
        catColor: Colors.green,
        image: 'assets/sandal.jpg',
        phone: 0,
        price: 850,
      ),
    ];
  }
}
