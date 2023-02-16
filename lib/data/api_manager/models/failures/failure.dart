import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final id = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

  @override
  List<Object?> get props => [id];
}
