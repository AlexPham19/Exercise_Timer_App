import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';

class Promotions extends StatefulWidget {
  @override
  _PromotionsState createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(50.0),
      //   child: MainAppBar(title: 'Promotions', scaffoldKey: _scaffoldKey,),
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color.fromRGBO(245, 58, 95, 1), Colors.white],
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                )),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Khuyến mãi',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Gói Trọn đời',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                    Text(
                      'MIỄN PHÍ MÃI MÃI',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 70),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done,
                                color: Themes.appBarTheme, size: 28),
                            Text(
                              'Bài tập Không giới hạn',
                              style: TextStyle(
                                  color: Themes.appBarTheme,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done,
                                color: Themes.appBarTheme, size: 28),
                            Text(
                              'Mọi tính năng được Mở khóa',
                              style: TextStyle(
                                  color: Themes.appBarTheme,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done,
                                color: Themes.appBarTheme, size: 28),
                            Text(
                              'Không bao giờ Hết hạn',
                              style: TextStyle(
                                  color: Themes.appBarTheme,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done,
                                color: Themes.appBarTheme, size: 28),
                            Text(
                              'Hoàn toàn Miễn phí',
                              style: TextStyle(
                                  color: Themes.appBarTheme,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 32),
                alignment: Alignment.center,
                child: Text(
                  'Hãy tận hưởng! Hãy nói với bạn bè của bạn về chương trình khuyến mãi trước khi nó kết thúc!',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 32),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Themes.appBarTheme,
                ),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text('Tin người vcl')));
                  },
                  child: Center(
                      child: Text(
                    'MỞ KHÓA MIỄN PHÍ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
