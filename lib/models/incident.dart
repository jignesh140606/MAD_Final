class Incident {
  final String id;
  final String title;
  final String description;
  final String category;
  final String priority;
  final String location;
  String status;
  final DateTime timestamp;
  String? assignedResponder;

  Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.location,
    required this.status,
    required this.timestamp,
    this.assignedResponder,
  });

  // Copy with method for updates
  Incident copyWith({
    String? status,
    String? assignedResponder,
  }) {
    return Incident(
      id: this.id,
      title: this.title,
      description: this.description,
      category: this.category,
      priority: this.priority,
      location: this.location,
      status: status ?? this.status,
      timestamp: this.timestamp,
      assignedResponder: assignedResponder ?? this.assignedResponder,
    );
  }

  // Convert to JSON for backend storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'location': location,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'assignedResponder': assignedResponder,
    };
  }

  // Create from JSON
  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      priority: json['priority'],
      location: json['location'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
      assignedResponder: json['assignedResponder'],
    );
  }
}
