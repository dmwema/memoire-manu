import 'package:flutter/material.dart';
import 'package:manu/resource/config/colors.dart';

class ButtonOutlined extends StatelessWidget {
  final bool error;
  final bool warning;
  final String title;
  final double size;
  Color? color;
  bool loading;
  void Function()? onTap;

  ButtonOutlined({
    super.key,
    this.error = false,
    this.warning = false,
    required String this.title,
    this.size = 15,
    this.loading = false,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color ?? AppColors.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(30))
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: loading
                ?
                const CircularProgressIndicator(color: Colors.white,)
                :
                Text(title, style: TextStyle(
                  color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: size
                ),)
          ),
        ),
      );
  }
}