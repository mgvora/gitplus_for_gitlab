import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class MilestoneStateLabel extends StatelessWidget {
  final ProjectMilestone item;
  final double? fontSize;

  const MilestoneStateLabel({Key? key, required this.item, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.green;
    var text = 'Open';
    if (item.state == MilestoneState.active &&
        item.dueDate != null &&
        item.dueDate!.isBefore(DateTime.now())) {
      color = Colors.amber;
      text = 'Expired';
    } else if (item.state == MilestoneState.closed) {
      color = Colors.red;
      text = 'Closed';
    }

    return ColorLabel(
      color: color,
      text: text,
      fontSize: fontSize,
    );
  }
}
