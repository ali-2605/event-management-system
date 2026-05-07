import 'package:event_management_system/features/events/event_provider.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text('Event Details')),
      body: eventAsync.when(
        data: (event) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '${DateFormat.yMMMMEEEEd().add_jm().format(event.startsAt)} - ${DateFormat.jm().format(event.endsAt)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text('Location: ${event.location}'),
              const SizedBox(height: 16),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(event.description),
              const SizedBox(height: 24),
              Text('Capacity: ${event.capacity}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ref
                        .read(registrationsProvider.notifier)
                        .registerForEvent(event.eventId);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Successfully registered!'),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to register: $e')),
                      );
                    }
                  }
                },
                child: const Text('Register for Event'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
