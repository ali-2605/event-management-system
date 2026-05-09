import 'package:event_management_system/features/auth/auth_models.dart';
import 'package:event_management_system/features/auth/auth_provider.dart';
import 'package:event_management_system/features/events/event_list_screen.dart';
import 'package:event_management_system/features/notifications/notification_list_screen.dart';
import 'package:event_management_system/features/notifications/notification_provider.dart';
import 'package:event_management_system/features/registrations/registration_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    final user = ref.watch(authProvider).value;

    if (user == null) return const Scaffold();

    final isOrganizer = user.role == UserRole.organizer;

    final screens = isOrganizer
        ? [const EventListScreen()]
        : [
            const EventListScreen(),
            const RegistrationListScreen(),
            const NotificationListScreen(),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isOrganizer ? 'Organizer Panel' : 'Event System'),
        actions: [
          _ProfileMenu(user: user),
          const SizedBox(width: 8),
        ],
      ),
      body:
          screens[selectedIndex.value >= screens.length
              ? 0
              : selectedIndex.value],
      bottomNavigationBar: isOrganizer
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex.value,
              onDestinationSelected: (index) => selectedIndex.value = index,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.event_outlined),
                  selectedIcon: Icon(Icons.event),
                  label: 'Events',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.confirmation_number_outlined),
                  selectedIcon: Icon(Icons.confirmation_number),
                  label: 'Tickets',
                ),
                NavigationDestination(
                  icon: Badge(
                    label: Text(unreadCount.toString()),
                    isLabelVisible: unreadCount > 0,
                    child: const Icon(Icons.notifications_outlined),
                  ),
                  selectedIcon: Badge(
                    label: Text(unreadCount.toString()),
                    isLabelVisible: unreadCount > 0,
                    child: const Icon(Icons.notifications),
                  ),
                  label: 'Inbox',
                ),
              ],
            ),
    );
  }
}

class _ProfileMenu extends ConsumerWidget {
  final AuthResponse user;

  const _ProfileMenu({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<int>(
      offset: const Offset(0, 48),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            user.name[0].toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  user.role.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 1,
          onTap: () => ref.read(authProvider.notifier).logout(),
          child: const Row(
            children: [
              Icon(Icons.logout, size: 20, color: Colors.red),
              SizedBox(width: 12),
              Text('Logout', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
