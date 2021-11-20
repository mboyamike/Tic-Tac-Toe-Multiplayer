import 'package:flutter/material.dart';


import 'package:game_repository/game_repository.dart';
import 'package:provider/provider.dart';
import 'package:tttm/multiplayer/views/widgets/widgets.dart';
import 'package:tttm/providers/game_provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const GameScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  void _updateBoard(BuildContext context, Board board) {
    final gameProvider = context.read<GameProvider>();
    if (gameProvider.game == null) {
      return;
    }

    final game = gameProvider.game!;

    if (game.winner.isNotEmpty) {
      return;
    }

    final winner = gameProvider.checkWinner(board: board);
    if (winner.isNotEmpty) {
      gameProvider.updateGame(
        game: game.copyWith(
          boards: [...game.boards, board],
          winner: winner,
        ),
      );
      return;
    }

    if (gameProvider.playerSymbol == 'X' && game.xIsNext ||
        gameProvider.playerSymbol == 'O' && !game.xIsNext) {
      gameProvider.updateGame(
        game: game.copyWith(
          currentPlayer: game.xIsNext ? 'O' : 'X',
          xIsNext: !game.xIsNext,
          boards: [...game.boards, board],
        ),
      );
    }
    setState(() {});
  }

  void _resetGame() async {
    final gameProvider = context.read<GameProvider>();
    gameProvider.resetGame(game: gameProvider.game!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (_, provider, __) {
        if (provider.isWaitingForPlayers) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Waiting for players'),
                SelectableText('GameID: ${provider.game?.gameID}')
              ],
            ),
          );
        }

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            children: [
              Text('You are ${provider.playerSymbol}'),
              const SizedBox(height: 8),
              Text("It is ${provider.game?.currentPlayer}'s turn"),
              const SizedBox(height: 24),
              SizedBox(
                width: 72,
                child: BoardWidget(
                  board: provider.game!.boards.last,
                  onBoardTapped: (board) => _updateBoard(context, board),
                  currentPlayerSymbol: provider.playerSymbol,
                ),
              ),
              if (provider.game?.winner.isNotEmpty ?? false) ...[
                const SizedBox(height: 8),
                Text(
                  provider.game!.winner == 'tie'
                      ? 'Tie'
                      : '${provider.game!.winner} wins',
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _resetGame,
                  child: const Text('Reset Game'),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
