//import 'dart:html';

import 'package:Hogwarts/component/custom_drawer/navigation_home_screen.dart';
import 'package:Hogwarts/component/design_course/design_course_app_theme.dart';
import 'package:Hogwarts/theme/hotel_app_theme.dart';
import 'package:Hogwarts/utils/StorageUtil.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:Hogwarts/utils/data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Hogwarts/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:Hogwarts/pages/comment.dart';

import 'home.dart';

// TODO 导航待完善
class Detail extends StatefulWidget {
  final spot;

  const Detail({Key key, this.spot}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _ProfileState();
  }
}

class _ProfileState extends State<Detail> with TickerProviderStateMixin {
  final commentNum = 5;
  final noteNum = 5;
  TabController _tabController;
  final List<Tab> tabs = <Tab>[
    new Tab(text: "留言"),
  ];
  final List<Tab> tabs2 = <Tab>[
    new Tab(text: "评论"),
  ];
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  int playstate = 0;

  User user = User(0, '', 0, '', '', '', '', true);

  // TODO 这里是空白图片
  static AudioCache player = AudioCache();
  AudioPlayer audio;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
  }

  play() async {
    audio = await player.play('audio.mp3');
    setState(() {
      playstate = 1;
    });
  }

  pause() async {
    audio.pause();
    setState(() {
      playstate = 0;
    });
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
//    audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      children: [
        Expanded(
            child: CustomScrollView(
          slivers: <Widget>[
            // 头部信息栏
            SliverAppBar(
                leading: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                title: new Text("景点详情",
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400)),
                backgroundColor: Colors.blue,
                pinned: true,
                expandedHeight: 270,
                flexibleSpace: new FlexibleSpaceBar(
                    background: new Container(
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        decoration: new BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.spot['image']),
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.grey.withOpacity(0.7),
                                    BlendMode.darken))),
                        child: new Stack(children: <Widget>[
                          Positioned(
                            top: 220,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: DesignCourseAppTheme.nearlyWhite,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(32.0),
                                    topRight: Radius.circular(32.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: DesignCourseAppTheme.grey
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 16, right: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.spot['name'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          letterSpacing: 0.27,
                                          color:
                                              DesignCourseAppTheme.darkerText,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.volume_up,
                                        color: DesignCourseAppTheme.nearlyBlue
                                            .withOpacity(0.7),
                                        size: 24,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (playstate == 0)
                                            play();
                                          else
                                            pause();
                                        },
                                        icon: playstate == 1
                                            ? Icon(Icons
                                                .pause_circle_filled_outlined)
                                            : Icon(Icons.play_circle_fill),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Positioned(
                            top: 190,
                            right: 35,
                            child: ScaleTransition(
                              alignment: Alignment.center,
                              scale: CurvedAnimation(
                                  parent: animationController,
                                  curve: Curves.fastOutSlowIn),
                              child: Card(
                                  color: DesignCourseAppTheme.nearlyBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  elevation: 10.0,
                                  child: InkWell(
                                    onTap: () {
                                      print(spots[6]["lat"]);
                                      print(spots[6]["lng"]);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  NavigationHomeScreen(
                                                      isNavigate: true,
                                                      fromToLocation: FromToLocation(
                                                          TextEditingController(
                                                              text: spots[6]
                                                                      ["lat"]
                                                                  .toString()),
                                                          TextEditingController(
                                                              text: spots[6]
                                                                      ["lng"]
                                                                  .toString()),
                                                          TextEditingController(
                                                              text: widget
                                                                  .spot["lat"]
                                                                  .toString()),
                                                          TextEditingController(
                                                              text: widget
                                                                  .spot["lng"]
                                                                  .toString())))),
                                          (route) => route == null);
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.solidPaperPlane,
                                          //paperPlane,
                                          color:
                                              DesignCourseAppTheme.nearlyWhite,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ])))),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                  child: Container(
                    color: HotelAppTheme.buildLightTheme().backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: opacity1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  getTimeBoxUI(widget.spot['count'], '打卡'),
                                  getTimeBoxUI(widget.spot['heat'], '热度'),
                                ]),
                                Container(
                                  width: 50,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        widget.spot['rate'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: DesignCourseAppTheme.nearlyBlue,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: opacity2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Text(
                              widget.spot['profile'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 16,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Container(
                    color: HotelAppTheme.buildLightTheme().backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16, left: 16, bottom: 4, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  '到此一游',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              TabBar(
                                isScrollable: true,
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: new BubbleTabIndicator(
                                  indicatorHeight: 25.0,
                                  indicatorColor: Colors.blueAccent,
                                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                ),
                                tabs: tabs,
                                controller: _tabController,
                              ),
                              SizedBox(width: 100, child: Container())
                            ],
                          ),
                        ),
                        SizedBox(
                          height: user.recordCanSee ? 600 : 160,
                          child: TabBarView(
                            controller: _tabController,
                            children: tabs.map((Tab tab) {
//                              if (tab == tabs[0])
//                                return jobList(employerJobList, true);
//                              else
//                                return jobList(employeeJobList, false);
                              return Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: noteNum == 0
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image:
                                                AssetImage('assets/empty.png'),
                                            height: 50,
                                            width: 50,
                                          ),
                                          Text(
                                            "暂无留言",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: Container(),
                                          )
                                        ],
                                      )
                                    : ListView.separated(
                                        itemCount: noteNum,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                Container(
                                                    height: 10.0,
                                                    color: Colors.white),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                              height: 100,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                    offset: const Offset(4, 8),
                                                    blurRadius: 16,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0,
                                                          right: 18.0,
                                                          top: 12.0,
                                                          bottom: 12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                          child: Text(
                                                        '踏破铁鞋无觅处',
                                                      ))
                                                    ],
                                                  )));
                                        },
                                      ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Container(
                    color: HotelAppTheme.buildLightTheme().backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16, left: 16, bottom: 4, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  '景点评价',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              TabBar(
                                isScrollable: true,
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: new BubbleTabIndicator(
                                  indicatorHeight: 25.0,
                                  indicatorColor: Colors.blueAccent,
                                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                ),
                                tabs: tabs2,
                                controller: _tabController,
                              ),
                              SizedBox(width: 100, child: Container())
                            ],
                          ),
                        ),
                        SizedBox(
                          height: user.recordCanSee ? 600 : 160,
                          child: TabBarView(
                            controller: _tabController,
                            children: tabs.map((Tab tab) {
//                              if (tab == tabs[0])
//                                return jobList(employerJobList, true);
//                              else
//                                return jobList(employeeJobList, false);
                              return Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: commentNum == 0
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image:
                                                AssetImage('assets/empty.png'),
                                            height: 50,
                                            width: 50,
                                          ),
                                          Text(
                                            "暂无评论",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: Container(),
                                          )
                                        ],
                                      )
                                    : ListView.separated(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: commentNum,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 18.0,
                                                  backgroundImage: NetworkImage(
                                                      'http://p.qqan.com/up/2020-9/2020941050205581.jpg'),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'lyb',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 10.0),
                                                            Text(
                                                              widget
                                                                  .spot['rate'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17,
//                                                         letterSpacing: 0.27,
                                                                color:
                                                                    DesignCourseAppTheme
                                                                        .grey,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  DesignCourseAppTheme
                                                                      .nearlyBlue,
                                                              size: 22,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 5, 15, 5),
                                                          child: Text(
                                                            '   ' +
                                                                '文档注释中说,他是每个Widget子类所默认拥有的,用来表示该widget对于element的唯一标识,',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        child: Wrap(
                                                            spacing: 5,
                                                            runSpacing: 5,
                                                            children: Boxs()),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                Container(
                                                    height: 10.0,
                                                    color: Colors.white),
                                      ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: opacity3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesignCourseAppTheme.nearlyWhite,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      border: Border.all(
                          color: DesignCourseAppTheme.grey.withOpacity(0.2)),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: DesignCourseAppTheme.nearlyBlue,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: DesignCourseAppTheme.nearlyBlue,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: DesignCourseAppTheme.nearlyBlue
                                .withOpacity(0.5),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Center(
                      child: TextButton(
                        child: Text(
                          '留言',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: DesignCourseAppTheme.nearlyWhite,
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
//                              shape: RoundedRectangleBorder(
//                                  borderRadius:
//                                      BorderRadiusDirectional.circular(10)), //加圆角

                              context: context,
                              isScrollControlled: true,
                              builder: (_) {
                                return SingleChildScrollView(
//                                    height: 300, //定义高度
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                //
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Text(
                                                  "留言板",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: DesignCourseAppTheme
                                                        .nearlyBlack,
                                                  ),
//                                                    textAlign: TextAlign.center,
                                                ),
                                                TextButton(
                                                    onPressed: null,
                                                    child: Text(
                                                      "发布",
                                                      style: TextStyle(
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .nearlyBlue),
                                                    ))
                                              ]),
                                          Container(
                                            padding: EdgeInsets.all(18.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                hintText: '你轻轻地来又悄悄地走，不留下点什么吗？',
                                              ),
                                              maxLines: 8,
                                            ),
                                          ),
                                        ]));
                              });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: DesignCourseAppTheme.nearlyBlue,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: DesignCourseAppTheme.nearlyBlue
                                .withOpacity(0.5),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Center(
                      child: TextButton(
                        child: Text(
                          '评论',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: DesignCourseAppTheme.nearlyWhite,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentScreen()));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }

  List<Widget> Boxs() => List.generate(2, (index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.24,
          height: MediaQuery.of(context).size.width * 0.24,
          alignment: Alignment.center,
          child:
              Image.network('http://p.qqan.com/up/2020-9/2020941050205581.jpg'),
        );
      });

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  User(this.userId, this.name, this.age, this.gender, this.address, this.phone,
      this.description, this.recordCanSee);

  final int userId;
  String name;
  int age;
  String gender;
  String address;
  String phone;
  String description;
  bool recordCanSee;
}
