import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class EventDescLabel {
  static Widget? widget(Event item) {
    Widget? actionWidget;
    switch (item.actionName) {
      case EventActionNames.approved:
        // ----------------------------------
        var targetIid = item.targetIid.toString();
        var targetTitle = item.targetTitle;
        switch (item.targetType) {
          case EventTargetTypes.mergeRequest:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Approved merge request '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
            break;
        }
        break;
      case EventActionNames.closed:
        // ----------------------------------
        var targetIid = item.targetIid.toString();
        var targetTitle = item.targetTitle;
        switch (item.targetType) {
          case EventTargetTypes.issue:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Closed issue '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
            break;
          case EventTargetTypes.milestone:
            actionWidget = const Text.rich(TextSpan(
              children: [
                TextSpan(text: 'Closed milestone '),
              ],
            ));
            break;
          case EventTargetTypes.mergeRequest:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Closed merge request '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
        }
        break;
      case EventActionNames.commented:
        // ----------------------------------
        var targetIid = item.targetIid.toString();
        var targetTitle = item.targetTitle;
        switch (item.targetType) {
          case EventTargetTypes.issue:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Commented issue '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
            break;
          case EventTargetTypes.milestone:
            actionWidget = const Text.rich(TextSpan(
              children: [
                TextSpan(text: 'Closed milestone '),
              ],
            ));
            break;
          case EventTargetTypes.mergeRequest:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Closed merge request '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
            break;

          case EventTargetTypes.note:
            actionWidget = Text.rich(TextSpan(
              children: [
                TextSpan(text: 'Commented on ' + item.note!.noteableType!),
              ],
            ));

            break;
          case EventTargetTypes.discussionNote:
            actionWidget = Text.rich(TextSpan(
              children: [
                TextSpan(text: item.targetTitle!),
              ],
            ));
            break;
          case EventTargetTypes.diffNote:
            actionWidget = Text.rich(TextSpan(
              children: [
                TextSpan(text: 'Commented on Diff: ' + item.targetTitle!),
              ],
            ));
            break;
        }
        break;
      case EventActionNames.created:
        // ----------------------------------
        actionWidget = const Text('Created project');
        break;
      case EventActionNames.destroyed:
        // ----------------------------------
        var targetIid = item.targetIid.toString();
        var targetTitle = item.targetTitle;
        switch (item.targetType) {
          case EventTargetTypes.issue:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Destroyed issue '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
            break;
          case EventTargetTypes.milestone:
            actionWidget = const Text.rich(TextSpan(
              children: [
                TextSpan(text: 'Destroyed milestone '),
              ],
            ));
            break;
          case EventTargetTypes.mergeRequest:
            break;
        }
        break;
      case EventActionNames.expired:
        // ----------------------------------
        break;
      case EventActionNames.joined:
        // ----------------------------------
        actionWidget = const Text('Joined project');
        break;
      case EventActionNames.left:
        // ----------------------------------
        actionWidget = const Text('Left project');
        break;
      case EventActionNames.merged:
        // ----------------------------------
        break;
      case EventActionNames.pushedNew:
        // ----------------------------------
        actionWidget = Text.rich(TextSpan(
          children: [
            const TextSpan(text: 'Pushed new branch '),
            TextSpan(
                text: item.pushData!.ref,
                style: const TextStyle(
                    fontWeight: CommonConstants.fontWeightListTile)),
          ],
        ));
        break;
      case EventActionNames.pushedTo:
        // ----------------------------------
        actionWidget = Text.rich(TextSpan(
          children: [
            const TextSpan(text: 'Pushed to branch '),
            TextSpan(
                text: item.pushData!.ref,
                style: const TextStyle(
                    fontWeight: CommonConstants.fontWeightListTile)),
          ],
        ));
        break;
      case EventActionNames.reopened:
        // ----------------------------------
        break;
      case EventActionNames.updated:
        // ----------------------------------
        break;
      case EventActionNames.opened:
        // ----------------------------------
        var targetIid = item.targetIid.toString();
        var targetTitle = item.targetTitle;
        switch (item.targetType) {
          case EventTargetTypes.issue:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Opened issue '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
            break;
          case EventTargetTypes.milestone:
            actionWidget = const Text.rich(TextSpan(
              children: [
                TextSpan(text: 'Opened milestone '),
              ],
            ));
            break;
          case EventTargetTypes.mergeRequest:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Opened merge request '),
                TextSpan(text: '#$targetIid '),
                TextSpan(text: '"$targetTitle"'),
              ],
            ));
            break;
          case EventTargetTypes.note:
            // ----------------------------------
            break;
          case EventTargetTypes.project:
            // ----------------------------------
            break;
          case EventTargetTypes.snippet:
            // ----------------------------------
            break;
          case EventTargetTypes.user:
            // ----------------------------------
            break;
        }
        break;
      case EventActionNames.accepted:
        switch (item.targetType) {
          case EventTargetTypes.mergeRequest:
            actionWidget = Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Accepted merge request: '),
                TextSpan(text: item.targetTitle!),
              ],
            ));
            break;
        }

        break;
    }
    return actionWidget;
  }
}
