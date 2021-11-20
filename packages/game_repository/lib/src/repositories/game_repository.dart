import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_repository/game_repository.dart';

class GameRepository {
  GameRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<Game> createGame({String player1 = 'X'}) async {
    Game game = Game(
      gameID: 'gameID',
      player1: player1,
      currentPlayer: player1,
      boards: [Board()],
    );

    final doc = await _firestore.collection('games').add(game.toMap());
    game = game.copyWith(gameID: doc.id);

    await _firestore.collection('games').doc(game.gameID).set(game.toMap());
    return game;
  }

  Future<Game> joinGame({required String gameID, String player2 = 'O'}) async {
    final ref = _firestore.collection('games').doc(gameID);
    final doc = await ref.get();
    if (!doc.exists) {
      throw Exception('Game with ID $gameID Does not exist');
    }
    final gameData = doc.data()!;
    gameData['player2'] = player2;
    await ref.update({'player2': player2});
    return Game.fromMap(gameData);
  }

  Future<void> updateGame({required Game game}) async {
    await _firestore.collection('games').doc(game.gameID).set(game.toMap());
  }

  Stream<Game?> gameStream({required String gameID}) {
    return _firestore.collection('games').doc(gameID).snapshots().map((event) {
      if (!event.exists) {
        return null;
      }

      final data = event.data();
      if (data == null) {
        throw Exception('Fetching error');
      }

      return Game.fromMap(data);
    });
  }
}
