import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_first_flutter_app/model/savedData.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class History extends StatefulWidget {
  static const id = '/history';
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var hiveBox = Hive.box('savedData');

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(
        currentRoute: '/history',
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(title: 'History', scaffoldKey: _scaffoldKey,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: hiveBox.length,
          itemBuilder: (BuildContext context, int index) {
            SavedData data = hiveBox.getAt(index);
            return Container(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(DateFormat.yMd()
                              .add_Hm()
                              .format(data.date)
                              .toString())),
                      Container(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(data.durationSeconds.toString())),
                      Container(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(data.isCustom.toString())),
                    ],
                  ),
                  Container(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Text(
                                              'Bạn có chắc là xóa phần lưu này (vĩnh viễn)?'),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                Hive.box('savedData')
                                                    .deleteAt(index);
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                  ..removeCurrentSnackBar()
                                                  ..showSnackBar(SnackBar(content: Text('Delete successfully!')));
                                              });
                                            },
                                            child: Text('Có')),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Đéo')),
                                      ],
                                    );
                                  });
                            });
                          },
                          child: Icon(Icons.clear)))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
