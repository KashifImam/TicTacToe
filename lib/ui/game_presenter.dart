import 'dart:async';
import '../ai/ai.dart';
import '../ai/utils.dart';



class GamePresenter {

  // callbacks into our UI
  void Function(int idx) showMoveOnUi;
  void Function(int winningPlayer) showGameEnd;

  late Ai _aiPlayer;

  // bool hasPlayed = false;

  GamePresenter(this.showMoveOnUi, this.showGameEnd) {
    _aiPlayer = Ai();
  }

  void onHumanPlayed(List<int> board) async {


      int evaluation = Utils.evaluateBoard(board);
      if (evaluation != Ai.NO_WINNERS_YET) {
        onGameEnd(evaluation);
        return;
      }

      // calculate the next move, could be an expensive operation
      // int aiMove = await Future(() => _aiPlayer.play(board, Ai.AI_PLAYER));

      int aiMove = await Future.delayed(const Duration(milliseconds: 500), () => _aiPlayer.play(board, Ai.AI_PLAYER));

      // do the next move
      board[aiMove] = Ai.AI_PLAYER;

      // evaluate the board after the AI player move
      evaluation = Utils.evaluateBoard(board);
      if (evaluation != Ai.NO_WINNERS_YET) {
        onGameEnd(evaluation);
      } else {
        showMoveOnUi(aiMove);

    }

  }

  void onGameEnd(int winner) {
    if (winner == Ai.AI_PLAYER) {

    }

    showGameEnd(winner);
  }




}