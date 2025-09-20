import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/meal_detail.dart';
import 'screens/statistics.dart';
import 'widgets/dashboard_widgets.dart';
import 'utils/colors.dart';

void main() {
  runApp(const HealthDietApp());
}

class HealthDietApp extends StatelessWidget {
  const HealthDietApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Diet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const MainScreen(),
      routes: {
        '/meal-detail': (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          return MealDetailPage(mealData: args);
        },
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomePage(),
    const StatisticsPage(),
    const Center(child: Text('Add Meal')),
    const Center(child: Text('Habits')),
    const Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content with padding at bottom for floating nav
          Padding(
            padding: const EdgeInsets.only(
              bottom: 88,
            ), // Space for floating nav
            child: IndexedStack(index: currentIndex, children: screens),
          ),
          // Floating navigation bar
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: CustomBottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          // Center floating button
          Positioned(
            bottom:
                16 +
                36 -
                8, // Nav bar bottom (16) + half nav height (36) - overlap (8) - moved higher
            left:
                MediaQuery.of(context).size.width / 2 -
                32, // Center horizontally
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF8ADC97),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8ADC97).withOpacity(0.4),
                    offset: const Offset(0, 6),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: const Color(0xFF8ADC97).withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                  child: const Center(
                    child: Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFFFFFFF),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
