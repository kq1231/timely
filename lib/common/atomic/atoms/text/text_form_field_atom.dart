import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class TextFormFieldAtom extends TextFormField {
  TextFormFieldAtom(
      {super.key,
      required super.initialValue,
      required super.onChanged,
      required hintText,
      super.textCapitalization,
      bool? isTextArea})
      : super(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSizes.r_8),
              ),
            ),
            filled: true,
            fillColor: AppColors.scale_05,
            hintText: hintText,
          ),
          maxLines: isTextArea == true ? 5 : 1,
        );
}
