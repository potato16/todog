import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todog/bloc/bloc_helpers/bloc_provider.dart';
import 'package:todog/bloc/todog_list_bloc.dart';
import 'package:todog/models/todog_model.dart';
import 'package:todog/todog_colors.dart';
import 'package:todog/utils/to_dog_icons.dart';
import 'package:todog/widgets/create_todog_dialog.dart';
import 'package:todog/widgets/profile_screen.dart';
import 'package:todog/widgets/todog_botnav.dart';
import 'package:todog/widgets/todog_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  int _futureIndex;
  TodogListBloc bloc;
  AnimationController controller;
  Animation<double> translate;

  double _pathDistance = 0;
  bool _block = false;
  @override
  void initState() {
    bloc = TodogListBloc();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 180));
    translate = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: Curves.easeInOut, parent: controller),
    );
    translate
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print(status);
        _block = !(status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed);
        if (status == AnimationStatus.completed) {
          setState(() {
            _selectedIndex = _futureIndex;
            _futureIndex = null;
            controller.reverse();
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        bottomNavigationBar: ToDogBottomNav(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            onActionTap: _onActionTap,
            actionButton: Hero(
              tag: 'createtodog',
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  ToDogFont.add,
                  size: 16,
                  color: ToDogColors.primaryColor,
                ),
              ),
            ),
            items: <Widget>[
              Icon(ToDogFont.list, color: Colors.white),
              Icon(ToDogFont.notdonelist_1, color: Colors.white),
              Icon(ToDogFont.donelist, color: Colors.white),
              Icon(ToDogFont.dog_out, color: Colors.white),
            ]),
        body: Container(
          child: Column(
            children: <Widget>[
              _buildHeader(context),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _getScreen(future: true),
                    Transform.translate(
                      child: _getScreen(),
                      offset: Offset(_pathDistance * translate.value, 0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
      width: double.infinity,
      height: 140,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Icon(
                        ToDogFont.footprint,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'To-Dog',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _getSubtitleHeader()),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Image.asset(
                  "assets/dog.png",
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      if (_block || (_selectedIndex == value)) return;
      _futureIndex = value;
      // final RenderBox containerRenderBox =
      //     _containerKey.currentContext.findRenderObject();
      // final containerPosition = containerRenderBox.localToGlobal(Offset.zero);
      // print(containerPosition);
      // print(context.size.height);
      // final dis = context.size.height - containerPosition.dy;
      // if (dis != 0) {
      //   _pathDistance = dis;
      // }
      _pathDistance = context.size.width;
      controller.forward();
    });
  }

  _onActionTap() {
    showDialog(
        context: context,
        builder: (context) {
          return CreateToDogDialog();
        });
  }

  _getScreen({bool future: false}) {
    if (future) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 14, spreadRadius: -12)
            ],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(52))),
      );
    }
    switch (_selectedIndex) {
      case 0:
        return _buildTodogListScreen(bloc.toDogList);
      case 1:
        return _buildTodogListScreen(bloc.toDogListImcomplete);
      case 2:
        return _buildTodogListScreen(bloc.toDogListComplete);
      case 3:
        return ProfileScreen();
    }
  }

  _buildTodogListScreen(Stream stream) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 14, spreadRadius: -12)],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(52))),
      child: StreamBuilder<List<ToDogObj>>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final data = snapshot.data[index];
                return ToDogTile(
                  key: ValueKey(data.id),
                  data: data,
                );
              },
            );
          }),
    );
  }

  Widget _getSubtitleHeader() {
    switch (_selectedIndex) {
      case 0:
        return Text(
          'All to-dog for the good boy!',
          style: TextStyle(
            color: Colors.white,
          ),
        );
      case 1:
        return Text(
          'Imcomplete to-dog',
          style: TextStyle(
            color: Colors.white,
          ),
        );
      case 2:
        return Text(
          'Completed to-dog! Good boy',
          style: TextStyle(
            color: Colors.white,
          ),
        );
    }
  }

  Widget _buildSubtitleAllScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'TODAY',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          'WEEK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          'MONTH',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
