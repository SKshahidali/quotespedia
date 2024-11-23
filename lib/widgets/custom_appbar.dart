import 'package:flutter/material.dart';
import 'package:quotespedia/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Text(title),
      titleTextStyle: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 24),
      backgroundColor: PediaColors.appbarColor,
      foregroundColor: PediaColors.textColor,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
