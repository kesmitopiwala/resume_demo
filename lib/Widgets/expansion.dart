import 'package:flutter/material.dart';
import 'package:resume_demo/Utils/constants.dart';


class BorderedExpansionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;

  const BorderedExpansionTile({Key? key, required this.title, this.subtitle, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        visualDensity: VisualDensity.compact,
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: AppColor.blackColor)),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.all(0),
          title: Text(title),
          subtitle: subtitle == null ? null : Text(subtitle!),
          children: children,
        ),
      ),
    );
  }
}
