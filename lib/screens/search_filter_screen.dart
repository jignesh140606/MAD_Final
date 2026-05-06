import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/incident_provider.dart';
import 'incident_details_screen.dart';

class SearchFilterScreen extends StatefulWidget {
  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  String _searchQuery = '';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _categoryFilter = 'All';

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
        title: const Text('Search & Filter'),
        backgroundColor: Colors.tealAccent,
        elevation: 0,
      ),
      body: Consumer<IncidentProvider>(
        builder: (context, provider, _) {
          final allIncidents = provider.incidents;

          // Apply Filters
          final filtered = allIncidents.where((incident) {
            bool matchesSearch = _searchQuery.isEmpty ||
                incident.id.contains(_searchQuery) ||
                incident.title.toLowerCase().contains(_searchQuery.toLowerCase());

            bool matchesStatus =
                _statusFilter == 'All' || incident.status == _statusFilter;
            bool matchesPriority = _priorityFilter == 'All' ||
                incident.priority == _priorityFilter;
            bool matchesCategory = _categoryFilter == 'All' ||
                incident.category == _categoryFilter;

            return matchesSearch &&
                matchesStatus &&
                matchesPriority &&
                matchesCategory;
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search by ID or keyword...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () =>
                                setState(() => _searchQuery = ''),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 20),

                // Filters Section
                Text(
                  'Filters',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Status Filter
                DropdownButtonFormField<String>(
                  value: _statusFilter,
                  items: ['All', 'Reported', 'In Progress', 'Resolved']
                      .map((s) =>
                          DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _statusFilter = value!),
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.info),
                  ),
                ),
                const SizedBox(height: 12),

                // Priority Filter
                DropdownButtonFormField<String>(
                  value: _priorityFilter,
                  items: ['All', 'Low', 'Medium', 'High', 'Critical']
                      .map((p) =>
                          DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _priorityFilter = value!),
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.flag),
                  ),
                ),
                const SizedBox(height: 12),

                // Category Filter
                DropdownButtonFormField<String>(
                  value: _categoryFilter,
                  items: [
                    'All',
                    'Medical',
                    'Fire',
                    'Security',
                    'Accident',
                    'Other'
                  ]
                      .map((c) =>
                          DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _categoryFilter = value!),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.category),
                  ),
                ),
                const SizedBox(height: 24),

                // Reset Filters Button
                if (_searchQuery.isNotEmpty ||
                    _statusFilter != 'All' ||
                    _priorityFilter != 'All' ||
                    _categoryFilter != 'All')
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => setState(() {
                        _searchQuery = '';
                        _statusFilter = 'All';
                        _priorityFilter = 'All';
                        _categoryFilter = 'All';
                      }),
                      child: const Text('Reset Filters'),
                    ),
                  ),
                const SizedBox(height: 16),

                // Results Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Results',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.tealAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${filtered.length} found',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Results List
                if (filtered.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No incidents found',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final incident = filtered[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        elevation: 2,
                        child: ListTile(
                          leading: Container(
                            width: 8,
                            decoration: BoxDecoration(
                              color: _getPriorityColor(incident.priority),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          title: Text(
                            incident.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'ID: ${incident.id}',
                            style: const TextStyle(fontSize: 11),
                          ),
                          trailing: Chip(
                            label: Text(
                              incident.priority,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            backgroundColor:
                                _getPriorityColor(incident.priority),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => IncidentDetailsScreen(
                                  incident: incident,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
