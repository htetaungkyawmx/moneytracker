import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'providers/category_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MoneyTrackerApp());
}

class MoneyTrackerApp extends StatelessWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Money Tracker',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: provider.cardColor ?? Colors.teal,
                brightness: Brightness.light,
              ),
              cardTheme: CardThemeData(
                clipBehavior: Clip.antiAlias, // Smooth card edges
                color: provider.cardColor?.withOpacity(0.1), // Subtle card background
                shadowColor: provider.cardColor?.withOpacity(0.5), // Dynamic shadow
                surfaceTintColor: provider.cardColor, // Material 3 tint
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: provider.cardColor ?? Colors.teal,
                brightness: Brightness.dark,
              ),
              cardTheme: CardThemeData(
                clipBehavior: Clip.antiAlias,
                color: provider.cardColor?.withOpacity(0.2),
                shadowColor: provider.cardColor?.withOpacity(0.3),
                surfaceTintColor: provider.cardColor,
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}