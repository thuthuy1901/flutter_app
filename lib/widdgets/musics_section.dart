import 'package:app_ex/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../screen/music_screen.dart';

class MusicsSection extends StatefulWidget {
  final List<String> data;
  MusicsSection({required this.data, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MusicsSectionState();
  }
}

class MusicsSectionState extends State<MusicsSection> {
  bool isLove = false;
  bool isShowFull = false;

  List<MusicType> musicTypes = [silent, energy];
  List<String> selectMusics = ["silent", "energy"];

  List<String> images = [];
  String valueSearch = "";

  @override
  void initState() {
    super.initState();
    _handleSelectImage(selectMusics);
    print(images);
  }

  @override
  void didUpdateWidget(covariant MusicsSection oldWidget) {
    selectMusics = widget.data;
    _handleSelectImage(selectMusics);
    if (valueSearch != "") {
      List<String> tempList = images;
      images = tempList
          .where((music) =>
              music.toLowerCase().contains(valueSearch.toLowerCase()))
          .toList();
    }
    valueSearch = "";
  }

  _handleSelectImage(select) {
    images.clear();
    for (String selectMusic in selectMusics) {
      MusicType selectMusicTypes =
          musicTypes.firstWhere((type) => type.name == selectMusic);
      images.addAll(selectMusicTypes.names);
    }
  }

  toggleListMenu() {
    setState(() {
      isShowFull = !isShowFull;
    });
  }

  toggleLove() {
    setState(() {
      isLove = !isLove;
    });
  }

  switchMusicScreen(data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicScreen(data),
      ),
    );
  }

  updateValue(bool newValue) {
    setState(() {
      isShowFull = newValue;
    });
  }

  updateImage(String search) {
    setState(() {
      valueSearch = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isShowFull)
          CarouselSlider(
            options: CarouselOptions(
              height: 440,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: [
              for (int i = 0; i < 3; i++)
                InkWell(
                  onTap: () {
                    switchMusicScreen(images[i]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/${images[i]}.jpg",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${images[i]}",
                                style: TextStyle(
                                  color: colorText.primary.color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: toggleLove,
                                    child: Icon(
                                      Icons.music_note,
                                      color: isLove
                                          ? colorText.star.color
                                          : colorText.rest.color,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Love",
                                    style: TextStyle(
                                      color: colorText.primary.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          images[i],
                          style: TextStyle(
                            color: colorText.primary.color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        if (isShowFull)
          Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: images.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(
                      "${images[i]}",
                      style: TextStyle(color: colorText.primary.color),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("images/${images[i]}.jpg"),
                    ),
                    onTap: () {
                      switchMusicScreen(images[i]);
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: toggleListMenu,
                  child: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: colorText.button.color,
                  ),
                ),
              ),
            ],
          ),
        if (!isShowFull)
          ElevatedButton(
            onPressed: toggleListMenu,
            child: Icon(
              Icons.add,
              color: colorText.button.color,
            ),
          )
      ],
    );
  }
}
