import 'dart:async';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_repository/game_repository.dart';

void main() {
  group('Game Repository Tests', () {
    late FakeFirebaseFirestore firestore;
    StreamSubscription? gameSubscription;

    setUp(() {
      firestore = FakeFirebaseFirestore();
    });

    tearDown(() {
      gameSubscription?.cancel();
    });

    test('Creates a game', () async {
      GameRepository gameRepository = GameRepository(firestore: firestore);
      Game? game;
      final createdGame = await gameRepository.createGame();
      gameSubscription = gameRepository
          .gameStream(
        gameID: createdGame.gameID,
      )
          .listen((event) {
        game = event;
      });

      expect(game, isNull);
      await Future.delayed(Duration.zero);
      expect(game, isNotNull);
    });

    test('Joins a game', () async {
      GameRepository gameRepository = GameRepository(firestore: firestore);
      Game? game;
      final createdGame = await gameRepository.createGame();
      gameSubscription = gameRepository
          .gameStream(
        gameID: createdGame.gameID,
      )
          .listen((event) {
        game = event;
      });

      expect(game, isNull);
      await Future.delayed(Duration.zero);
      await gameRepository.joinGame(gameID: game?.gameID ?? '', player2: 'O');
      await Future.delayed(Duration.zero);
      expect(game?.player2, isNotNull);
    });

    test('Updates a game', () async {
      final initialGameData = Game(
        gameID: '01',
        player1: 'X',
        currentPlayer: 'X',
        boards: [],
      ).toMap();
      await firestore
          .collection('games')
          .doc(initialGameData['gameID'])
          .set(initialGameData);

      final gameRepository = GameRepository(firestore: firestore);
      Game? game;
      gameSubscription = gameRepository.gameStream(gameID: '01').listen(
        (event) {
          game = event;
        },
      );
      await gameRepository.joinGame(gameID: '01');
      await Future.delayed(Duration.zero);
      expect(game, isNotNull);
      final game2 = game?.copyWith(player2: 'player2');
      await gameRepository.updateGame(game: game2!);
      await Future.delayed(Duration.zero);
      expect(game?.player2, 'player2');
    });
  });
}
