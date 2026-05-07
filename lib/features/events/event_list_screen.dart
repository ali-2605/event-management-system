import 'package:event_management_system/features/auth/auth_provider.dart';
import 'package:event_management_system/features/events/create_event_screen.dart';
import 'package:event_management_system/features/events/event_detail_screen.dart';
import 'package:event_management_system/features/events/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: eventsAsync.when(
        data: (events) => RefreshIndicator(
          onRefresh: () => ref.refresh(eventsProvider.future),
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                title: Text(event.title),
                subtitle: Text(
                  '${DateFormat.yMMMd().format(event.startsAt)} - ${event.location}',
                ),
                trailing: Text(event.status.name),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EventDetailScreen(eventId: event.eventId),
                    ),
                  );
                },
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CreateEventScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
