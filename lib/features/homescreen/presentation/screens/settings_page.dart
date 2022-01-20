import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/strings.dart';
import '../../../../providers.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool notifications = false;
  bool notifications2 = false;

  void handleSwitch(WidgetRef ref, bool value) async {
    ref.read(themeProvider.notifier)
        .changeTheme(CustomTheme.darkThemeData, Strings.darkTheme);
    setState(() {
      notifications = value;
    });
  }

  void handleSwitch2(WidgetRef ref, bool value) async {
    ref.read(themeProvider.notifier)
        .changeTheme(CustomTheme.lightThemeData, Strings.lightTheme);
    setState(() {
      notifications2 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CupertinoSwitch(
            value: notifications,
            // ignore: unnecessary_lambdas
            onChanged: (value) => handleSwitch(ref, value),
          ),
          CupertinoSwitch(
            value: notifications2,
            // ignore: unnecessary_lambdas
            onChanged: (value) => handleSwitch2(ref, value),
          ),
        ],
      ),
    ));
  }
}
