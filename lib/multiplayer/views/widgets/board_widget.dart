import 'package:flutter/material.dart';
import 'package:game_repository/game_repository.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    Key? key,
    required this.board,
    this.onBoardTapped,
    this.currentPlayerSymbol = 'X',
  }) : super(key: key);

  final Board board;
  final ValueChanged<Board>? onBoardTapped;
  final String currentPlayerSymbol;

  void _onSquarepressed(int index, String value) {
    if (value.isEmpty) {
      final squares = [...board.squares];
      squares[index] = currentPlayerSymbol;
      onBoardTapped?.call(board.copyWith(squares: squares));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < board.squares.length; i++)
          _Square(
            index: i,
            value: board.squares[i],
            onPressed: _onSquarepressed,
          ),
      ],
    );
  }
}

class _Square extends StatelessWidget {
  const _Square({
    Key? key,
    required this.index,
    this.value = '',
    this.onPressed,
  }) : super(key: key);

  final int index;
  final String value;

  /// passes the integer and the value when pressed
  final void Function(int, String)? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed?.call(index, value),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        width: 24,
        height: 24,
        child: Center(
          child: Text(value),
        ),
      ),
    );
  }
}
