import 'package:dio/dio.dart';
import 'package:event_management_system/core/error_extractor.dart';
import 'package:event_management_system/features/notifications/notification_models.dart';
import 'package:event_management_system/features/notifications/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: notificationsAsync.when(
        data: (notifications) => notifications.isEmpty
            ? _buildEmptyState(context)
            : RefreshIndicator(
                onRefresh: () => ref.refresh(notificationsProvider.future),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationTile(notification: notification);
                  },
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'All caught up!',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          const Text('No new notifications at the moment.'),
        ],
      ),
    );
  }
}

class NotificationTile extends ConsumerWidget {
  final NotificationResponse notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: notification.read
          ? null
          : Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getIconColor(
            notification.type,
          ).withValues(alpha: 0.1),
          child: Icon(
            _getIcon(notification.type),
            color: _getIconColor(notification.type),
          ),
        ),
        title: Text(
          notification.message,
          style: TextStyle(
            fontWeight: notification.read ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().add_jm().format(notification.createdAt),
          style: const TextStyle(fontSize: 12),
        ),
        trailing: notification.read
            ? null
            : Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
        onTap: () {
          if (!notification.read) {
            try {
              ref
                  .read(notificationsProvider.notifier)
                  .toggleRead(notification.notificationId);
            } catch (e) {
              if (context.mounted) {
                final errorMessage = e is DioException
                    ? extractErrorMessage(e)
                    : 'Failed to mark as read';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }
        },
      ),
    );
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.updated:
        return Icons.edit_notifications_outlined;
      case NotificationType.canceled:
        return Icons.event_busy_outlined;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.updated:
        return Colors.blue;
      case NotificationType.canceled:
        return Colors.red;
    }
  }
}
