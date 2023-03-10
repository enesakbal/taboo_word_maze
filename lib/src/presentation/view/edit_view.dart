import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../config/router/app_router.dart';
import '../../core/components/dialogs/yes_no_dialog/yes_no_dialog.dart';
import '../../core/components/text_form_field/custom_text_form_field.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/theme/colors_tones.dart';
import '../_widgets/card/edit_taboo_card.dart';
import '../bloc/edit/edit_bloc.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final TextEditingController searchBarController = TextEditingController();

  @override
  void initState() {
    context.read<EditBloc>().add(const GetAllData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditBloc, EditState>(
      listener: (context, state) {
        print(state);
        if (state is RemovedTaboo) {}
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _gesturedBody(),
      ),
    );
  }

  Widget _gesturedBody() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 4.w,
        ),
        child: Column(
          children: [
            _searchBar(),
            Expanded(
              child: _cardList(),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<EditBloc, EditState> _cardList() {
    return BlocBuilder<EditBloc, EditState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.dataList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return EditTabooCard(
              taboo: state.dataList[index],
              onChanged: (text) {},
              onPressedRemove: () async {
                await YesNoDialog(
                  onPressedYes: () async {
                    context
                        .read<EditBloc>()
                        .add(RemoveTaboo(state.dataList[index]));
                    searchBarController.text = '';
                    await router.pop();
                  },
                  contentText: LocaleKeys.edit_yes_no_dialog_content.tr(),
                  headerText: state.dataList[index].word!,
                ).show(context);
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 3.h);
          },
        );
      },
    );
  }

  CustomTextFormField _searchBar() {
    return CustomTextFormField(
      controller: searchBarController,
      validator: null,
      hintText: LocaleKeys.edit_search.tr(),
      enabledColor: ColorsTones.azure,
      focusedColor: ColorsTones.black,
      fillColor: ColorsTones.success.withOpacity(1),
      prefixIcon: const Icon(Icons.search),
      prefixIconColor: ColorsTones.azure,
      suffixIcon: GestureDetector(
        onTap: () {
          context.read<EditBloc>().add(const FilterAllData(''));
          searchBarController.text = '';
        },
        child: const Icon(Icons.close),
      ),
      suffixIconColor: ColorsTones.azure,
      onChanged: (text) => context.read<EditBloc>().add(FilterAllData(text)),
    );
  }
}
