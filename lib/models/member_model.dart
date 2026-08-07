import 'package:flutter/material.dart';

enum MemberStatus { active, overdue, inactive }

class Member {
  final String id;
  final String name;
  final String memberId;
  final String plan;
  final String lastVisit;
  final MemberStatus status;
  final String avatarUrl;
  final String email;
  final String phone;
  final String joinDate;
  final String branch;
  final int visitsThisMonth;

  Member({
    required this.id,
    required this.name,
    required this.memberId,
    required this.plan,
    required this.lastVisit,
    required this.status,
    required this.avatarUrl,
    this.email = 'member@example.com',
    this.phone = '+1 (555) 000-0000',
    this.joinDate = 'Jan 15, 2023',
    this.branch = 'Downtown Branch',
    this.visitsThisMonth = 12,
  });

  String get statusText {
    switch (status) {
      case MemberStatus.active:
        return 'Active';
      case MemberStatus.overdue:
        return 'Overdue';
      case MemberStatus.inactive:
        return 'Inactive';
    }
  }

  Color get statusColor {
    switch (status) {
      case MemberStatus.active:
        return const Color(0xFF16A34A); // Green
      case MemberStatus.overdue:
        return const Color(0xFFDC2626); // Red
      case MemberStatus.inactive:
        return const Color(0xFF64748B); // Grey
    }
  }

  Color get statusBgColor {
    switch (status) {
      case MemberStatus.active:
        return const Color(0xFFDCFCE7);
      case MemberStatus.overdue:
        return const Color(0xFFFEE2E2);
      case MemberStatus.inactive:
        return const Color(0xFFF1F5F9);
    }
  }
}

class MemberRepository {
  static List<Member> members = [
    Member(
      id: '1',
      name: 'Marcus Johnson',
      memberId: '#49201',
      plan: 'Premium Annual',
      lastVisit: 'Today, 08:30 AM',
      status: MemberStatus.active,
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=250',
      email: 'marcus.j@example.com',
      phone: '+1 (555) 234-5678',
      joinDate: 'Jan 10, 2022',
      branch: 'Downtown Branch',
      visitsThisMonth: 18,
    ),
    Member(
      id: '2',
      name: 'Sarah Chen',
      memberId: '#38192',
      plan: 'Standard Monthly',
      lastVisit: '3 days ago',
      status: MemberStatus.overdue,
      avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&q=80&w=250',
      email: 'sarah.c@example.com',
      phone: '+1 (555) 987-6543',
      joinDate: 'Mar 22, 2023',
      branch: 'Uptown Fitness',
      visitsThisMonth: 8,
    ),
    Member(
      id: '3',
      name: 'Elijah Davis',
      memberId: '#51023',
      plan: 'Basic Weekly',
      lastVisit: 'Yesterday',
      status: MemberStatus.active,
      avatarUrl: '', // Will render initials ED
      email: 'elijah.d@example.com',
      phone: '+1 (555) 456-7890',
      joinDate: 'Nov 05, 2023',
      branch: 'Downtown Branch',
      visitsThisMonth: 15,
    ),
    Member(
      id: '4',
      name: 'Robert Wilson',
      memberId: '#29014',
      plan: 'Premium Annual',
      lastVisit: '2 months ago',
      status: MemberStatus.inactive,
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=250',
      email: 'robert.w@example.com',
      phone: '+1 (555) 345-6789',
      joinDate: 'Feb 14, 2021',
      branch: 'Eastside Gym',
      visitsThisMonth: 0,
    ),
    Member(
      id: '5',
      name: 'Alex Mercer',
      memberId: '#39481',
      plan: 'Pro Member',
      lastVisit: 'Today, 10:15 AM',
      status: MemberStatus.active,
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=250',
      email: 'alex.m@example.com',
      phone: '+1 (555) 123-4567',
      joinDate: 'Oct 12, 2022',
      branch: 'Downtown Branch',
      visitsThisMonth: 14,
    ),
  ];
}
