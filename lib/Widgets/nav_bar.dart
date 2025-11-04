import 'package:carbon_footprint/data/icons.dart';
import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Main Parrent
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.75,
      child: Center(
        child: Container(
          height: 45.1,
          width: 163.2,

          decoration: BoxDecoration(
            color: Color(0xC6FFFFFF),
            borderRadius: BorderRadius.circular(51.12),
          ),
          child: Stack(
            children: [
              Center(child: NavTracer()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavIcon(icon: KIcons.home, page: 0),
                  NavIcon(icon: KIcons.chat_bubble, page: 1),
                  NavIcon(icon: KIcons.pie_chart, page: 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Actual Icon
class NavIcon extends StatefulWidget {
  const NavIcon({super.key, required this.icon, required this.page});

  final int page;
  final String icon;

  @override
  State<NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Animation _colorAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: -5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = ColorTween(
      begin: Color(0xFF000000),
      end: Colors.white,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, child) {
        if (value == widget.page) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: Container(
                height: 39.2,
                width: 39.2,
                decoration: BoxDecoration(
                  // color: Color(0x7AFFD200),
                  shape: BoxShape.circle,
                ),
                child: Transform.scale(
                  scale: 0.6,
                  child: GestureDetector(
                    child: SvgPicture.string(
                      widget.icon,
                      // ignore: deprecated_member_use
                      color: _colorAnimation.value,
                    ),
                    onTap: () {
                      isScrolled.value = false;
                      currentPage.value = widget.page;
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Green Circle
class NavTracer extends StatefulWidget {
  const NavTracer({super.key});

  @override
  State<NavTracer> createState() => _NavTracerState();
}

class _NavTracerState extends State<NavTracer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Tween _tween;
  List<double> iconLocationOffest = [-50.5, 0, 50.5];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _tween = Tween<double>(
      begin: iconLocationOffest.elementAt(currentPage.value),
      end: iconLocationOffest.elementAt(currentPage.value),
    );
    _animation = _tween.animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, child) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // logic
            double currentOffset = iconLocationOffest.elementAt(value);
            if (_tween.end != currentOffset) {
              _tween = Tween<double>(
                begin: _animation.value,
                end: currentOffset,
              );
              _animation = _tween.animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
              );

              _controller.reset();
              _controller.forward();
            }

            return Transform.translate(
              offset: Offset(_animation.value, -7.2),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF007223),
                  border: Border.all(color: Color(0xFFFFFFFF), width: 3),
                ),
              ),
            );
          },
        );
      },
    );
  }
}