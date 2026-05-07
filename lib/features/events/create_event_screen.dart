import 'package:event_management_system/features/events/event_models.dart';
import 'package:event_management_system/features/events/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateEventScreen extends HookConsumerWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final locationController = useTextEditingController();
    final capacityController = useTextEditingController();
    final startsAt = useState(DateTime.now().add(const Duration(days: 1)));
    final endsAt = useState(
      DateTime.now().add(const Duration(days: 1, hours: 2)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: capacityController,
              decoration: const InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final request = CreateEventRequest(
                  title: titleController.text,
                  description: descriptionController.text,
                  location: locationController.text,
                  capacity: int.tryParse(capacityController.text) ?? 0,
                  startsAt: startsAt.value,
                  endsAt: endsAt.value,
                );
                await ref.read(eventsProvider.notifier).createEvent(request);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
