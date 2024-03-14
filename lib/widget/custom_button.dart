import 'package:flutter/material.dart';

class AppCustomButton extends StatelessWidget {
  AppCustomButton(
      {super.key,
      this.loading = false,
      required this.onTap,
      required this.title});

  bool loading;
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: loading ? () {} : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.014),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: loading
              ? Theme.of(context).colorScheme.onBackground.withOpacity(0.8)
              : Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
