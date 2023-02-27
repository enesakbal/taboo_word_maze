import 'package:easy_localization/easy_localization.dart';
import '../lang/locale_keys.g.dart';

extension StringExtension on String {
  String? get isValidTeamName => isNotEmpty
      ? length > 2
          ? null
          : LocaleKeys.home_play_dialog_team_name_error_lenght.tr()
      : LocaleKeys.home_play_dialog_team_name_error_empty.tr();

  //* cannot be empty and the length must be at least 3 char
}
