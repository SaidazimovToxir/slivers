import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool popular = true;
  bool fashion = false;

  @override
  void initState() {
    super.initState();
    popular = true;
    fashion = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: _buildAppBarIcon(Icons.arrow_back_ios_new_rounded),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: _buildAppBarIcon(CupertinoIcons.ellipsis_vertical),
              ),
            ],
            pinned: true,
            title: const Text(
              "Order Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    _buildTopContainer(),
                    _buildImageContainer(),
                  ],
                ),
              ),
            ),
          ),
          _buildHeader("Popular", popular),
          _buildGridContent(10),
          _buildHeader("Men's Fashion", fashion),
          _buildListContent(10),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildTopContainer() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Color(0xffDED9D5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      height: 70,
    );
  }

  Widget _buildImageContainer() {
    return Expanded(
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        child: Image.asset(
          "images/boy.png",
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget _buildHeader(String title, bool pinned) {
    return SliverPersistentHeader(
      pinned: pinned,
      delegate: _HeaderDelegate(
        minHeight: 50,
        maxHeight: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "See all",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridContent(int itemCount) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 7) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                popular = true;
                fashion = false;
              });
            });
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset("images/boy.png"),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$ 26.15"),
                      Icon(Icons.favorite_border),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Pull & bear men's Zara",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
        childCount: itemCount,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        childAspectRatio: .6,
      ),
    );
  }

  Widget _buildListContent(int itemCount) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 7) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                popular = false;
                fashion = true;
              });
            });
          }
          return Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                    child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(
                    "images/boy2.png",
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                )),
              ],
            ),
          );
        },
        childCount: itemCount,
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent;
  }
}
