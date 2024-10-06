import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/features/player/view/mini_player_bottom_padding.dart';

class SimpleSettingsPage extends HookConsumerWidget {
  const SimpleSettingsPage({
    super.key,
    this.title,
    this.sections,
  });

  final Widget? title;
  final List<AbstractSettingsSection>? sections;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(
      //   title: title,
      // ),
      // body: body,
      // an app bar which is bigger than the default app bar but on scroll shrinks to the default app bar with the title being animated
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: title,
              // background: Theme.of(context).primaryColor,
            ),
          ),
          if (sections != null)
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: SettingsList(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      sections: sections!,
                    ),
                  ),
                ],
              ),
            ),
          // some padding at the bottom
          const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          SliverToBoxAdapter(child: MiniPlayerBottomPadding()),
        ],
      ),
    );
  }
}
