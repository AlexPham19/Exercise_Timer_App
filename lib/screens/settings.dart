import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/screens/promotions.dart';
import 'package:my_first_flutter_app/screens/try-premium.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}
int soundType = Hive.box('settings').get('soundType'); // 0 la giong noi, 1 la am thanh, con lai la tat
class _SettingsState extends State<Settings> {
  var hiveBox = Hive.box('settings');

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isReminded = false;
  bool isPaused = false;
  bool isSoundOn = false;

  @override
  void initState() {
    super.initState();
  }
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
                          if(index == 0){
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text('Tính năng đang được phát triển!')));
                          }
                          else{
                            soundType = index;
                            hiveBox.put('soundType', soundType);
                            print(hiveBox.get('soundType'));
                          }
                        });
                      },
                      isSelected: [
                        soundType == 0,
                        soundType == 1,
                        soundType == 2,
                      ],
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
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text('Tính năng đang được phát triển!')));
                            //isReminded = value;
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
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text('Tính năng đang được phát triển!')));
                            //isPaused = value;
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
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text('Tính năng đang được phát triển!')));
                            //isSoundOn = value;
                          });
                        },
                        activeColor: Colors.pinkAccent,
                      ),
                    )
                  ],
                ),
              ),

    //  ----------------------------- CÒN NHỮNG THỨ DƯỚI THÌ CHƯA CẦN THIẾT ----------------------- //
              // InkWell(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 16.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Trợ giúp & Hỏi đáp', style: Themes.textOptions),
              //         Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
              //       ],
              //     ),
              //   ),
              // ),
              // InkWell(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 16.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Liên hệ Bộ phận Hỗ trợ',
              //             style: Themes.textOptions),
              //         Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
              //       ],
              //     ),
              //   ),
              // ),
              // InkWell(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 16.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Khôi phục Mua hàng', style: Themes.textOptions),
              //         Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
              //       ],
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: (){
              //     Navigator.pushNamed(context, TryPremium.id);
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 16.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Nạp lần đầu ?', style: Themes.textOptions),
              //         Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent,),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
