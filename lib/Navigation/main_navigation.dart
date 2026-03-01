import './navbar.dart';
import '../utility.dart';
import '../pages/cards.dart';
import '../pages/docs.dart';
import '../pages/home.dart';
import '../pages/team.dart';
import '../pages/tasks.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  State<MainNavigationScreen> createState() => _MainNavState();
}

class _MainNavState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  int _cur = 0, _prev = 0;

  late AnimationController _iconCtrl;
  late List<Animation<double>> _iconAnims;
  late final ScrollController _scrollController;
  double _lastOffset = 0;
  bool _navVisible = true;

  void _onScroll() {
    final currentOffset = _scrollController.offset;
    final delta = currentOffset - _lastOffset;

    // Only hide after user scrolls down 40px continuously
    if (delta > 0 && currentOffset > 200) {
      if (_navVisible) {
        setState(() => _navVisible = false);
      }
    }

    // Show when scrolling up
    if (delta < -10) {
      if (!_navVisible) {
        setState(() => _navVisible = true);
      }
    }

    _lastOffset = currentOffset;
  }

  late final List<Widget> _pages;

  static const _titles = [
    'Home',
    'Tasks',
    'Team',
    'Card',
    'Docs',
  ];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _pages = [
      HomedPage(onNavigate: _nav, controller: _scrollController),
      TasksPage(onNavigate: _nav, controller: _scrollController),
      TeamPage(onNavigate: _nav, controller: _scrollController),
      CardsPage(onNavigate: _nav, controller: _scrollController),
      DocsPage(onNavigate: _nav, controller: _scrollController),
    ];
    _iconCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconAnims = List.generate(5, (i) {
      final start = i * 0.15;
      return CurvedAnimation(
        parent: _iconCtrl,
        curve: Interval(
          start.clamp(0, 0.7),
          (start + 0.5).clamp(0, 1),
          curve: Curves.elasticOut,
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _iconCtrl.dispose();
    super.dispose();
  }

  void _nav(int i) {
    if (_cur == i) return;
    setState(() {
      _prev = _cur;
      _cur = i;
    });
    _iconCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final goRight = _cur > _prev;

    return PopScope(
      canPop: _cur == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _nav(0);
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,

        // ── AppBar with animated title ──────────────────────────────────
        appBar: AppBar(
          surfaceTintColor: cs.primaryContainer,
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, .4),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
                    ),
                child: child,
              ),
            ),
            child: Column(
              key: ValueKey(_cur),
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _titles[_cur],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          centerTitle: true,
          scrolledUnderElevation: 1,
        ),

        // ── Body: directional fade+slide ────────────────────────────────
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 380),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, anim) {
            final incoming = child.key == ValueKey(_cur);
            final dx = goRight ? 0.05 : -0.05;
            return FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: Offset(incoming ? dx : -dx, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                    ),
                child: child,
              ),
            );
          },
          child: KeyedSubtree(key: ValueKey(_cur), child: _pages[_cur]),
        ),

        // ── Bottom nav — elastic icon spring on tap ──────────────────────
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        floatingActionButton: AnimatedBuilder(
          animation: _iconCtrl,
          builder: (context, _) {
            final isFabTab = _cur == 1;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              width: isFabTab ? 140 : 56,
              height: 56,
              decoration: BoxDecoration(
                color: tabColor(context, _cur),
                borderRadius: BorderRadius.circular(isFabTab ? 28 : 16),
              ),
              child: isFabTab
                  ? Row(
                      mainAxisSize: MainAxisSize.min, // Hug the content
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        SizedBox(width: 4), // Reduced from 8 to give more room
                        Flexible(
                          // <--- This allows the text to be flexible within the 75px
                          child: Text(
                            "Create",
                            softWrap:
                                false, // Prevents text from jumping to a second line
                            overflow: TextOverflow
                                .clip, // Clips the text at the sub-pixel level
                          ),
                        ),
                      ],
                    )
                  : const Icon(Icons.add),
            );
          },
        ),

        bottomNavigationBar: AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          offset: _navVisible ? Offset.zero : const Offset(0, 1.5),
          child: SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SpringFloatingNavBar(currentIndex: _cur, onTap: _nav),
          ),
        ),
      ),
    );
  }
}
