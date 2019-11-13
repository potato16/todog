import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:todog/bloc/create_todog_bloc.dart';
import 'package:todog/models/todog_model.dart';

void main() {
  group('test equal method on TodogObject', () {
    test('Two todog object with same id must be equal', () {
      final todog1 = ToDogObj(
          id: '123',
          color: Colors.red.value,
          title: 'This is good',
          duration: 100);
      final todog2 = ToDogObj(
          id: '123',
          color: Colors.blue.value,
          title: 'This is good two',
          duration: 20);
      expect(todog1 == todog2, true);
    });
    test('Two todog object without id must be not equal', () {
      final todog1 = ToDogObj(
          color: Colors.red.value, title: 'This is good', duration: 100);
      final todog2 = ToDogObj(
          color: Colors.blue.value, title: 'This is good two', duration: 20);
      expect(todog1 == todog2, false);
    });
  });

  test('create new todog object with collected info', () {
    final createTodogBloc = CreateToDogBloc();
    final color = Colors.orange.value;
    final duration = 120;
    final title = 'Walk the dog';
    final todogObj = ToDogObj(color: color, duration: duration, title: title);
    createTodogBloc.colorOnChanged(color);
    createTodogBloc.durationOnChanged(duration);
    createTodogBloc.titleOnChanged(title);
    expect(createTodogBloc.createTodoObject().color, todogObj.color);
    expect(createTodogBloc.createTodoObject().duration, todogObj.duration);
    expect(createTodogBloc.createTodoObject().title, todogObj.title);
  });
}
