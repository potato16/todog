import 'package:flutter/material.dart';
import 'package:todog/bloc/create_todog_bloc.dart';
import 'package:todog/utils/to_dog_icons.dart';

import '../todog_colors.dart';

class CreateToDogDialog extends StatefulWidget {
  @override
  _CreateToDogDialogState createState() => _CreateToDogDialogState();
}

class _CreateToDogDialogState extends State<CreateToDogDialog> {
  double _slideValue = 0;
  var _color;
  CreateToDogBloc bloc;
  @override
  void initState() {
    bloc = CreateToDogBloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Color(_color ?? Colors.white.value),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Chose color:'),
                StreamBuilder<int>(
                    stream: bloc.color,
                    builder: (context, snapshot) {
                      return DropdownButton(
                        onChanged: (value) {
                          _color = value;
                          bloc.colorOnChanged(_color);
                        },
                        value: _color,
                        items: <DropdownMenuItem>[
                          _buildDropdownMenuItem(ToDogColors.downy),
                          _buildDropdownMenuItem(ToDogColors.anzac),
                          _buildDropdownMenuItem(ToDogColors.valencia),
                        ],
                      );
                    }),
              ],
            ),
            StreamBuilder<int>(
                stream: bloc.duration,
                builder: (context, snapshot) {
                  return Row(
                    children: <Widget>[
                      Text('Duration: ${snapshot.data ?? 0} min(s)'),
                      Expanded(
                        child: Slider(
                          activeColor: Theme.of(context).primaryColor,
                          min: 0,
                          max: 120,
                          onChanged: (double value) {
                            _slideValue = value;
                            bloc.durationOnChanged(_slideValue.toInt());
                          },
                          value: _slideValue,
                        ),
                      )
                    ],
                  );
                }),
            TextField(
              onChanged: bloc.titleOnChanged,
              decoration: InputDecoration(hintText: 'Enter what to do ...'),
            ),
            Center(
              child: StreamBuilder<bool>(
                  stream: bloc.isValidCreate,
                  builder: (context, snapshot) {
                    return RaisedButton.icon(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      icon: Icon(
                        ToDogFont.add,
                        size: 14,
                      ),
                      label: Text('Create to-dog'),
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              bloc.createToDog(true);
                            }
                          : null,
                    );
                  }),
            ),
            StreamBuilder<CreateTodogState>(
              stream: bloc.state,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                if (snapshot.data == CreateTodogState.create) {
                  return LinearProgressIndicator();
                }
                if (snapshot.data == CreateTodogState.done) {
                  Navigator.of(context).maybePop();
                  return Container();
                }

                return Text(
                    "Oops! Sorry, my lord. Please check internet and try again! ");
              },
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem _buildDropdownMenuItem(Color color) {
    return DropdownMenuItem(
      value: color.value,
      child: Container(
        height: 16,
        width: 24,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
                bottomRight: Radius.circular(6))),
      ),
    );
  }
}
