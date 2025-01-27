import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData suffixIcon;
  final Function iconPressed;
  final Color? filledColor;
  final Function? onSubmit;
  final Function? onChanged;
  const SearchField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.suffixIcon,
      required this.iconPressed,
      this.filledColor,
      this.onSubmit,
      this.onChanged})
      : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: robotoRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Theme.of(context).disabledColor),
            border: InputBorder.none,
        // border: OutlineInputBorder(
          
        //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        //     borderSide: BorderSide(
        //     // color:Colors.red ?? Colors.green,
        //     width: 1.0,
        //   ),
        //   ),
        filled: true,
        fillColor: widget.filledColor ?? Theme.of(context).cardColor,
        isDense: true,
        suffixIcon: IconButton(
          onPressed: widget.iconPressed as void Function()?,
          icon: Icon(widget.suffixIcon,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
      onSubmitted: widget.onSubmit as void Function(String)?,
      onChanged: widget.onChanged as void Function(String)?,
    );
  }
}
