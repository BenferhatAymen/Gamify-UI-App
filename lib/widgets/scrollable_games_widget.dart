import 'package:flutter/material.dart';
import '../data.dart';

class ScrollableGameWidget extends StatelessWidget {
  final double _height;
  final double _width;
  final bool _showTitle;
  final List<Game> _gameData;
  ScrollableGameWidget(
      this._height, this._width, this._showTitle, this._gameData);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: _gameData.map((_game) {
          return Container(
            height: _height,
            width: _width * 0.3,
            child: Padding(
              padding: EdgeInsets.only(right: _width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: _height * 0.8,
                    width: _width * 0.45,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(0, 0.2), // Shadow position
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              _game.coverImage.url,
                            ))),
                  ),
                  _showTitle
                      ? Text(
                          _game.title,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white, fontSize: _height * 0.075),
                        )
                      : SizedBox(
                          height: 0.00001,
                          width: 0.000001,
                        )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
