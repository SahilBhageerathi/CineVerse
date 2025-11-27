part of 'home_bloc.dart';

class HomeState {
  bool isLoading = false;

  // int selectedIndex = 0;

  HomeState copyWith({
    bool? isLoading,
    // int? selectedIndex,
  }) {
    HomeState newState = HomeState();
    newState.isLoading = isLoading ?? this.isLoading;
    // newState.selectedIndex = selectedIndex ?? this.selectedIndex;
    return newState;
  }
}
