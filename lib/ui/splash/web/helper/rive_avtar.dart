import 'package:flutter/gestures.dart' show Offset;
import 'package:rive/math.dart' show Vec2D;
import 'package:rive/rive.dart';

class RiveAvatar {
  late final Artboard _artBoard;

  late final StateMachineController _controller;

  Artboard get artBoard => _artBoard;
  StateMachineController get controller => _controller;

  RiveAvatar(Artboard? artBoard) {
    if (artBoard == null) {
      throw Exception('No artBoards cached!');
    }
    _artBoard = artBoard;

    _controller = StateMachineController(_artBoard.stateMachines.first);
    _artBoard.addController(_controller);
  }

  /// Interface for eyes/head moving from pointer's offset coordinates.
  void move(Offset pointer) => _controller.pointerMoveFromOffset(pointer);
}

/// Helpers, that are not yet available in [StateMachineController].
extension StateMachineControllerX on StateMachineController {
  void pointerMoveFromOffset(Offset pointerOffset) => pointerMove(Vec2D.fromValues(pointerOffset.dx, pointerOffset.dy));
}