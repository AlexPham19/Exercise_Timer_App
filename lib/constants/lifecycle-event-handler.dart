import 'package:flutter/cupertino.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({required this.inactiveCallBack, required this.resumeCallBack, required this.detachedCallBack});

  final VoidCallback resumeCallBack;
  final VoidCallback detachedCallBack;
  final VoidCallback inactiveCallBack;

//  @override
//  Future<bool> didPopRoute()

//  @override
//  void didHaveMemoryPressure()

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        inactiveCallBack();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        detachedCallBack();
        break;
      case AppLifecycleState.resumed:
        resumeCallBack();
        break;
    }

    print('''
=============================================================
               $state
=============================================================
''');
    //inactiveCallBack();
  }

//  @override
//  void didChangeLocale(Locale locale)

//  @override
//  void didChangeTextScaleFactor()

//  @override
//  void didChangeMetrics();

//  @override
//  Future<bool> didPushRoute(String route)
}