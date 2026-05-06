# Emergency Response & Incident Reporting App

A Flutter-based mobile application for smart emergency response and incident reporting that allows users to report incidents, share location details, track response status, and enables administrators to manage and prioritize emergency cases with offline-first support.

## Features

### 📋 Core Features
- **Quick Incident Reporting** - Users can quickly report incidents with essential details
- **Real-time Status Tracking** - Track the status of reported incidents
- **Admin Management Dashboard** - View, manage, and prioritize incidents
- **Search & Filter** - Find incidents by ID, keyword, status, priority, and category
- **Priority Handling** - Automatic priority-based sorting and highlighting
- **Offline Support** - Report incidents offline with sync when connection is restored
- **Color-Coded Priorities** - Visual indicators for incident urgency

### 🎯 Modules

#### 1. **Incident Reporting Module**
- Submit incidents with:
  - Incident Title
  - Description
  - Category (Medical, Fire, Security, Accident, Other)
  - Priority Level (Low, Medium, High, Critical)
  - Location (Manual entry or simulated GPS)
- Automatic Incident ID generation
- Form validation and error handling

#### 2. **Incident Tracking Module**
- View all reported incidents
- Track incident status (Reported → In Progress → Resolved)
- View time of reporting
- View assigned responder information

#### 3. **Admin Management Module**
- View all incidents
- Update incident status
- Assign responders
- Manage incident priorities
- Dashboard statistics and analytics

#### 4. **Priority Handling Logic**
- Incidents sorted by:
  1. Priority (Critical → High → Medium → Low)
  2. Timestamp (Newest first)
- Critical incidents are highlighted with visual warnings
- Real-time priority calculations

#### 5. **Dashboard & Analytics**
- Total incidents count
- Active vs. resolved cases breakdown
- Priority-wise distribution charts
- Real-time statistics updates

#### 6. **Search & Filter Module**
- Search by incident ID or keywords
- Filter by:
  - Status (Reported, In Progress, Resolved)
  - Priority (Critical, High, Medium, Low)
  - Category (Medical, Fire, Security, Accident, Other)
- Combined filter support

#### 7. **Offline Functionality**
- Report incidents without internet connection
- Local storage of incidents
- Automatic sync when connection is restored
- Offline indicator in UI

#### 8. **Validation & Error Handling**
- Required field validation
- Prevent empty or invalid reports
- Clear error messages and confirmations
- User-friendly alerts

## 📱 Screens (5 Minimum)

### 1. **Incident Reporting Screen**
- Quick incident form with all required fields
- Category and priority selection with color coding
- Location input
- Submit button with validation

### 2. **Incident List Screen**
- List of all reported incidents
- Color-coded priority indicators
- Critical incident highlighting
- Tap to view details

### 3. **Incident Details Screen**
- Complete incident information
- Status update dropdown
- Assign responder field
- Delete option
- Admin management actions

### 4. **Admin Dashboard Screen**
- Key statistics (Total, Active, Resolved, Critical)
- Priority distribution chart
- Status breakdown visualization
- Real-time updates

### 5. **Search & Filter Screen**
- Search bar with keyword/ID search
- Multiple filter dropdowns
- Filter results display
- Result count display
- Reset filters option

## 🛠️ Technical Stack

- **Framework**: Flutter 3.8+
- **State Management**: Provider 6.0+
- **Local Storage**: Hive 2.2+
- **UI/UX**: Material 3 Design
- **Utilities**: 
  - UUID for unique ID generation
  - intl for date/time formatting
  - connectivity_plus for network detection

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── incident.dart           # Incident data model
├── providers/
│   └── incident_provider.dart   # State management
└── screens/
    ├── incident_reporting_screen.dart
    ├── incident_list_screen.dart
    ├── incident_details_screen.dart
    ├── admin_dashboard_screen.dart
    └── search_filter_screen.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.8+
- Dart SDK
- Android/iOS development environment

### Installation

1. Clone the repository:
```bash
git clone https://github.com/jignesh140606/MAD_Final.git
cd emergency_response_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📊 Priority Handling Logic

The app uses a sophisticated priority handling system:

1. **Sorting Priority**: Critical → High → Medium → Low
2. **Time-based Sorting**: Within same priority, newer incidents appear first
3. **Visual Indicators**:
   - Critical: Red highlighting and warning icon
   - High: Orange coloring
   - Medium: Yellow coloring
   - Low: Green coloring

## 🔄 Offline Functionality

- Incidents reported offline are stored locally
- When connection is restored, incidents are synced
- User is notified about offline mode
- No data loss even without internet

## 📝 GitHub Commits

1. **Commit 1**: Project Initialization - Flutter setup with dependencies
2. **Commit 2**: UI Implementation - All 5 screens with Material Design
3. **Commit 3**: Core Logic - Incident management and priority handling
4. **Commit 4**: Offline Storage & Final Enhancements

## 📄 Requirements

- Minimum of 5 UI screens ✓
- Color-coded priority levels ✓
- Fast and simple reporting flow ✓
- Clear visual hierarchy for urgent cases ✓
- Modular architecture ✓
- Clean and maintainable code ✓
- Priority + Time-based sorting ✓
- Search & Filter functionality ✓
- Admin dashboard ✓
- Offline support ✓

## 🎨 Color Scheme

- **Primary**: Red (#FF5252) - Emergency/Report
- **Critical**: Red (#F44336)
- **High**: Orange (#FF9800)
- **Medium**: Yellow (#FFC107)
- **Low**: Green (#4CAF50)
- **Dashboard**: Purple (#9C27B0)
- **Search**: Teal (#00BCD4)
- **List**: Blue (#2196F3)

## 📞 Support

For issues or questions, please create an issue in the repository.

## 📜 License

This project is open source and available under the MIT License.

---

**Author**: Jignesh (jignesh140606)
**Last Updated**: May 2026
