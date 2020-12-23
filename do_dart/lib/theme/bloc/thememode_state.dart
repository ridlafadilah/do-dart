part of 'thememode_bloc.dart';

class ThemeModeState extends CommonState {
  const ThemeModeState({this.themeMode});

  final ThemeMode themeMode;

  @override
  List<ThemeMode> get props => [themeMode];
}
