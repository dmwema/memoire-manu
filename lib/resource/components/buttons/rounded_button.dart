import 'package:flutter/material.dart';
import 'package:manu/resource/config/colors.dart';

class RoundedButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color textColor;
  final VoidCallback onPress;
  bool loading = false;

  RoundedButton({
    Key? key,
    required this.title,
    this.color,
    required this.loading,
    this.textColor = Colors.white,
    required this.onPress
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {

  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    final Color color = widget.color ?? AppColors.primaryColor;
    final Color textColor = widget.textColor;
    return InkWell(
      onTap: () {
        if (!widget.loading) {
          widget.onPress();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 1),
        curve: Curves.easeInOut,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: widget.loading ? Colors.black26 : color,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.loading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
            ),
            if (widget.loading)
            const SizedBox(width: 10,),
            Text(title, style: TextStyle(color: textColor, ),),
          ],
        )
      ),
    );
  }
}