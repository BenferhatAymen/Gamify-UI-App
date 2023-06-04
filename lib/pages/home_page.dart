import 'package:flutter/material.dart';
import '../data.dart';
import '../widgets/scrollable_games_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _deviceHeight;
  var _deviceWidth;
  var _selectedPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: <Widget>[
        _featuredGameWidget(),
        _gradientBoxWidget(),
        _topLayersWidget()
      ]),
    );
  }

  Widget _featuredGameWidget() {
    return SizedBox(
        height: _deviceHeight * 0.5,
        width: _deviceWidth,
        child: PageView(
          onPageChanged: (_index) {
            setState(() {
              _selectedPage = _index;
            });
            ;
          },
          children: featuredGames.map((_game) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_game.coverImage.url),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _gradientBoxWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: _deviceHeight * 0.80,
        width: _deviceWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(35, 45, 59, 1.0),
              Colors.transparent,
            ],
            stops: [0.65, 1.0],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Widget _topLayersWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.05,
        vertical: _deviceHeight * 0.005,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          SizedBox(height: _deviceHeight * 0.13),
          _featuredGamesInfoWidget(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: _deviceHeight * 0.001,
            ),
            child: ScrollableGameWidget(
                _deviceHeight * 0.24, _deviceWidth, true, games),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.57),
            child: _featuredGameBannerWidget(),
          ),
          ScrollableGameWidget(
              _deviceHeight * 0.24, _deviceWidth, false, games2),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return SizedBox(
      height: _deviceHeight * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: _deviceWidth * 0.03,
              ),
              Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _featuredGamesInfoWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            featuredGames[_selectedPage].title,
            maxLines: 2,
            style:
                TextStyle(color: Colors.white, fontSize: _deviceHeight * 0.040),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: featuredGames.map((_game) {
              double _circleRadius = _deviceHeight * 0.004;
              bool _isActive =
                  _game.title == featuredGames[_selectedPage].title;
              return Container(
                margin: EdgeInsets.only(right: _deviceWidth * 0.012),
                height: _circleRadius * 2,
                width: _circleRadius * 2,
                decoration: BoxDecoration(
                  color: _isActive ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _featuredGameBannerWidget() {
    return Container(
      height: _deviceHeight * 0.13,
      width: _deviceWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(featuredGames[2].coverImage.url))),
    );
  }
}
