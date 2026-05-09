import 'package:event_management_system/features/auth/auth_models.dart';
import 'package:event_management_system/features/auth/auth_provider.dart';
import 'package:event_management_system/features/events/create_event_screen.dart';
import 'package:event_management_system/features/events/event_detail_screen.dart';
import 'package:event_management_system/features/events/event_models.dart';
import 'package:event_management_system/features/events/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventListScreen extends HookConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final isOrganizer = user?.role == UserRole.organizer;
    final showOnlyMine = useState(false);

    final eventsAsync = showOnlyMine.value
        ? ref.watch(myEventsProvider)
        : ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          showOnlyMine.value ? 'My Managed Events' : 'Discover Events',
        ),
        bottom: isOrganizer
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All Events'),
                        selected: !showOnlyMine.value,
                        onSelected: (val) => showOnlyMine.value = false,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('My Events'),
                        selected: showOnlyMine.value,
                        onSelected: (val) => showOnlyMine.value = true,
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
      body: eventsAsync.when(
        data: (events) => events.isEmpty
            ? _buildEmptyState(context, showOnlyMine.value)
            : RefreshIndicator(
                onRefresh: () => showOnlyMine.value
                    ? ref.read(myEventsProvider.notifier).refresh()
                    : ref.refresh(eventsProvider.future),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventCard(event: event);
                  },
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => _buildErrorState(context, ref, err),
      ),
      floatingActionButton: isOrganizer
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateEventScreen()),
                );
              },
              label: const Text('Host Event'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isFiltered) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            isFiltered
                ? 'You haven\'t hosted any events yet'
                : 'No events found',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            isFiltered
                ? 'Tap "Host Event" to get started!'
                : 'Check back later for new events!',
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We couldn\'t load the events. Please check your internet connection.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => ref.invalidate(eventsProvider),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventResponse event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isCanceled = event.status == EventStatus.canceled;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EventDetailScreen(eventId: event.eventId),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBadge(
                    context,
                    isCanceled ? 'Canceled' : 'Active',
                    isCanceled ? Colors.red : Colors.green,
                  ),
                  Text(
                    DateFormat.yMMMd().format(event.startsAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: isCanceled ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.location,
                      style: TextStyle(color: Colors.grey.shade600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Capacity: ${event.capacity}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
