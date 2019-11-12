import 'package:flutter/material.dart';

class ToDogBottomNav extends StatefulWidget {
  final Widget actionButton;
  final List<Widget> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final Function onActionTap;

  ToDogBottomNav({
    Key key,
    this.actionButton,
    this.items,
    this.currentIndex = 0,
    this.onTap,
    this.onActionTap,
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
              InkWell(onTap: widget.onActionTap, child: widget.actionButton),
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
