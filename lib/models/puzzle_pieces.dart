
import 'dart:ui'as ui;

class PuzzlePiece {
  final int originalIndex;
  int currentIndex;
  final int correctIndex;
  final ui.Image bitmap;
  final double size;

  PuzzlePiece({
    required this.originalIndex,
    required this.currentIndex,
    required this.correctIndex,
    required this.bitmap,
    required this.size,
  });
}