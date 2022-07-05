import 'package:flutter/material.dart';

import 'utils.dart';

class TextTilePage extends StatefulWidget {
  const TextTilePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TextTilePageState createState() => _TextTilePageState();
  }

class _TextTilePageState extends State<TextTilePage> {
  static final double radius = 20;

  UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      //title: Text(MyApp.title),
      centerTitle: true,
    ),
    body: Padding(
      padding: EdgeInsets.all(12),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: Colors.black, width: 2)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => isExpanded ? shrinkTile() : expandTile(),
                  child: buildImage(),
                ),
                buildText(context),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildImage() => Image.asset(
    'assets/images/720x890_0xc0a8392b_10726132821428426930.jpg',
    fit: BoxFit.cover,
    width: double.infinity,
    height: 400,
  );

  Widget buildText(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      key: keyTile,
      initiallyExpanded: isExpanded,
      childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      title: Text(
        'Olga Peskova',
        style: TextStyle(fontSize:  24, fontWeight: FontWeight.w500),
      ),
      children: [
        Text('Ph.D. candidate Department of Behavioral and Brain Sciences, 200RYT',
          style: TextStyle(fontSize: 18, height: 1.4),
        ),
      ],
      onExpansionChanged: (isExpanded) => Utils.showSnackBar(
        context,
        text: isExpanded ? 'Expand Tile' : 'Shrink Tile',
        color: isExpanded ? Colors.teal : Colors.tealAccent,
      ),
    ),
  );
}
