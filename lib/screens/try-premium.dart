import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';

class TryPremium extends StatefulWidget {
  static const id = '/try-premium';

  @override
  _TryPremiumState createState() => _TryPremiumState();
}

class _TryPremiumState extends State<TryPremium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromRGBO(245, 58, 95, 1),
                      Colors.white
                    ],
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
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
                              'Gói cao cấp',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          child: Text(
                            'Được tập luyện không giới hạn và lưu lịch sử vào đám mây',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                      Text(
                        'Bắt đầu dùng thử 1 tuần miễn phí',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
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
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 32),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sau đó, chỉ ',
                      ),
                      Text(
                        '47.000đ ',
                        style: TextStyle(color: Themes.appBarTheme),
                      ),
                      Text(
                        'mỗi tháng.',
                      ),
                    ],
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
                    onTap: () {},
                    child: Center(
                        child: Text(
                      'Đăng kí 1 tuần MIỄN PHÍ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromRGBO(253, 224, 229, 1),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gói Trọn đời ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' 219.000đ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Themes.appBarTheme,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                        text:
                            'Đăng ký này tự động gia hạn với giá 47.000 đ một tháng sau 1 tuần dùng thư miễn phí. Bạn có thể hủy bỏ bất cứ lúc nào. Bằng cách đăng ký dùng thử miễn phí, bạn đồng ý với ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Điều khoản dịch vụ',
                              style: TextStyle(color: Themes.appBarTheme),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                              text: ' và ',
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: 'Chính sách Quyền Riêng Tư',
                              style: TextStyle(
                                color: Themes.appBarTheme,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                              text: ' của công ty X.',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                        ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Text(
                    'Thanh toán sẽ được tính vào tài khoản Apple ID của bạn khi xác nhận mua hàng. Đăng ký sẽ tự động gia hạn trừ khi bị hủy ít nhất 24 giờ trước khi kết thúc kỳ hạn hiện tại. Tài khoản của bạn sẽ bị tính phí gia hạn trong vòng 24 giờ trước khi kết thúc kỳ hạn hiện tại. Bạn có thể quản lý và hủy đăng ký của mình bằng cách vào mục cài đặt tài khoản App Store sau khi mua.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
