import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/components/button/custom_text_button.dart';
import '../../../core/components/text_form_field/custom_text_form_field.dart';
import '../../../core/components/tile/custom_expansion_tile.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/colors_tones.dart';
import '../../../domain/entities/taboo.dart';

class EditTabooCard extends StatelessWidget {
  final Taboo taboo;
  final void Function() onPressedRemove;
  final void Function(String)? onChanged;

  const EditTabooCard({
    super.key,
    required this.taboo,
    required this.onPressedRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      textColor: ColorsTones.black,
      expansionTitle: taboo.word!,
      children: [
        Column(
          children: [
            for (int i = 0;
                i < taboo.forbiddenWords!.split(',').length - 1;
                i++)
              CustomTextFormField(
                controller: TextEditingController(
                  text: taboo.forbiddenWords!.split(',')[i],
                ),
                readOnly: true,
                focusedColor: ColorsTones.black,
                enabledColor: ColorsTones.azure,
                fillColor: ColorsTones.azure3,
                validator: null,
                onChanged: onChanged,
              ),
            CustomTextButton(
              onPressed: onPressedRemove,
              text: LocaleKeys.edit_remove.tr(),
              backgroundColor: ColorsTones.fail,
            ),
          ],
        )
      ],
    );
  }
}
