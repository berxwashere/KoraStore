import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import '../widgets/navigation_item.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Maintains individual navigation stacks for each tab to preserve their nested routes
  Widget _buildTabNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // We manually intercept hardware back-buttons to control the nested tab routers
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentIndex].currentState!.maybePop();
        
        if (isFirstRouteInCurrentTab) {
          if (_currentIndex != 0) {
            // If the user is at the root of a secondary tab, jump back to the Home tab
            setState(() => _currentIndex = 0);
          } else {
            // If the user backs out of the root Home tab, natively collapse the app
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        // IndexedStack preserves the state of all tabs so users don't lose scroll positions
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildTabNavigator(0, const HomeScreen()),
            _buildTabNavigator(1, const FavoritesScreen()),
            _buildTabNavigator(
              2,
              CartScreen(
                onBack: () => setState(() => _currentIndex = 0),
              ),
            ),
            _buildTabNavigator(3, const ProfileScreen()),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.border, width: 0.5),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavigationItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: 'Home',
                    isActive: _currentIndex == 0,
                    onTap: () {
                      if (_currentIndex == 0) {
                        _navigatorKeys[0].currentState?.popUntil((route) => route.isFirst);
                      } else {
                        setState(() => _currentIndex = 0);
                      }
                    },
                  ),
                  NavigationItem(
                    icon: Icons.favorite_outline,
                    activeIcon: Icons.favorite,
                    label: 'Favorites',
                    isActive: _currentIndex == 1,
                    onTap: () {
                      if (_currentIndex == 1) {
                        _navigatorKeys[1].currentState?.popUntil((route) => route.isFirst);
                      } else {
                        setState(() => _currentIndex = 1);
                      }
                    },
                  ),
                  NavigationItem(
                    icon: Icons.shopping_bag_outlined,
                    activeIcon: Icons.shopping_bag,
                    label: 'Cart',
                    isActive: _currentIndex == 2,
                    onTap: () {
                      if (_currentIndex == 2) {
                        _navigatorKeys[2].currentState?.popUntil((route) => route.isFirst);
                      } else {
                        setState(() => _currentIndex = 2);
                      }
                    },
                    badge: context.watch<CartProvider>().itemCount,
                  ),
                  NavigationItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                    isActive: _currentIndex == 3,
                    onTap: () {
                      if (_currentIndex == 3) {
                        _navigatorKeys[3].currentState?.popUntil((route) => route.isFirst);
                      } else {
                        setState(() => _currentIndex = 3);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
