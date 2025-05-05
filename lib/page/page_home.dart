import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:resep_mpasi/page/page_list_data.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> with SingleTickerProviderStateMixin {

  final List<Tab> tabs = <Tab>[
    const Tab(text: "6-8 Bulan"),
    const Tab(text: "9-11 Bulan"),
    const Tab(text: "12-23 Bulan"),
    const Tab(text: ">24 Bulan")
  ];

  TabController? tabController;
  List listImages = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/images/recipes.png',
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text(
              'Resep Mpasi',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff201f1f)
              ),
            ),
          ],
        ),
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14
          ),
          indicator: const BubbleTabIndicator(
            indicatorHeight: 25,
            indicatorColor: Color(0xfff2a100),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs.map((Tab tab) {
          return PageListData(
            strKategori: tab.text!,
          );
        }).toList(),
      ),
    );
  }
}
