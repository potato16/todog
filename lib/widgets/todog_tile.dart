import 'package:flutter/material.dart';
import 'package:todog/bloc/bloc_helpers/bloc_provider.dart';
import 'package:todog/bloc/todog_list_bloc.dart';
import 'package:todog/models/todog_model.dart';
import 'bottom_border_dashline.dart';
import 'circle_check_box.dart';

class ToDogTile extends StatefulWidget {
  final ToDogObj data;
  ToDogTile({Key key, this.data}) : super(key: key);
  @override
  _ToDogTileState createState() => _ToDogTileState();
}

class _ToDogTileState extends State<ToDogTile> {
  bool _check = false;
  TodogListBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<TodogListBloc>(context);
    _check = widget.data?.timeComplete != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  _getDate(widget.data?.timeComplete),
                  style: TextStyle(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withAlpha(160),
                      fontSize: 14),
                ),
                Text(
                  _getTime(widget.data?.timeComplete),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 5,
            child: CustomPaint(
              painter: BottomBorderDashLine(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
                  decoration: BoxDecoration(
                      color: Color(widget.data?.color ?? 0xFFF68054),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.data?.title ?? '',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 16),
                            ),
                            widget.data?.duration == null
                                ? Container()
                                : SizedBox(
                                    height: 8,
                                  ),
                            widget.data?.duration == null
                                ? Container()
                                : Text(
                                    '${widget.data?.duration} mins',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withAlpha(160),
                                        fontSize: 14),
                                  )
                          ],
                        ),
                      ),
                      CircleCheckbox(
                        activeColor: Colors.white,
                        checkColor: Color(widget.data?.color ?? 0xFFF68054),
                        onChanged: (bool value) {
                          setState(() {
                            _check = value;
                            bloc.checkToDog(
                                MapEntry<String, bool>(widget.data?.id, value));
                          });
                        },
                        value: _check,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getTime(DateTime time) {
    if (time == null) return '';
    return '${time.hour.toString()..padLeft(2, '0')}:${time.minute.toString()..padLeft(2, '0')}';
  }

  String _getDate(DateTime time) {
    if (time == null) return '';
    return '${time.month.toString()..padLeft(2, '0')}/${time.day.toString()..padLeft(2, '0')}';
  }
}
