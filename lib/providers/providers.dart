import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==========================================
// AUTHENTICATION PROVIDER (MOCK)
// ==========================================

class AuthState {
  final bool isAuthenticated;
  final String email;
  final String? errorMessage;
  final bool isLoading;

  const AuthState({
    required this.isAuthenticated,
    this.email = '',
    this.errorMessage,
    this.isLoading = false,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? email,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      email: email ?? this.email,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(isAuthenticated: false));

  Future<bool> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please fill in all fields.');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = AuthState(
      isAuthenticated: true,
      email: email.trim(),
      isLoading: false,
    );
    return true;
  }

  void logout() {
    state = const AuthState(isAuthenticated: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// ==========================================
// NAVIGATION PROVIDER
// ==========================================

final navigationIndexProvider = StateProvider<int>((ref) => 0);

// ==========================================
// SCHEDULE PROVIDER (MOCK)
// ==========================================

enum SessionStatus { completed, scheduled, inProgress, cancelled }

class GymSession {
  final String id;
  final String time;
  final String title;
  final String trainer;
  final String? client;
  final SessionStatus status;
  final String duration;

  GymSession({
    required this.id,
    required this.time,
    required this.title,
    required this.trainer,
    this.client,
    required this.status,
    this.duration = '45 min',
  });
}

class ScheduleData {
  final int todayTotal;
  final int ptTotal;
  final int completedTotal;
  final List<GymSession> sessions;

  ScheduleData({
    required this.todayTotal,
    required this.ptTotal,
    required this.completedTotal,
    required this.sessions,
  });
}

final scheduleProvider = Provider<ScheduleData>((ref) {
  return ScheduleData(
    todayTotal: 12,
    ptTotal: 5,
    completedTotal: 8,
    sessions: [
      GymSession(
        id: 's1',
        time: '06:00',
        title: 'Morning PT',
        trainer: 'Arjun',
        client: 'Rahul',
        status: SessionStatus.completed,
      ),
      GymSession(
        id: 's2',
        time: '08:00',
        title: 'Strength Training',
        trainer: 'Karthik',
        status: SessionStatus.scheduled,
      ),
      GymSession(
        id: 's3',
        time: '17:00',
        title: 'Personal Training',
        trainer: 'Priya',
        client: 'Ananya',
        status: SessionStatus.inProgress,
      ),
      GymSession(
        id: 's4',
        time: '18:30',
        title: 'HIIT Session',
        trainer: 'Sarah J.',
        status: SessionStatus.scheduled,
      ),
      GymSession(
        id: 's5',
        time: '20:00',
        title: 'Spin Express',
        trainer: 'Emma L.',
        status: SessionStatus.scheduled,
      ),
    ],
  );
});

// ==========================================
// ANALYTICS PROVIDER (MOCK)
// ==========================================

class AnalyticsMetric {
  final String label;
  final String value;
  final String change;
  final bool isPositive;

  AnalyticsMetric({
    required this.label,
    required this.value,
    required this.change,
    this.isPositive = true,
  });
}

class AnalyticsData {
  final AnalyticsMetric totalRevenue;
  final AnalyticsMetric activeMembers;
  final AnalyticsMetric renewalRate;
  final AnalyticsMetric avgRevPerMember;
  final List<double> monthlyRevenueValues; // Mar to Aug
  final List<String> monthLabels;
  final String aiInsight;

  AnalyticsData({
    required this.totalRevenue,
    required this.activeMembers,
    required this.renewalRate,
    required this.avgRevPerMember,
    required this.monthlyRevenueValues,
    required this.monthLabels,
    required this.aiInsight,
  });
}

final analyticsProvider = Provider<AnalyticsData>((ref) {
  return AnalyticsData(
    totalRevenue: AnalyticsMetric(
      label: 'Total Revenue',
      value: '₹14.8L',
      change: '+12.5%',
    ),
    activeMembers: AnalyticsMetric(
      label: 'Active Members',
      value: '428',
      change: '+8.2%',
    ),
    renewalRate: AnalyticsMetric(
      label: 'Renewal Rate',
      value: '84.6%',
      change: '+4.3%',
    ),
    avgRevPerMember: AnalyticsMetric(
      label: 'Avg Rev/Member',
      value: '₹3,460',
      change: '+6.8%',
    ),
    monthlyRevenueValues: [9.2, 11.5, 10.4, 14.8, 13.6, 15.9],
    monthLabels: ['Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
    aiInsight: 'Membership renewals increased by 14% this month following the morning PT program launch.',
  );
});
