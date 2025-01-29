import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventou/features/models/model.dart';

class DetailArticle extends StatelessWidget {
  final ProductModel product;

  const DetailArticle(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
          expandedHeight: 300,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              product.image,
              fit: BoxFit.cover,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Container(
              height: 33,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14.0),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  child: Row(
                    children: [
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        height: 5.0,
                        width: 5.0,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Text('Publier il y a 2h'),
                    ],
                  ),
                ),
                const SizedBox(height: 14.0),
                Text(
                  product.price.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Commandez",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
