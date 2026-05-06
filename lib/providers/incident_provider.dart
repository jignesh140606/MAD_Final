import 'package:flutter/material.dart';
import '../models/incident.dart';

class IncidentProvider extends ChangeNotifier {
  List<Incident> _incidents = [];
  List<Incident> _offlineIncidents = [];
  List<Incident> get incidents {
    final allIncidents = [..._incidents, ..._offlineIncidents];
    // Priority Handling Logic: Sort by priority + time
    allIncidents.sort((a, b) {
      final priorityOrder = <String, int>{
        'Critical': 0,
        'High': 1,
        'Medium': 2,
        'Low': 3
      };
      final priorityCompare = priorityOrder[a.priority]!
          .compareTo(priorityOrder[b.priority]!);

      if (priorityCompare != 0) return priorityCompare;
      return b.timestamp.compareTo(a.timestamp);
    });
    return allIncidents;
  }

  // Get critical incidents (for highlighting)
  List<Incident> get criticalIncidents =>
      incidents.where((i) => i.priority == 'Critical').toList();

  void addIncident(Incident incident, {bool isOffline = false}) {
    if (isOffline) {
      _offlineIncidents.add(incident);
    } else {
      _incidents.add(incident);
    }
    notifyListeners();
  }

  void updateIncident(String id, Incident updatedIncident) {
    final index = _incidents.indexWhere((i) => i.id == id);
    if (index != -1) {
      _incidents[index] = updatedIncident;
      notifyListeners();
    } else {
      final offlineIndex = _offlineIncidents.indexWhere((i) => i.id == id);
      if (offlineIndex != -1) {
        _offlineIncidents[offlineIndex] = updatedIncident;
        notifyListeners();
      }
    }
  }

  void deleteIncident(String id) {
    _incidents.removeWhere((i) => i.id == id);
    _offlineIncidents.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  // Sync offline incidents
  void syncOfflineIncidents() {
    _incidents.addAll(_offlineIncidents);
    _offlineIncidents.clear();
    notifyListeners();
  }

  // Statistics
  int getTotalIncidents() => incidents.length;
  int getActiveIncidents() =>
      incidents.where((i) => i.status != 'Resolved').length;
  int getResolvedIncidents() =>
      incidents.where((i) => i.status == 'Resolved').length;
  int getCriticalCount() =>
      incidents.where((i) => i.priority == 'Critical').length;
  int getHighCount() =>
      incidents.where((i) => i.priority == 'High').length;
  int getMediumCount() =>
      incidents.where((i) => i.priority == 'Medium').length;
  int getLowCount() =>
      incidents.where((i) => i.priority == 'Low').length;
}
