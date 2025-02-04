import 'package:flutter/material.dart';
import 'package:ventou/features/models/popular.dart';

typedef ProductCardOnTaped = void Function(Product data);

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.data, this.ontap});

  final Product data;
  final ProductCardOnTaped? ontap;

  @override
  Widget build(BuildContext context) {
    // final data = datas[index % datas.length];
    const borderRadius = BorderRadius.all(Radius.circular(12));
    return InkWell(
      onTap: () => ontap?.call(data),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.white,
            ),
          ],
          borderRadius: borderRadius,
          border: Border.all(
            color: const Color(0xFFedeeee),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft:
                    borderRadius.topLeft, // Bordure arrondie en haut à gauche
                topRight:
                    borderRadius.topRight, // Bordure arrondie en haut à droite
              ),
              child: Stack(
                children: [
                  Image.asset(
                    data.icon,
                    width: 182,
                    height: 182,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Image.asset(
                      'assets/icons/not_collected@2x.png',
                      width: 21,
                      height: 21,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: FittedBox(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    color: Color(0xFF2E384D),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: _buildSoldPoint(4.5, 6937),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                '${data.price.toStringAsFixed(2)} Fcfa',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSoldPoint(double star, int sold) {
    return Row(
      children: [
        // Image.asset('assets/icons/start@2x.png', width: 20, height: 20),
        // const SizedBox(width: 8),
        // Text(
        //   '$star',
        //   style: const TextStyle(
        //     color: Color(0xFF616161),
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // const SizedBox(width: 8),
        const Text(
          'Ref',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E384D),
              fontSize: 14),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: const Color(0xFF2E384D).withAlpha(7),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            '$sold',
            style: const TextStyle(
              color: Color(0xFF35383F),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
