import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:game_repository/src/models/board.dart';

class Game {
  Game({
    required this.gameID,
    required this.player1,
    this.player2,
    required this.currentPlayer,
    required this.boards,
    this.isActive = true,
    this.xIsNext = true,
    this.player1Symbol = 'X',
    this.winner = '',
  });

  final String gameID;
  final String player1;
  final String? player2;
  final String currentPlayer;
  final List<Board> boards;
  final bool isActive;
  final bool xIsNext;
  final String player1Symbol;
  final String winner;

  Game copyWith({
    String? gameID,
    String? player1,
    String? player2,
    String? currentPlayer,
    List<Board>? boards,
    bool? isActive,
    bool? xIsNext,
    String? player1Symbol,
    String? winner,
  }) {
    return Game(
      gameID: gameID ?? this.gameID,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      boards: boards ?? this.boards,
      isActive: isActive ?? this.isActive,
      xIsNext: xIsNext ?? this.xIsNext,
      player1Symbol: player1Symbol ?? this.player1Symbol,
      winner: winner ?? this.winner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gameID': gameID,
      'player1': player1,
      'player2': player2,
      'currentPlayer': currentPlayer,
      'boards': boards.map((x) => x.toMap()).toList(),
      'isActive': isActive,
      'xIsNext': xIsNext,
      'player1Symbol': player1Symbol,
      'winner': winner,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      gameID: map['gameID'],
      player1: map['player1'],
      player2: map['player2'],
      currentPlayer: map['currentPlayer'],
      boards: List<Board>.from(map['boards']?.map((x) => Board.fromMap(x))),
      isActive: map['isActive'],
      xIsNext: map['xIsNext'],
      player1Symbol: map['player1Symbol'],
      winner: map['winner'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Game(gameID: $gameID, player1: $player1, player2: $player2, currentPlayer: $currentPlayer, boards: $boards, isActive: $isActive, xIsNext: $xIsNext, player1Symbol: $player1Symbol, winner: $winner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Game &&
      other.gameID == gameID &&
      other.player1 == player1 &&
      other.player2 == player2 &&
      other.currentPlayer == currentPlayer &&
      listEquals(other.boards, boards) &&
      other.isActive == isActive &&
      other.xIsNext == xIsNext &&
      other.player1Symbol == player1Symbol &&
      other.winner == winner;
  }

  @override
  int get hashCode {
    return gameID.hashCode ^
      player1.hashCode ^
      player2.hashCode ^
      currentPlayer.hashCode ^
      boards.hashCode ^
      isActive.hashCode ^
      xIsNext.hashCode ^
      player1Symbol.hashCode ^
      winner.hashCode;
  }
}
