import 'package:app_ex/constants.dart';
import 'package:app_ex/widdgets/drawer_section.dart';
import 'package:app_ex/widdgets/musics_section.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isSearching = false;
  String searchTerm = "";

  List<String> filteredList = [];
  final _showFull = GlobalKey<MusicsSectionState>();

  List<String> musicTypeNames = [all.name, silent.name, energy.name];
  List<String> selectTypeNames = [silent.name, energy.name];

  @override
  void initState() {
    _tabController = TabController(
      length: musicTypeNames.length,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(_handleTabSection);
    super.initState();
  }

  _handleTabSection() {
    if (_tabController.indexIsChanging) {
      changeDataTab();
    }
  }

  changeDataTab() {
    setState(() {
      int currentIndex = _tabController.index;
      if (currentIndex == 0) {
        selectTypeNames = [silent.name, energy.name];
      } else {
        selectTypeNames = [musicTypeNames[currentIndex]];
      }
    });
  }

  toggleSearch() {
    setState(() {
      isSearching = !isSearching;
    });
    _tabController.index = 0;
    _showFull.currentState?.updateValue(true);
  }

  void filterList() {
    _showFull.currentState?.updateImage(searchTerm);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerSection(
          data: musicTypeNames,
          onChangeTab: (index) {
            setState(() {
              _tabController.index = index;
              changeDataTab();
            });
          }),
      appBar: AppBar(
        title: isSearching
            ? TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: colorText.primary.color),
                ),
                style: TextStyle(color: colorText.primary.color),
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                    filterList();
                  });
                },
              )
            : Text(
                'Music Streaming',
                style: TextStyle(color: colorText.primary.color),
              ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: toggleSearch,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 200,
              enlargeCenterPage: true,
            ),
            items: [
              for (int i = 0; i < 3; i++)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage("images/music0${i + 1}.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 20),
          TabBar(
            controller: _tabController,
            unselectedLabelColor: colorText.rest.color,
            isScrollable: true,
            indicator: BoxDecoration(
              color: colorText.button.color,
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorText.primary.color,
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.only(left: 10, bottom: 10),
            tabs: [
              for (int i = 0; i < musicTypeNames.length; i++)
                Tab(
                  text: UppCaseFirstWord("${musicTypeNames[i]}"),
                ),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.start,
          ),
          SizedBox(height: 20),
          Center(
            child: [
              for (int i = 0; i < musicTypeNames.length; i++)
                MusicsSection(data: selectTypeNames, key: _showFull),
            ][_tabController.index],
          ),
        ],
      ),
    );
  }
}
