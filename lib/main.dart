import 'package:event_management_system/core/theme/app_theme.dart';
import 'package:event_management_system/features/auth/auth_provider.dart';
import 'package:event_management_system/features/auth/login_screen.dart';
import 'package:event_management_system/features/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Event Management System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: authState.when(
        data: (user) => user == null ? const LoginScreen() : const MainScreen(),
        
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
       
        error: (err, stack) => const LoginScreen(),
      ),
    );
  }
}
