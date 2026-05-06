import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/incident.dart';
import '../providers/incident_provider.dart';

class IncidentReportingScreen extends StatefulWidget {
  @override
  State<IncidentReportingScreen> createState() =>
      _IncidentReportingScreenState();
}

class _IncidentReportingScreenState extends State<IncidentReportingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _category = 'Medical';
  String _priority = 'Medium';
  String _location = '';

  final List<String> categories = [
    'Medical',
    'Fire',
    'Security',
    'Accident',
    'Other'
  ];
  final List<String> priorities = ['Low', 'Medium', 'High', 'Critical'];

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
        title: const Text('Report Incident'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Quick Incident Report',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Provide essential details to report an incident',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),

              // Title Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Incident Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.title),
                  hintText: 'e.g., Medical Emergency',
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Title is required' : null,
                onChanged: (value) => _title = value,
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.description),
                  hintText: 'Describe the incident in detail',
                ),
                maxLines: 3,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Description is required' : null,
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _category,
                items: categories
                    .map((cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 16),

              // Priority Dropdown with Color
              DropdownButtonFormField<String>(
                value: _priority,
                items: priorities.map((pri) {
                  Color color = _getPriorityColor(pri);
                  return DropdownMenuItem(
                    value: pri,
                    child: Text(pri,
                        style: TextStyle(
                            color: color, fontWeight: FontWeight.bold)),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _priority = value!),
                decoration: InputDecoration(
                  labelText: 'Priority Level',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.flag),
                ),
              ),
              const SizedBox(height: 16),

              // Location Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.location_on),
                  helperText: 'Building, Floor, Room (GPS can be simulated)',
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Location is required' : null,
                onChanged: (value) => _location = value,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitReport,
                  icon: const Icon(Icons.send),
                  label: const Text('Submit Report'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      final incident = Incident(
        id: 'INC-${DateTime.now().millisecondsSinceEpoch}',
        title: _title,
        description: _description,
        category: _category,
        priority: _priority,
        location: _location,
        status: 'Reported',
        timestamp: DateTime.now(),
      );

      Provider.of<IncidentProvider>(context, listen: false)
          .addIncident(incident);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('✓ Incident reported successfully!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }
}
