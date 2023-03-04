import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/components/button/custom_text_button.dart';
import '../../core/components/text_form_field/custom_text_form_field.dart';
import '../../core/components/tile/custom_expansion_tile.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/theme/colors_tones.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entities/taboo.dart';

class EditTabooCard extends StatelessWidget {
  final Taboo taboo;
  final void Function() onPressedRemove;

  const EditTabooCard({
    super.key,
    required this.taboo,
    required this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      onExpansionChanged: (p0) => null,
      textColor: ColorsTones2.black,
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
                focusedColor: ColorsTones2.black,
                enabledColor: ColorsTones2.azure,
                fillColor: ColorsTones2.azure3,
                validator: null,
              ),
            Row(
              children: [
                Expanded(
                  child: CustomTextButton(
                    onPressed: () {},
                    text: LocaleKeys.edit_save.tr(),
                    backgroundColor: ColorsTones2.success,
                    isEnabled: false,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: CustomTextButton(
                    onPressed: onPressedRemove,
                    text: LocaleKeys.edit_remove.tr(),
                    backgroundColor: ColorsTones2.fail,

                    //!
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
