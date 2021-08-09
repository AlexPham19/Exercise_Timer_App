import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/constants/notifications-manager.dart';
import 'package:my_first_flutter_app/model/remindTime.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

int soundType = Hive.box('settings')
    .get('soundType'); // 0 la giong noi, 1 la am thanh, con lai la tat

class _SettingsState extends State<Settings> {
  var hiveBox = Hive.box('settings');

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var hiveBoxData = Hive.box('savedData');
  var hiveBoxTime = Hive.box('timeReminded');

  bool isReminded = false;
  bool isPaused = false;
  bool isSoundOn = false;
  String timeReminded = '';

  @override
  void initState() {
    timeReminded = hiveBoxTime.isNotEmpty ? '(' + hiveBoxTime
        .getAt(0)
        .hour
        .toString()
        .padLeft(2, '0') + ":" + hiveBoxTime
        .getAt(0)
        .minute
        .toString()
        .padLeft(2, '0') + ")" : '';
    isPaused = hiveBox.get('isPaused');
    isReminded = hiveBoxData.isNotEmpty && hiveBoxTime.isNotEmpty;
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
        child: MainAppBar(
          title: 'Settings',
          scaffoldKey: _scaffoldKey,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Exercise Guide Sounds",
                                style: Themes.textOptions),
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
                              if (index == 0) {
                                showMessage('Tính năng đang được phát triển!');
                              } else {
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
                                  'Cùng thời gian trong ngày như lần luyện tập trước của bạn ' +
                                      timeReminded,
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
                            onChanged: (value) async {
                              setState(() {
                                if (value == true && hiveBoxData.isNotEmpty) {
                                  DateTime dateTime = hiveBoxData
                                      .getAt(hiveBoxData.length - 1)
                                      .date;
                                  isReminded = value;
                                  if (hiveBoxTime.isEmpty) {
                                    // dòng này để test
                                    //addNotification(DateTime.now().hour, DateTime.now().minute);
                                    // test
                                    addNotification(dateTime.hour, dateTime.minute);
                                  } else {
                                    replaceNotification(
                                        dateTime.hour, dateTime.minute);
                                  }
                                  showMessage(
                                      'Thông báo đang được đặt hàng ngày, lúc ' +
                                          dateTime.hour.toString() +
                                          ":" +
                                          dateTime.minute.toString());
                                  timeReminded = '(' + dateTime.hour.toString() +
                                      ":" +
                                      dateTime.minute.toString() + ')';
                                } else if (value == true && hiveBoxData.isEmpty) {
                                  showMessage('Chưa có dữ liệu!');
                                  timeReminded = '';
                                } else {
                                  isReminded = value;
                                  showMessage('Đã tắt thông báo!');
                                  timeReminded = '';
                                  deleteNotification();
                                }
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
                                //showMessage('Tính năng đang được phát triển!');
                                isPaused = value;
                                hiveBox.put('isPaused', value);
                                if (value == true) {
                                  showMessage(
                                      'Ứng dụng sẽ tạm dừng ngay khi bạn dừng ứng dụng');
                                } else {
                                  showMessage(
                                      'Ứng dụng tự động dừng khi kết thúc hiệp (nghỉ hoặc tập)');
                                }
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
                                showMessage('Tính năng đang được phát triển!');
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

              Container(
                alignment: FractionalOffset.bottomCenter,
                child: Text('Exercise Timer App - v0.1.0'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addNotification(int hour, int minute) {
    hiveBoxTime.add(RemindTime(hour, minute));
    NotificationsManager notificationManager = NotificationsManager.init();
    notificationManager.showNotificationOneTime(hour, minute);
  }

  void replaceNotification(int hour, int minute) {
    hiveBoxTime.deleteAt(0);
    hiveBoxTime.add(RemindTime(hour, minute));

    NotificationsManager notificationManager = NotificationsManager.init();
    cancelAllNotification();
    notificationManager.showNotificationOneTime(hour, minute);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

void deleteNotification() {
  Hive.box('timeReminded').deleteAt(0);
  cancelAllNotification();
}
