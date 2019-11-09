import 'package:flutter/material.dart';
import 'package:todog/todog_colors.dart';
import 'package:todog/utils/to_dog_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ToDogBottomNav(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          actionButton: Container(
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
          items: <Widget>[
            Icon(ToDogFont.list, color: Colors.white),
            Icon(ToDogFont.notdonelist_1, color: Colors.white),
            Icon(ToDogFont.donelist, color: Colors.white),
            Icon(ToDogFont.dog_out, color: Colors.white),
          ]),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(32, 16, 16, 0),
              width: double.infinity,
              height: 140,
              child: Row(
                children: <Widget>[
                  Expanded(
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
                          child: Row(
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
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/dog.png"),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(52))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}

class ToDogBottomNav extends StatefulWidget {
  final Widget actionButton;
  final List<Widget> items;
  final ValueChanged<int> onTap;
  final int currentIndex;

  ToDogBottomNav({
    Key key,
    this.actionButton,
    this.items,
    this.currentIndex = 0,
    this.onTap,
  }) : super(key: key);

  @override
  _ToDogBottomNavState createState() => _ToDogBottomNavState();
}

class _ToDogBottomNavState extends State<ToDogBottomNav> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _createButtons() {
    List<Widget> buttons = List<Widget>();
    for (int i = 0; i < widget.items.length; i++) {
      buttons.add(InkWell(
        child: AnimatedContainer(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: i == widget.currentIndex
                ? Colors.white.withAlpha(60)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.items[i],
          duration: Duration(microseconds: 350),
        ),
        onTap: () {
          if (widget.onTap != null) widget.onTap(i);
        },
      ));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(spreadRadius: -2, blurRadius: 4)
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.actionButton,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _createButtons(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToDogBottomBarItem extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final Function onPressed;
  ToDogBottomBarItem({this.icon, this.label, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[icon, label],
      ),
    );
  }
}
