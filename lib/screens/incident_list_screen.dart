import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/incident_provider.dart';
import 'incident_details_screen.dart';

class IncidentListScreen extends StatelessWidget {
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident List'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Consumer<IncidentProvider>(
        builder: (context, provider, _) {
          final incidents = provider.incidents;

          if (incidents.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No incidents reported yet',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: incidents.length,
            itemBuilder: (context, index) {
              final incident = incidents[index];
              final isCritical = incident.priority == 'Critical';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: isCritical ? 5 : 1,
                color: isCritical ? Colors.red.withOpacity(0.05) : Colors.white,
                child: ListTile(
                  leading: Container(
                    width: 8,
                    decoration: BoxDecoration(
                      color: _getPriorityColor(incident.priority),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          incident.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isCritical)
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 18,
                        ),
                    ],
                  ),
                  subtitle: Text(
                    '${incident.category} • ${incident.status}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Chip(
                    label: Text(
                      incident.priority,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    backgroundColor: _getPriorityColor(incident.priority),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            IncidentDetailsScreen(incident: incident),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
