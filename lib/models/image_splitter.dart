import 'dart:ui'as ui;

import 'package:play_galaxy/models/puzzle_pieces.dart';

Future<List<PuzzlePiece>> splitImage(ui.Image image , int gridSize) async{
  final List<PuzzlePiece> pieces=[];
  final pieceSize = image.width / gridSize;

  for(int row =0; row<gridSize; row++){
    for(int col =0; col<gridSize; col++){
      final ui.Rect srcRect = ui.Rect.fromLTWH(
          col * pieceSize,
          row * pieceSize,
          pieceSize,
          pieceSize,
);
      final ui.PictureRecorder recorder =ui.PictureRecorder();
      final ui.Canvas canvas=ui.Canvas(recorder);
      final ui.Paint paint =ui.Paint();
      canvas.drawImageRect(image,
     srcRect,
     ui.Rect.fromLTWH(0, 0, pieceSize, pieceSize),
      paint,
);
     final picture=recorder.endRecording();
     final pieceImage=await picture.toImage(pieceSize.round(), pieceSize.round());
     final index = row * gridSize + col;

pieces.add(
  PuzzlePiece(originalIndex: index, currentIndex: -1, correctIndex: index, bitmap: pieceImage, size: pieceSize),
);

}
}
return pieces;
}