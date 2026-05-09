import 'package:event_management_system/features/events/event_provider.dart';
import 'package:event_management_system/features/registrations/registration_models.dart';
import 'package:event_management_system/features/registrations/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class RegistrationListScreen extends ConsumerWidget {
  const RegistrationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationsAsync = ref.watch(registrationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Tickets')),
      body: registrationsAsync.when(
        data: (registrations) => registrations.isEmpty
            ? _buildEmptyState(context)
            : RefreshIndicator(
                onRefresh: () => ref.refresh(registrationsProvider.future),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: registrations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final registration = registrations[index];
                    return TicketCard(registration: registration);
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
            Icons.confirmation_number_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No tickets found',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          const Text('Go to events and register for one!'),
        ],
      ),
    );
  }
}

class TicketCard extends ConsumerWidget {
  final RegistrationResponse registration;

  const TicketCard({super.key, required this.registration});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailsProvider(registration.eventId));
    final isCanceled = registration.status == RegistrationStatus.canceled;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.qr_code_2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: eventAsync.when(
                    data: (event) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat.yMMMd().format(event.startsAt),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (_, __) =>
                        const Text('Failed to load event details'),
                  ),
                ),
                _buildStatusBadge(registration.status),
              ],
            ),
            if (!isCanceled) ...[
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel Registration?'),
                          content: const Text(
                            'Are you sure you want to cancel your ticket?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No, keep it'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await ref
                                    .read(registrationsProvider.notifier)
                                    .cancelRegistration(
                                      registration.registrationId,
                                    );
                              },
                              child: const Text('Yes, cancel'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.cancel_outlined, size: 18),
                    label: const Text('Cancel Ticket'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 36),
                    ),
                    child: const Text('View Ticket'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(RegistrationStatus status) {
    final color = status == RegistrationStatus.active
        ? Colors.green
        : Colors.red;
    final text = status == RegistrationStatus.active ? 'Active' : 'Canceled';

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
