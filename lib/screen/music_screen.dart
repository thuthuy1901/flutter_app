import 'package:app_ex/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MusicScreen extends StatelessWidget {
  String image;

  MusicScreen(this.image);

  backHomePage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/${image}.jpg"),
                opacity: 0.3,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              "images/${image}.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 10,
                ),
                child: InkWell(
                  onTap: () => backHomePage(context),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorText.background.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: colorText.primary.color,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    image,
                    style: TextStyle(
                      color: colorText.primary.color,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.music_note,
                            color: colorText.star.color,
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
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        unratedColor: colorText.primary.color,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: colorText.star.color,
                        ),
                        onRatingUpdate: (rating) {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum ("pain itself").',
                    style: TextStyle(color: colorText.primary.color),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Play button pressed',
                      style: TextStyle(color: colorText.button.color),
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: colorText.star.color,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: colorText.button.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 50,
                    color: colorText.primary.color,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
