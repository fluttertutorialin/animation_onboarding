import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onboarding_animation/page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  var _current = 0;
  var _previous = 0;
  late Size _size;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        upperBound: 2.0,
        vsync: this,
        duration: const Duration(milliseconds: 700));
    super.initState();
  }

  void _handleNavigation({bool goBack = false}) {
    setState(() {
      _current = goBack ? _current - 1 : _current + 1;
    });
    _controller.forward(from: 0.0).whenComplete(() {
      _previous = _current;
    });
  }

  Widget _nextButton() {
    return Visibility(
      visible: _current < pages.length - 1,
      child: Positioned(
        bottom: 12,
        right: 12,
        child: IconButton(
          icon: const Icon(
            Icons.navigate_next,
            color: Colors.black87,
            size: 32,
          ),
          onPressed: _handleNavigation,
        ),
      ),
    );
  }

  Widget _previousButton() {
    return Visibility(
      visible: _current > 0,
      child: Positioned(
        bottom: 12,
        left: 12,
        child: IconButton(
          icon: const Icon(
            Icons.navigate_before,
            color: Colors.black87,
            size: 32,
          ),
          onPressed: () => _handleNavigation(goBack: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _size.width,
            height: _size.height,
            color: Color(pages[_previous].color),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return ClipPath(
                clipper:
                    _PageClipper(percent: _controller.value, index: _current),
                child: Container(
                  width: _size.width,
                  height: _size.height,
                  color: Color(pages[_current].color),
                ),
              );
            },
          ),
          _nextButton(),
          _previousButton(),
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    pages.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: AnimatedContainer(
                            key: Key('pad$index'),
                            duration: const Duration(milliseconds: 300),
                            width: index == _current ? 20 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: index == _current
                                    ? Colors.black87
                                    : Colors.black26,
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              child: Column(
                key: Key('$_current'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Image.asset(
                      pages[_current].image,
                      width: _size.width * 0.9,
                      height: _size.width * 0.9,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28,bottom: 24),
                    child: Text(
                      pages[_current].title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w900),
                      key: ValueKey(_current),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28,bottom: 24),
                    child: Text(
                      pages[_current].subTitle,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      key: ValueKey(_current),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Text(
                      pages[_current].description,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.black54),
                      key: ValueKey(_current),
                      textAlign: TextAlign.left,
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PageClipper extends CustomClipper<Path> {
  _PageClipper({
    required this.percent,
    required this.index,
  });

  final int index;
  final double percent;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(Rect.fromCenter(
        center: _generateOffset(size),
        width: size.width * percent * 2,
        height: size.width * percent * 2.25));
    return path;
  }

  Offset _generateOffset(Size size) {
    switch (index) {
      case 0:
        return const Offset(0, 0);
      case 2:
        return Offset(size.width, size.height / 2);
      case 3:
        return Offset(size.width, size.height);
      default:
        return Offset(size.width / 2, size.height / 2);
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
