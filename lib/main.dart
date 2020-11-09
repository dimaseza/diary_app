import 'package:diary_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:diary_app/providers/providers.dart';
import './pages/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: DiaryProvider(),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return OrientationBuilder(
            builder: (ctx, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Diaryku',
                home: DiaryListPage(),
                routes: {
                  AddDiaryPage.routeName: (ctx) => AddDiaryPage(),
                  DetailPage.routeName: (ctx) => DetailPage(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
