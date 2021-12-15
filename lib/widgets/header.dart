import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final bool isSecondRoute;

  Header({required this.title, required this.isSecondRoute});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSecondRoute)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
