import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<bool> isSelected = [true, false, false];
  bool isReminded = false;
  bool isPaused = false;
  bool isSoundOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(
        currentRoute: '/settings',
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(title: 'Settings', scaffoldKey: _scaffoldKey,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Exercise Guide Sounds",
                          style: Themes.textOptions
                        ),
                      ),
                    ),
                    ToggleButtons(
                      fillColor: Colors.pinkAccent,
                      color: Colors.black,
                      selectedColor: Colors.black,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            if (i != index)
                              isSelected[i] = false;
                            else
                              isSelected[i] = true;
                          }
                        });
                      },
                      isSelected: isSelected,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text("Voices (EN)"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text("Beep sound"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text("Off"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nhắc nhở luyện tập hàng ngày',
                              style: Themes.textOptions),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            width: 300,
                            child: Text(
                              'Cùng thời gian trong ngày như lần luyện tập trước của bạn',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: CupertinoSwitch(
                        value: isReminded,
                        onChanged: (value) {
                          setState(() {
                            isReminded = value;
                          });
                        },
                        activeColor: Colors.pinkAccent,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      width: 300,
                      child: Text('Tạm dừng luyện tập khi tôi rời ứng dụng',
                          style: Themes.textOptions),
                    ),
                    Container(
                      child: CupertinoSwitch(
                        value: isPaused,
                        onChanged: (value) {
                          setState(() {
                            isPaused = value;
                          });
                        },
                        activeColor: Colors.pinkAccent,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      width: 300,
                      child: Text(
                          'Phát âm thanh luyện tập to hơn nhạc nền của tôi',
                          style: Themes.textOptions),
                    ),
                    Container(
                      child: CupertinoSwitch(
                        value: isSoundOn,
                        onChanged: (value) {
                          setState(() {
                            isSoundOn = value;
                          });
                        },
                        activeColor: Colors.pinkAccent,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trợ giúp & Hỏi đáp', style: Themes.textOptions),
                      Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Liên hệ Bộ phận Hỗ trợ',
                          style: Themes.textOptions),
                      Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Khôi phục Mua hàng', style: Themes.textOptions),
                      Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nạp lần đầu ?', style: Themes.textOptions),
                      Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
