import 'dart:convert';

import 'package:flutter/foundation.dart';

class Board {
  Board({
    List<String>? squares,
  }) : squares = squares ?? List.generate(9, (index) => '') {
    assert(this.squares.length == 9, 'board must have 9 squares');
  }

  final List<String> squares;

  Board copyWith({
    List<String>? squares,
  }) {
    return Board(
      squares: squares ?? this.squares,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'squares': squares,
    };
  }

  factory Board.fromMap(Map<String, dynamic> map) {
    return Board(
      squares: List<String>.from(map['squares']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Board.fromJson(String source) => Board.fromMap(json.decode(source));

  @override
  String toString() => 'Board(squares: $squares)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Board && listEquals(other.squares, squares);
  }

  @override
  int get hashCode => squares.hashCode;
}
