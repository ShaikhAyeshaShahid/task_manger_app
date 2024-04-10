import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/size_config.dart';
class TaskManagerPasswordTextField extends StatefulWidget {
  final String hintText;
  final bool visibility;
  final Icon prefixIcon;
  final bool? enabled;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const TaskManagerPasswordTextField({
    Key? key,
    required this.hintText,
    required this.visibility,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    this.enabled,
  }) : super(key: key);

  @override
  State<TaskManagerPasswordTextField> createState() =>
      _TaskManagerPasswordTextFieldState();
}

class _TaskManagerPasswordTextFieldState extends State<TaskManagerPasswordTextField> {
  bool _visibility = true;

  @override
  void initState() {
    _visibility = !widget.visibility;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity((widget.enabled ?? true) ? 0.15 : 0.1),
            blurRadius: SizeConfig.width(context, 0.05),
            // blurRadius: SizeConfig.width(context, 0.01),
            // soften the shadow
            // spreadRadius:(widget.enabled ?? true) ? SizeConfig.width(context, 0.005) : 0,
            spreadRadius:(widget.enabled ?? true) ? SizeConfig.width(context, 0.005) : 0,
            //extend the shadow
            offset: (widget.enabled ?? true) ? Offset(
              SizeConfig.width(context, 0.01), // Move to right 5  horizontally
              // SizeConfig.width(context, 0.01), // Move to bottom 5 Vertically
              SizeConfig.width(context, 0.02), // Move to bottom 5 Vertically
            ) : Offset.zero,
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        obscureText: _visibility,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: _visibility
              ? InkWell(
            onTap: () {
              setState(() => _visibility = false);
            },
            child: const Icon(Icons.visibility_off),
          )
              : InkWell(
            onTap: () {
              setState(() => _visibility = true);
            },
            child: const Icon(Icons.visibility),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
              SizeConfig.width(context, 0.03),
            ),
          ),
          // contentPadding: const EdgeInsets.symmetric(vertical: 0),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            // vertical: SizeConfig.height(context, 0.03),
            vertical: SizeConfig.height(context, 0.01),
            horizontal: SizeConfig.width(context, 0.03),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
