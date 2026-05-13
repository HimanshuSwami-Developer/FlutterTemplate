import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double itemWidth = 12.0;
  static const double snapInterval = itemWidth * 6; // 72px — one major tick apart
  static const int totalItems = 2001;
  static const int centerIndex = totalItems ~/ 2; // 1000

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final halfScreen = screenWidth / 2;
      // Center item's left edge should be at halfScreen, so scroll = centerIndex*itemWidth - halfScreen
      // But we want the CENTER of the tick under the orange line, so subtract half itemWidth too
      final offset = centerIndex * itemWidth - halfScreen + itemWidth / 2;
      _scrollController.jumpTo(offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final halfScreen = screenWidth / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                // ✅ Pass halfScreen so snap math aligns ticks to screen center
                physics: SnapScrollPhysics(
                  snapInterval: snapInterval,
                  halfScreen: halfScreen,
                  tickWidth: itemWidth,
                ),
                itemCount: totalItems,
                itemBuilder: (context, index) {
                  final distance = (index - centerIndex).abs();

                  double height;
                  if (distance % 6 == 0) {
                    height = 45;
                  } else if (distance % 3 == 0) {
                    height = 25;
                  } else {
                    height = 15;
                  }

                  return SizedBox(
                    width: itemWidth,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 4,
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Orange center indicator — fixed in place
              Container(
                width: 5,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SnapScrollPhysics extends ScrollPhysics {
  final double snapInterval;
  final double halfScreen;
  final double tickWidth;

  const SnapScrollPhysics({
    required this.snapInterval,
    required this.halfScreen,
    required this.tickWidth,
    super.parent,
  });

  @override
  SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnapScrollPhysics(
      snapInterval: snapInterval,
      halfScreen: halfScreen,
      tickWidth: tickWidth,
      parent: buildParent(ancestor),
    );
  }

  double _getTarget(ScrollMetrics position, double velocity, Tolerance tolerance) {
    // The orange line is at halfScreen pixels from the left edge of the viewport.
    // The tick that appears under the orange line is at:
    //   scrollOffset + halfScreen = tick's left edge
    // A major tick's left edge = n * snapInterval (for integer n)
    // So we want: scrollOffset = n * snapInterval - halfScreen + tickWidth/2
    //
    // Reframe: shift pixels by the screen offset to find which major tick is centered
    final shifted = position.pixels + halfScreen - tickWidth / 2;
    double page = shifted / snapInterval;

    if (velocity < -tolerance.velocity) {
      page = page.floorToDouble();
    } else if (velocity > tolerance.velocity) {
      page = page.ceilToDouble();
    } else {
      page = page.roundToDouble();
    }

    return page * snapInterval - halfScreen + tickWidth / 2;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final tolerance = toleranceFor(position);
    final target = _getTarget(position, velocity, tolerance);
    if ((target - position.pixels).abs() < 0.5) return null;
    return ScrollSpringSimulation(
      spring,
      position.pixels,
      target,
      velocity,
      tolerance: tolerance,
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}