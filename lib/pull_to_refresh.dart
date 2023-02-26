import 'dart:async';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home:PullToRefreshDemo(),));
}

class PullToRefreshDemo extends StatefulWidget {
  @override
  _PullToRefreshDemoState createState() => _PullToRefreshDemoState();
}

class _PullToRefreshDemoState extends State<PullToRefreshDemo>
    with TickerProviderStateMixin {
  late final TabController primaryTC;
  int _length1 = 50;
  final int _length2 = 50;
  DateTime lastRefreshTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    primaryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/bg.jpg"), fit: BoxFit.cover),
          ),child: Scaffold(backgroundColor: Colors.transparent,body: _buildScaffoldBody())),
    );
  }

  Widget _buildScaffoldBody() {
    return ExtendedNestedScrollView(
      headerSliverBuilder: (BuildContext c, bool f) {
        return <Widget>[
          SliverAppBar(
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
          )
        ];
      },
      //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
      pinnedHeaderSliverHeightBuilder: () {
        return 0;
      },
      body: Column(
        children: <Widget>[
          TabBar(
            controller: primaryTC,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            isScrollable: false,
            unselectedLabelColor: Colors.grey,
            tabs: const <Tab>[
              Tab(text: 'Tab0'),
              Tab(text: 'Tab1'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: primaryTC,
              children: <Widget>[
                RefreshIndicator(
                  color: Colors.blue,
                  onRefresh: () {
                    return Future<bool>.delayed(
                        const Duration(
                          seconds: 1,
                        ), () {
                      setState(() {
                        _length1 += 10;
                        lastRefreshTime = DateTime.now();
                      });
                      return true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                    child: ListView.builder(
                      //store Page state
                      key: const PageStorageKey<String>('Tab0'),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext c, int i) {
                        return Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          child: Text(const Key('Tab0').toString() +
                              ': ListView$i of $_length1 $lastRefreshTime'),
                        );
                      },
                      itemCount: _length1,
                      padding: const EdgeInsets.all(0.0),
                    ),
                  ),
                ),
                RefreshIndicator(
                  color: Colors.blue,
                  onRefresh: () {
                    return Future<bool>.delayed(
                        const Duration(
                          seconds: 1,
                        ), () {
                      setState(() {
                        _length1 += 10;
                        lastRefreshTime = DateTime.now();
                      });
                      return true;
                    });
                  },
                  child: ListView.builder(
                    //store Page state
                    key: const PageStorageKey<String>('Tab1'),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext c, int i) {
                      return Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child: Text(const Key('Tab1').toString() +
                            ': ListView$i of $_length2 $lastRefreshTime'),
                      );
                    },
                    itemCount: _length2,
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
