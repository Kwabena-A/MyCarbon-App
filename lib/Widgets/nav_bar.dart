import 'package:carbon_footprint/data/icons.dart';
import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Parent. Contains Icons and Green Circle
class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.75, // Scale up Navbar
      child: Center(
        child: Container(
          height: 45.1, // Fixed Dimensions
          width: 163.2,

          decoration: BoxDecoration(
            color: Color(0xC6FFFFFF),
            borderRadius: BorderRadius.circular(51.12), // Corner rounding
          ),
          child: Stack(
            children: [
              Center(child: NavTracer()), // Green following circle
              Row(
                // Row of each icon as a NavIcon Widget
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

// Each Icon Object
class NavIcon extends StatefulWidget {
  const NavIcon({super.key, required this.icon, required this.page});

  final int page;
  final String icon;

  @override
  State<NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation; // up & down animation
  late Animation _colorAnimation; // color change animation

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
    ).animate(_controller); //Tween between black and white

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
      valueListenable: currentPage, // Value listenable to get the current page
      builder: (context, value, child) {
        if (value == widget.page) {
          _controller
              .forward(); // if current page is the icons assignewd page, animate forward.
        } else {
          _controller.reverse(); // else animate backwards.
        }
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                _animation.value,
              ), // Change Y offset based on _animation value
              child: Container(
                height: 39.2, // sizing
                width: 39.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Set circle shape
                ),
                child: Transform.scale(
                  scale: 0.6, // Make icon smaller than parent circle
                  child: GestureDetector(
                    // used for onTap function
                    child: SvgPicture.string(
                      widget.icon,
                      color: _colorAnimation
                          .value, // animate icon color based on _colorAnimation value
                    ),
                    onTap: () {
                      // changes current page and isScrolled value when icon is tapped
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
  late Animation _animation; // Animates _tween
  late Tween _tween; // predefined to adjust during animation
  List<double> iconLocationOffest = [
    -50.5,
    0,
    50.5,
  ]; // Fixed offsets to move icon with

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _tween = Tween<double>(
      begin: iconLocationOffest.elementAt(
        currentPage.value,
      ), // tween (move) based on current page position
      end: iconLocationOffest.elementAt(currentPage.value),
    );
    _animation = _tween.animate(_controller); // animate tween

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
      valueListenable: currentPage, // Value listenable to get current page
      builder: (context, value, child) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // logic
            double currentOffset = iconLocationOffest.elementAt(
              value,
            ); // Setting current offset based on current page
            if (_tween.end != currentOffset) {
              // Current offset was updated
              _tween = Tween<double>(
                // Animate from current position to new offset
                begin: _animation.value,
                end: currentOffset,
              );
              _animation = _tween.animate(
                // Updated _animation
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
              );

              _controller.reset();
              _controller.forward();
            }

            return Transform.translate(
              offset: Offset(_animation.value, -7.2), // green circle movement
              child: Container(
                // The green circle
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