import 'package:app_ex/constants.dart';
import 'package:flutter/material.dart';

class DrawerSection extends StatelessWidget {
  final List<String> data;
  final Function(int) onChangeTab;

  DrawerSection({required this.data, required this.onChangeTab});

  closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Drawer(
        backgroundColor: colorText.second.color,
        child: ListView(
          children: [
            Container(
              height: 90,
              child: DrawerHeader(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menus',
                      style: TextStyle(
                        color: colorText.primary.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: colorText.button.color,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(right: 10),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.close,
                          color: colorText.primary.color,
                        ),
                        onPressed: () {
                          closeDrawer(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (int i = 0; i < data.length; i++)
              ListTile(
                title: Text(
                  UppCaseFirstWord(data[i]),
                  style: TextStyle(
                    color: colorText.primary.color,
                  ),
                ),
                onTap: () {
                  closeDrawer(context);
                  onChangeTab(i);
                },
              ),
          ],
        ),
      ),
    );
  }
}
