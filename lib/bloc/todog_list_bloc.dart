import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';
import 'package:todog/bloc/bloc_helpers/bloc_provider.dart';
import 'package:todog/models/todog_model.dart';

class TodogListBloc extends BlocBase {
  final BehaviorSubject<List<ToDogObj>> _todogListController =
      BehaviorSubject<List<ToDogObj>>();
  Stream<List<ToDogObj>> get toDogList => _todogListController.stream;
  final BehaviorSubject<List<ToDogObj>> _todogListImcompleteController =
      BehaviorSubject<List<ToDogObj>>();
  Stream<List<ToDogObj>> get toDogListImcomplete =>
      _todogListImcompleteController.stream;
  final BehaviorSubject<List<ToDogObj>> _todogListCompleteController =
      BehaviorSubject<List<ToDogObj>>();
  Stream<List<ToDogObj>> get toDogListComplete =>
      _todogListCompleteController.stream;
  final BehaviorSubject<MapEntry<String, bool>> _checkToDogController =
      BehaviorSubject<MapEntry<String, bool>>();
  Function(MapEntry<String, bool>) get checkToDog =>
      _checkToDogController.sink.add;
  @override
  void dispose() {
    _todogListController.close();
    _checkToDogController.close();
    _todogListImcompleteController.close();
    _todogListCompleteController.close();
  }

  TodogListBloc() {
    _fetchToDogList();
    // _fetchToDogImcompleteList();
    // _fetchToDogCompletedList();
    _checkToDogController.stream.listen(_handleCheckToDo);
  }

  void _fetchToDogList() {
    Firestore.instance
        .collection('todogs')
        .orderBy('created_time', descending: true)
        .snapshots()
        .listen((snap) {
      List<ToDogObj> todogs = snap.documents
          .map((f) => ToDogObj.fromJson(f.data, id: f.documentID))
          .toList();
      _todogListController.sink.add(todogs);
      _todogListCompleteController.sink
          .add(todogs.where((test) => test.timeComplete != null).toList());
      _todogListImcompleteController.sink
          .add(todogs.where((test) => test.timeComplete == null).toList());
    });
    // Firestore.instance
    //     .collection('todogs')
    //     .orderBy('created_time', descending: true)
    //     .snapshots()
    //     .listen((snap) => _todogListController.sink.add(snap.documents
    //         .map((f) => ToDogObj.fromJson(f.data, id: f.documentID))
    //         .toList()));
  }

  void _handleCheckToDo(MapEntry<String, bool> event) {
    assert(event != null);
    assert(event.key != null);
    assert(event.value != null);
    Firestore.instance
        .collection('todogs')
        .document(event.key)
        .updateData({'time_complete': event.value ? Timestamp.now() : null});
  }

  // void _fetchToDogImcompleteList() {
  //   Firestore.instance
  //       .collection('todogs')
  //       .where('time_complete', isNull: true)
  //       .snapshots()
  //       .listen((snap) => _todogListImcompleteController.sink.add(snap.documents
  //           .map((f) => ToDogObj.fromJson(f.data, id: f.documentID))
  //           .toList()));
  // }

  // void _fetchToDogCompletedList() {
  //   Firestore.instance
  //       .collection('todogs')
  //       .where('time_complete', isGreaterThanOrEqualTo: Timestamp(100, 100))
  //       .snapshots()
  //       .listen((snap) => _todogListCompleteController.sink.add(snap.documents
  //           .map((f) => ToDogObj.fromJson(f.data, id: f.documentID))
  //           .toList()));
  // }
}
