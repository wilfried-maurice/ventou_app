import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventou/common/components/product_card.dart';
import 'package:ventou/features/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:ventou/features/bloc/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ventou/features/detail/detail_screen.dart';
import 'package:ventou/features/home/hearder.dart';
import 'package:ventou/features/home/search_field.dart';
import 'package:ventou/features/home/special_offer.dart';
import 'package:ventou/features/home/special_offers_screen.dart';
import 'package:ventou/features/models/popular.dart';

class HomeView extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeView({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final datas = homePopularProducts;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.fromLTRB(12, 24, 12, 0);
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverPadding(
              padding: EdgeInsets.only(top: 24),
              sliver: SliverAppBar(
                pinned: true,
                flexibleSpace: HomeAppBar(),
                backgroundColor: Colors.transparent,
                elevation: 2,
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  ((context, index) => _buildBody(context)),
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: _buildPopulars(),
            ),
            const SliverAppBar(flexibleSpace: SizedBox(height: 14))
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SearchField(),
        SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),
        const SizedBox(height: 14),
        // MostPopularTitle(onTapseeAll: () => _onTapMostPopularSeeAll(context)),
        // const SizedBox(height: 24),
        // const MostPupularCategory(),
      ],
    );
  }

  Widget _buildPopulars() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 185,
        mainAxisSpacing: 11,
        crossAxisSpacing: 11,
        mainAxisExtent: 285,
      ),
      delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: 30),
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = datas[index % datas.length];
    return ProductCard(
      data: data,
      ontap: (data) => Navigator.pushNamed(context, ShopDetailScreen.route()),
    );
  }

  // void _onTapMostPopularSeeAll(BuildContext context) {
  //   // Navigator.pushNamed(context, MostPopularScreen.route());
  // }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.pushNamed(context, SpecialOfferScreen.route());
  }
}
