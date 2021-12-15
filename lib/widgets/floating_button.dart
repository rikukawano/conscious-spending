import 'package:flutter/material.dart';

import '/models/app_color.dart';

class FloatingButton extends StatelessWidget {
  final Function submitData;

  FloatingButton(this.submitData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => submitData(),
      child: Container(
        height: 44,
        width: 130,
        margin: EdgeInsets.only(bottom: 40),
        alignment: AlignmentDirectional.center,
        child: Text(
          'SUBMIT',
          style:
              Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryTransparent,
              AppColor.primary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColor.primary.withOpacity(0.5),
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
