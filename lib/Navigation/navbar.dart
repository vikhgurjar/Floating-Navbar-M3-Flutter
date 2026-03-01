import 'dart:ui';
import '../utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/physics.dart';

class SpringFloatingNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const SpringFloatingNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<SpringFloatingNavBar> createState() => SpringFloatingNavBarState();
}

class SpringFloatingNavBarState extends State<SpringFloatingNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final SpringDescription _spring = const SpringDescription(
    mass: 1,
    stiffness: 450,
    damping: 28,
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController.unbounded(
      vsync: this,
      value: widget.currentIndex.toDouble(),
    );
  }

  @override
  void didUpdateWidget(covariant SpringFloatingNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentIndex != widget.currentIndex) {
      final simulation = SpringSimulation(
        _spring,
        _controller.value,
        widget.currentIndex.toDouble(),
        0,
      );
      _controller.animateWith(simulation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final items = [
      (Icons.dashboard_outlined, Icons.dashboard, "Home"),
      (Icons.check_circle_outline, Icons.check_circle, "Tasks"),
      (Icons.people_outline, Icons.people, "Team"),
      (Icons.card_membership_outlined, Icons.card_membership, "Cards"),
      (Icons.assignment_outlined, Icons.assignment, "Docs"),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / items.length;

        return ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 68,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Positioned(
                        left: _controller.value * itemWidth + 6,
                        top: 6,
                        bottom: 6,
                        width: itemWidth - 12,
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                tabColor(
                                  context,
                                  widget.currentIndex,
                                ).withValues(alpha: 0.8),
                                Colors.black,
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  /// Touch Layer
                  Row(
                    children: List.generate(items.length, (i) {
                      final selected = i == widget.currentIndex;

                      return Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              widget.onTap(i);
                            },
                            borderRadius: BorderRadius.circular(28),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedScale(
                                  scale: selected ? 1.15 : 1,
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    selected ? items[i].$2 : items[i].$1,
                                    size: 22,
                                    color: selected
                                        ? cs.onPrimaryContainer
                                        : cs.onSurfaceVariant,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: selected ? 1 : 0.6,
                                  child: Text(
                                    items[i].$3,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: selected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: selected
                                          ? cs.onPrimaryContainer
                                          : cs.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

