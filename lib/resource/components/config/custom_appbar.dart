import 'package:flutter/material.dart';
import 'package:manu/resource/config/colors.dart';
import 'package:manu/routes/routes_name.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  bool showBack;
  bool? hideNotificationIcon;
  bool showRefresh;
  String? backUrl;
  String? refreshUrl;

  CustomAppBar({Key? key, required this.title, this.showRefresh = false, this.showBack = false, this.hideNotificationIcon, this.backUrl}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.homeView);
            },
            child: Icon(Icons.arrow_back, color: AppColors.primaryColor,),
          ),
          const SizedBox(width: 10,),
          Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor.withOpacity(.9),
                fontSize: 15
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
    );
  }
}