import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ToDogObj extends Object {
  final String id;
  final String title;
  final int duration; // in minutes
  final DateTime timeComplete;
  final DateTime createdTime;
  final int color;
  ToDogObj(
      {@required this.id,
      this.title,
      this.duration,
      this.timeComplete,
      this.color})
      : createdTime = DateTime.now();
  ToDogObj.fromJson(Map<String, dynamic> json, {String id})
      : id = id,
        title = json['title'],
        duration = json['duration'],
        timeComplete = (json['time_complete'] as Timestamp)?.toDate(),
        createdTime = (json['created_time'] as Timestamp)?.toDate(),
        color = json['color'];
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['duration'] = duration;
    data['time_complete'] =
        timeComplete != null ? Timestamp.fromDate(timeComplete) : null;
    data['color'] = color;
    data['created_time'] = Timestamp.fromDate(createdTime);
    return data;
  }

  @override
  String toString() => toJson().toString();
  @override
  bool operator ==(other) {
    if (other is ToDogObj) {
      return other.id == null ? false : other.id == this.id;
    }
    return false;
  }

  @override
  int get hashCode => createdTime.hashCode;
}
