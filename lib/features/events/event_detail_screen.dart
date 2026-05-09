import 'package:event_management_system/features/auth/auth_models.dart';
import 'package:event_management_system/features/auth/auth_provider.dart';
import 'package:event_management_system/features/events/edit_event_screen.dart';
import 'package:event_management_system/features/events/event_models.dart';
import 'package:event_management_system/features/events/event_provider.dart';
import 'package:event_management_system/features/registrations/registration_models.dart';
import 'package:event_management_system/features/registrations/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends ConsumerWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailsProvider(eventId));
    final user = ref.watch(authProvider).value;

    return Scaffold(
      body: eventAsync.when(
        data: (event) => _buildContent(context, ref, event, user),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Could not load event details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This event might have been removed or you may have lost connection.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        ref.invalidate(eventDetailsProvider(eventId)),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: eventAsync.when(
        data: (event) {
          final isOrganizer = user?.role == UserRole.organizer;
          if (isOrganizer || event.status == EventStatus.canceled) return null;
          return _buildBottomBar(context, ref, event);
        },
        loading: () => null,
        error: (_, __) => null,
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    WidgetRef ref,
    EventResponse event,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await ref
                  .read(registrationsProvider.notifier)
                  .registerForEvent(event.eventId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Registration successful! Your ticket is in the "Tickets" tab.',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Failed to register. Please check if the event is full.',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: const Text('Register for Event'),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    EventResponse event,
    AuthResponse? user,
  ) {
    final isCanceled = event.status == EventStatus.canceled;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          pinned: true,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Event Info'),
            centerTitle: true,
          ),
          actions: [
            if (user?.role == UserRole.organizer && !isCanceled)
              PopupMenuButton<int>(
                icon: const Icon(Icons.more_vert),
                onSelected: (val) async {
                  if (val == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditEventScreen(event: event),
                      ),
                    );
                  } else if (val == 2) {
                    final confirmed = await _showCancelDialog(context);
                    if (confirmed == true) {
                      await ref
                          .read(eventsProvider.notifier)
                          .cancelEvent(event.eventId);
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 1, child: Text('Edit Event')),
                  const PopupMenuItem(
                    value: 2,
                    child: Text(
                      'Cancel Event',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCanceled)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.red),
                        SizedBox(width: 12),
                        Text(
                          'Event Canceled',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: isCanceled ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 24),
                _InfoTile(
                  icon: Icons.calendar_today_outlined,
                  title: DateFormat.yMMMMEEEEd().format(event.startsAt),
                  subtitle:
                      '${DateFormat.jm().format(event.startsAt)} - ${DateFormat.jm().format(event.endsAt)}',
                ),
                const SizedBox(height: 16),
                _InfoTile(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  subtitle: event.location,
                ),
                const SizedBox(height: 16),
                _InfoTile(
                  icon: Icons.people_outline,
                  title: 'Capacity',
                  subtitle: '${event.capacity} total seats',
                ),
                const SizedBox(height: 32),
                const Text(
                  'About this event',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  event.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
                if (user?.role == UserRole.organizer) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Divider(),
                  ),
                  const Text(
                    'Guest List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _AttendeeList(eventId: event.eventId),
                ],
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<bool?> _showCancelDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Event?'),
        content: const Text(
          'This will notify all attendees. This action cannot be reversed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Go Back'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Confirm Cancellation'),
          ),
        ],
      ),
    );
  }
}

class _AttendeeList extends ConsumerWidget {
  final String eventId;

  const _AttendeeList({required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationsAsync = ref.watch(eventRegistrationsProvider(eventId));

    return registrationsAsync.when(
      data: (regs) => regs.isEmpty
          ? Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('No guests have registered yet.'),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: regs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final reg = regs[index];
                final isActive = reg.status == RegistrationStatus.active;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: isActive
                        ? Colors.indigo.shade50
                        : Colors.grey.shade100,
                    child: Icon(
                      Icons.person,
                      color: isActive ? Colors.indigo : Colors.grey,
                    ),
                  ),
                  title: Text(
                    'Attendee ID: ${reg.attendeeId.substring(0, 8)}',
                    style: TextStyle(
                      color: isActive ? Colors.black : Colors.grey,
                      decoration: isActive ? null : TextDecoration.lineThrough,
                    ),
                  ),
                  subtitle: Text(
                    'Joined ${DateFormat.yMMMd().format(reg.registeredAt)}',
                  ),
                  trailing: Text(
                    isActive ? 'ACTIVE' : 'CANCELED',
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, __) => const Text('Unable to load guest list.'),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
