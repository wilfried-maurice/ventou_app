// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ventou/constants/constant.dart';
import 'package:ventou/views/home_view.dart';
import 'package:ventou/views/nav_widget.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavWidget(
        pageIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          elevation: 3,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            // side: const BorderSide(
            //   color: Colors.black,
            //   width: 3,
            // ),
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              maintainState: false,
              allowSnapshotting: false,
              builder: (_) => const HomeView(),
            ),
          ),
          child: Icon(
            Icons.add,
            color: AppColor.kPrimary5,
          ),
        ),
      ),
      body: <Widget>[
        const HomeView(),
        const HomeView(),
        const HomeView(),
        const HomeView(),
      ][selected],
    );
  }
}
