import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tttm/providers/game_provider.dart';

import 'game_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => MenuScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiplayer')),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  Future<void> _createGame(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              height: 48,
              width: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 8),
            Text('Creating game'),
          ],
        ),
      ),
    );
    await context.read<GameProvider>().createGame();
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context).push(GameScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () => _createGame(context),
          child: const Text('Create Game'),
        ),
        const SizedBox(height: 16),
        const _JoinGameSection(),
      ],
    ));
  }
}

class _JoinGameSection extends StatefulWidget {
  const _JoinGameSection({
    Key? key,
  }) : super(key: key);

  @override
  State<_JoinGameSection> createState() => _JoinGameSectionState();
}

class _JoinGameSectionState extends State<_JoinGameSection> {
  Future<void> _joinGame(
    BuildContext context, {
    required String gameID,
  }) async {
    final gameProvider = context.read<GameProvider>();
    await gameProvider.joinGame(gameID: gameID);
    if (gameProvider.hasError) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('${gameProvider.error}'),
        ),
      );
    } else {
      Navigator.of(context).push(GameScreen.route());
    }
  }

  final _gameIDController = TextEditingController();

  @override
  void dispose() {
    _gameIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _gameIDController,
          decoration: const InputDecoration(
              hintText: 'Game ID', label: Text('Game ID')),
        ),
        ElevatedButton(
          onPressed: () => _joinGame(context, gameID: _gameIDController.text),
          child: const Text('Join Game'),
        ),
      ],
    );
  }
}
