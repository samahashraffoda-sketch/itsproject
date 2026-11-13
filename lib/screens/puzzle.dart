import 'package:flutter/material.dart';
import 'package:itsproject/models/image_splitter.dart';
import 'package:itsproject/models/puzzle_pieces.dart';
import 'dart:ui'as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class puzzle extends StatefulWidget {
  final int level;
   puzzle({super.key ,required this.level});

  @override
  State<puzzle> createState() => _puzzleState();
}

class _puzzleState extends State<puzzle> with TickerProviderStateMixin
{
  late int gridSize;
  late String imagePath;
  List<PuzzlePiece> allPieces =[];
  List<PuzzlePiece> puzzlePieces =[];
  late  List<PuzzlePiece?> boardPositions;
  bool isCompleted = false;
  late AnimationController _successController;
  ui.Image? fullImage;
  static const maxLevel =4;



  @override
  void initState(){
    super.initState();
    gridSize=widget.level+1;
    imagePath='assets/levels/level_${widget.level}.jpj';
    boardPositions= List<PuzzlePiece?>.filled(gridSize * gridSize , null);
    _successController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _loadAndPreparePuzzle();
  }
  @override
   void dispose(){
   _successController.dispose() ;
   super.dispose();
  }
  Future<void> _loadAndPreparePuzzle() async {
      final ByteData imgData = await rootBundle.load(imagePath);
      final ui.Codec codec = await ui.instantiateImageCodec(imgData.buffer.asUint8List());
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;
       fullImage =image ;

       allPieces=await splitImage(image, gridSize);
       puzzlePieces  = List<PuzzlePiece>.from(allPieces);
       puzzlePieces.shuffle();

       setState(() {
         boardPositions=List<PuzzlePiece?>.filled(gridSize*gridSize,null);
         isCompleted = false;
         _successController.reset();
       });
  }
   void _refreshPieces(){
    setState(() {
      puzzlePieces  = List<PuzzlePiece>.from(allPieces);
      puzzlePieces.shuffle();
      boardPositions=List<PuzzlePiece?>.filled(gridSize*gridSize,null);
      isCompleted = false;
      _successController.reset();
    });
   }
   bool canAcceptPiece(int gridIndex) => true;

