// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../theme/colors.dart';

class FeatureLabel extends StatelessWidget {
  FeatureLabel(
      {super.key,
      required this.label,
      this.wantPadding = true,
      this.showAllButton = false,
      this.style,
      this.onClickShowAll,
      this.showAllWidget,
      this.onClick,
      this.clickable = false});

  final String label;
  final bool wantPadding;
  final bool clickable;
  final bool showAllButton;
  final Function? onClickShowAll;
  final Widget? showAllWidget;
  TextStyle? style;
  Function? onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: view(label: label, wantPadding: wantPadding),
    );
  }

  Widget view({required String label, bool wantPadding = true}) {
    return Padding(
      padding: !wantPadding
          ? EdgeInsets.zero
          : const EdgeInsets.only(left: 16, right: 16),
      child: InkWell(
        onTap: !clickable
            ? null
            : () {
                onClick!();
              },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label',
              style: style ??
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const Spacer(),
            if (showAllButton)
              InkWell(
                onTap: () {
                  onClickShowAll!();
                },
                child: showAllWidget ??
                    const Text(
                      'View All',
                      style:
                          TextStyle(color: AppColor.primaryOrangeColor),
                    ),
              )
          ],
        ),
      ),
    );
  }
}
