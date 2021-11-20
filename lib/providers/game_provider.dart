import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_repository/game_repository.dart';

class GameProvider extends ChangeNotifier {
  GameProvider({required GameRepository gameRepository})
      : _gameRepository = gameRepository;

  final GameRepository _gameRepository;

  String? error;
  bool hasError = false;
  bool isLoading = false;
  bool isWaitingForPlayers = false;
  Game? game;
  StreamSubscription? _subscription;
  String playerSymbol = 'X';
  String? winner;

  Future<void> createGame() async {
    _subscription?.cancel();
    isWaitingForPlayers = true;
    playerSymbol = 'X';
    notifyListeners();

    final createdGame = await _gameRepository.createGame();
    _subscription =
        _gameRepository.gameStream(gameID: createdGame.gameID).listen(
      _onCreateGameEvent,
      onError: (error) {
        hasError = true;
        this.error = error.toString();
        notifyListeners();
      },
    );
  }

  Future<void> joinGame({required String gameID}) async {
    isLoading = true;
    playerSymbol = 'O';
    notifyListeners();
    _subscription =
        _gameRepository.gameStream(gameID: gameID).listen(_onJoinEvent);
    await _gameRepository.joinGame(gameID: gameID);
  }

  Future<void> updateGame({required Game game}) async {
    await _gameRepository.updateGame(game: game);
  }

  void _onCreateGameEvent(Game? event) {
    game = event;
    if (game?.player2 != null) {
      isWaitingForPlayers = false;
    }
    notifyListeners();
  }

  void _onJoinEvent(Game? event) {
    if (event != null) {
      isLoading = false;
      game = event;
      notifyListeners();
    }
  }

  Future<void> resetGame({required Game game}) async {
    final newGame = game.copyWith(
      boards: [Board()],
      winner: '',
      currentPlayer: 'X',
      xIsNext: true,
    );
    await updateGame(game: newGame);
  }

  String checkWinner({required Board board}) {
    final squares = board.squares;

    if (squares.indexWhere((element) => element.isEmpty) == -1) {
      return 'tie';
    }

    final lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final line in lines) {
      final n1 = line[0];
      final n2 = line[1];
      final n3 = line[2];
      if (squares[n1] == squares[n2] && squares[n2] == squares[n3]) {
        return squares[n1];
      }
    }
    return '';
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
