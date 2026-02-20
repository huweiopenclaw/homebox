import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for user preferences
final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>(
  (ref) => UserPreferencesNotifier(),
);

class UserPreferences {
  final bool darkMode;
  final bool notifications;
  final String defaultRoom;
  final int itemsPerPage;
  final String sortBy; // 'name', 'date', 'room'
  final bool sortAscending;

  const UserPreferences({
    this.darkMode = false,
    this.notifications = true,
    this.defaultRoom = '全部',
    this.itemsPerPage = 20,
    this.sortBy = 'date',
    this.sortAscending = false,
  });

  UserPreferences copyWith({
    bool? darkMode,
    bool? notifications,
    String? defaultRoom,
    int? itemsPerPage,
    String? sortBy,
    bool? sortAscending,
  }) {
    return UserPreferences(
      darkMode: darkMode ?? this.darkMode,
      notifications: notifications ?? this.notifications,
      defaultRoom: defaultRoom ?? this.defaultRoom,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      sortBy: sortBy ?? this.sortBy,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }
}

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(const UserPreferences());

  void toggleDarkMode() {
    state = state.copyWith(darkMode: !state.darkMode);
  }

  void setDarkMode(bool value) {
    state = state.copyWith(darkMode: value);
  }

  void setNotifications(bool value) {
    state = state.copyWith(notifications: value);
  }

  void setDefaultRoom(String room) {
    state = state.copyWith(defaultRoom: room);
  }

  void setItemsPerPage(int count) {
    state = state.copyWith(itemsPerPage: count);
  }

  void setSortBy(String sortBy) {
    state = state.copyWith(sortBy: sortBy);
  }

  void toggleSortOrder() {
    state = state.copyWith(sortAscending: !state.sortAscending);
  }
}

/// Provider for global loading state
final globalLoadingProvider = StateProvider<bool>((ref) => false);

/// Provider for error messages
final errorProvider = StateProvider<String?>((ref) => null);

/// Provider for showing toast messages
final toastProvider = StateProvider<String?>((ref) => null);

/// Provider for search query
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for selected filter
final selectedRoomFilterProvider = StateProvider<String>((ref) => '全部');

/// Provider for selected category filter
final selectedCategoryFilterProvider = StateProvider<String>((ref) => '全部');
