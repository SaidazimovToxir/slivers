import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _firstPinned = true;
  bool _secondPinned = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final scrollOffset = _scrollController.offset;
    if (scrollOffset >= 2000.0 && !_secondPinned) {
      setState(() {
        _firstPinned = false;
        _secondPinned = true;
      });
    } else if (scrollOffset < 2000.0 && _secondPinned) {
      setState(() {
        _firstPinned = true;
        _secondPinned = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text("Sliver app bar"),
            centerTitle: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("data"),
            ),
            expandedHeight: 200,
          ),
          SliverPersistentHeader(
            pinned: _firstPinned,
            delegate: _SliverAppBarDelegate(
              minHeight: 60.0,
              maxHeight: 200.0,
              pinnedColor: Colors.red,
              child: Container(
                child: const Center(
                  child: Text("Sliver persion"),
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text("Grid item $index"),
                );
              },
              childCount: 100,
            ),
          ),
          SliverPersistentHeader(
            pinned: _secondPinned,
            delegate: _SliverAppBarDelegate(
              minHeight: 60.0,
              maxHeight: 200.0,
              pinnedColor: Colors.blue,
              child: Container(
                child: const Center(
                  child: Text("Sliver persion 2"),
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text("Grid item $index"),
                );
              },
              childCount: 100,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemExtent: 160.0,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.teal[100 * (index % 9)],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Color pinnedColor;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    required this.pinnedColor,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double opacity = 1.0 - (shrinkOffset / maxExtent);
    Color backgroundColor = pinnedColor;

    return Opacity(
      opacity: overlapsContent ? 1.0 : opacity,
      child: Container(
        color: backgroundColor,
        child: Center(
          child: child,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent ||
        child != (oldDelegate as _SliverAppBarDelegate).child;
  }
}