  void handlePieceDropped(int gridIndex,PuzzlePiece piece){
    setState(() {
      //problem 1
      if(boardPositions[gridIndex] != null){
        puzzlePieces.add(boardPositions[gridIndex] ! );
      }
      boardPositions[gridIndex] = piece;
      puzzlePieces.remove(piece);

      for(int i=0;i<boardPositions.length;i++){
       if (i != gridIndex && boardPositions[i] == piece){
           boardPositions[i]=null;
           break;
         }
      }
    });
    _checkCompletion();
  }

void movePieceToBottom(PuzzlePiece piece) {
  setState(() {
    for (int i = 0; i < boardPositions.length; i++) {
      if (boardPositions[i] == piece) {
        boardPositions[i] = null;
      }
    }
    puzzlePieces.add(piece);
  });
}
  //problem2
void _checkCompletion(){
 bool finished=true;
 for(int i = 0; i <  boardPositions.length; i++)  {
  final   p =boardPositions[i];     //kareem mohamed omar = k
   if(p == null || p.correctIndex !=i){
     finished=false;
     break;
   }
 }
 if (finished && !isCompleted){
   setState(() {
     isCompleted = true;
   });
   _successController.forward();
   _handleLevelComplete();
 }
}
Future<void>_handleLevelComplete()  async{
    await Future.delayed(Duration(milliseconds: 1200));
    final prefs = await SharedPreferences.getInstance();
    final unlockedLevel = prefs.getInt('unlocked_Level') ?? 1;
     if(widget.level==unlockedLevel && widget.level< maxLevel){
       await prefs.setInt('unlocked_level',unlockedLevel + 1);
     }
     if(widget.level<maxLevel){
       if(mounted){
         Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (context)=> puzzle(level: widget.level +1),
             ),
         );
       }
     }else{
       if(mounted){
         showDialog(context: context, builder: (context) => AlertDialog(
           title: Text("Congratulations!"),
           content: Text("YOU FINESHD ALL LEVELS"),
           actions: [TextButton(onPressed: ()=>
               Navigator.of(context).pushNamedAndRemoveUntil('/menu', (r) => false),
               child: Text("back to menu"),
                ),
             ],
           ),
         );
       }
     }
  }
  Widget _buildPieceWidgdet(PuzzlePiece piece,{double? size}){
    return RepaintBoundary(
      child: SizedBox(
        width: size,
        height: size,
        child: DragFeedbackPiece(piece:piece),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final boardSideLenght = MediaQuery.of(context).size.width * 0.35;
    final pieceSize = boardSideLenght/ gridSize;
    final scatteredPieceSize =pieceSize *0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text('level ${widget.level} -${gridSize}*$gridSize'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: Icon(Icons.refresh),
            onPressed:_refreshPieces,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding:EdgeInsets.only(top: 16,right: 16),
              child: Row(children: [
                Spacer(),
                  if(fullImage != null)
                   SizedBox(
                     height: 140,
                     width: 140,
                     child: CustomPaint(
                       painter: FullImagePainter(fullImage!),
                     ),
                   ),
              ],
              ),
            ),
            SizedBox(height: 8),
            Stack(alignment: Alignment.center,
              children: [
                ScaleTransition(scale: Tween<double>(begin: 1, end:1.12)
                    .animate(CurvedAnimation(parent: _successController, curve: Curves.elasticInOut)),
                  child: Opacity(opacity: isCompleted?1.0:0.0,
                    child: Container(
                      width: boardSideLenght,
                      height: boardSideLenght ,
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.63),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(Icons.emoji_events_outlined ,size: 96,color: Colors.amberAccent,),

                      ),
                    ),
                  ),
                ),
                SizedBox(width: boardSideLenght,
                          height: boardSideLenght,
                  child: GridView.builder(
                      shrinkWrap:true,
                        physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridSize),
                      itemCount: gridSize*gridSize,
                      itemBuilder: (context,index){
                      final piece=boardPositions[index];

                      return DragTarget<PuzzlePiece>(
                        onWillAccept: (incomingPiece){
                          return true;
                        },
                         onAccept: (incomingPiece){
                          handlePieceDropped(index, incomingPiece);
                         },
                        builder: (context,candidateData,rejectedData){
                          if(piece != null){
                            return Draggable<PuzzlePiece>(
                              data: piece,
                              feedback:_buildPieceWidgdet(piece,size :pieceSize),
                              childWhenDragging: Container(
                                width:pieceSize,
                                height: pieceSize,
                                 color:Colors.grey[300],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:Colors.green.shade600,
                                    width: 2,
                                  ),
                                  borderRadius:BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: _buildPieceWidgdet(piece,size: pieceSize),
                                ),
                              ),
                              onDragCompleted: (){},
                              onDraggableCanceled:(velocity,offset){
                                movePieceToBottom(piece);
                              },
                            );
                          }else{
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 2,
                                ),
                                borderRadius:BorderRadius.circular(6),
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      );
                      },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Drag The Pieces To The Board",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height:10),
            DragTarget<PuzzlePiece>(
              onWillAccept: (incomingPiece)=>true,
              onAccept: (incomingPiece){
                movePieceToBottom(incomingPiece);
              },
              builder:(context,candidataData,rejectedData){
                return Wrap(
                  alignment :WrapAlignment.center,
                  spacing:8,
                  runSpacing:8,
                  children:puzzlePieces.map((piece){
    return Draggable<PuzzlePiece>(data: piece,
    feedback:_buildPieceWidgdet(piece,size :scatteredPieceSize),
    childWhenDragging: Opacity(
    opacity: 0.5,
    child:_buildPieceWidgdet(piece,size :scatteredPieceSize),
                   ),
    child:_buildPieceWidgdet(piece,size :scatteredPieceSize),
    );
    }).toList()  ,
                  );
                 },
             ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
class FullImagePainter extends CustomPainter{
  final ui.Image image;
  FullImagePainter(this.image);

  @override
  void paint(Canvas canvas,Size size){
    final dstRect =   ui.Rect.fromLTWH(0, 0, size.width, size.height);
    paintImage(
        canvas: canvas,
        rect: dstRect,
        image: image,
     fit: BoxFit.cover,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  }


  class DragFeedbackPiece extends StatelessWidget {
   final  PuzzlePiece piece;
    DragFeedbackPiece ({super.key,required this.piece});

    @override
    Widget build(BuildContext context) {
      return  CustomPaint(
       size:Size.square(piece.size),
        painter: _PuzzlePiecPainter(piece),
      );
    }
  }
  class _PuzzlePiecPainter extends CustomPainter{
    final  PuzzlePiece piece;
    _PuzzlePiecPainter(this.piece);

    @override
    void paint(Canvas canvas,Size size){
      final dstRect =   ui.Rect.fromLTWH(0, 0, size.width, size.height);
      paintImage(
        canvas: canvas,
        rect: dstRect,
        image: piece.bitmap,
        fit: BoxFit.cover,
      );
  }
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  }
