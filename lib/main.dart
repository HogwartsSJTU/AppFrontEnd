import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Hogwarts/theme/app_theme.dart';
import 'package:Hogwarts/component/custom_drawer/navigation_home_screen.dart';

// TODO LIST
// TODO 联系我们；登录注册；个人中心；个人信息维护；浏览；设置；颜色语言设置；路由控制；游记管理；组队管理；主页
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Freelancer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xFFFEF9EB),
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => NavigationHomeScreen(),
      },
    );
  }
}
