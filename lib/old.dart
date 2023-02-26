import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const WhatsAppAppbar());
}

class WhatsAppAppbar extends StatelessWidget {
  const WhatsAppAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/bg.jpg"), fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    const SliverAppBar(
                      title: Text("Whatsapp"),
                      centerTitle: false,
                      automaticallyImplyLeading: false,
                      floating: true,
                      backgroundColor: Colors.grey,
                      actions: [
                        Icon(Icons.search, size: 30, color: Colors.white),
                        SizedBox(width: 10),
                        Icon(Icons.more_vert, size: 30, color: Colors.white),
                      ],
                      elevation: 0.0,
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 5,
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: WhatsappTabs(50.0),
                    ),
                  ];
                },
                body: TabBarView(
                  children: tabs.map(
                        (String name) {
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: CustomPaint(
                              size: const Size(double.infinity, 16),
                              painter: MyCustomPainter(),
                            ),
                          ),
                          const SliverPadding(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, bottom: 14, top: 0),
                            sliver: Messages(),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final painter = Paint()..color = Colors.grey;

  @override
  void paint(Canvas canvas, Size size) {
    final leftPath = Path()
      ..lineTo(size.height, 0)
      ..arcToPoint(Offset(0, size.height),
          radius: Radius.circular(size.height), clockwise: false);
    final rightPath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width - size.height, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(size.height));
    canvas.drawPath(leftPath, painter);
    canvas.drawPath(rightPath, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class WhatsappTabs extends SliverPersistentHeaderDelegate {
  final double size;

  WhatsappTabs(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      height: size,
      child: const TabBar(
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BubbleTabIndicator(
            indicatorHeight: 32.0,
            indicatorColor: Colors.blueAccent,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            // Other flags
            // indicatorRadius: 1,
            // insets: EdgeInsets.all(1),
            padding: EdgeInsets.symmetric(horizontal: 30)),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        // isScrollable: true,
        tabs: <Widget>[
          Tab(text: "Chat"),
          Tab(text: "Call"),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(WhatsappTabs oldDelegate) {
    return oldDelegate.size != size;
  }
}

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          if (index > 35) {
            return null;
          }

          if (index == 0) {
            return const ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              tileColor: Colors.white,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
              ),
              title: Text("Mr. H"),
              subtitle: Text("Hey there, look at the appbar"),
            );
          } else if (index == 35) {
            return const ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              tileColor: Colors.white,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
              ),
              title: Text("Mr. H"),
              subtitle: Text("Hey there, look at the appbar"),
            );
          }

          return ListTile(
            tileColor: Colors.white,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
            ),
            title: Text("Mr. H $index"),
            subtitle: Text("Hey there, look at the appbar"),
          );
        },
      ),
    );
  }
}
