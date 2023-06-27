import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/camera.page.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/home.page.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/loading.page.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/submit.page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final userBloc = Provider.of<UserBloc>(
      context,
    );

    if (userBloc.isLoading) {
      return const LoadingPage();
    } else if (userBloc.token != null) {
      if (userBloc.photoPath != null) {
        return const SubmitPage();
      } else {
        return FutureBuilder(
          future: getCamera(),
          builder: (
            context,
            snapshot,
          ) =>
              buildCameraPage(
            context: context,
            snapshot: snapshot,
          ),
        );
      }
    } else {
      return HomePage();
    }
  }

  buildCameraPage({
    required BuildContext context,
    required AsyncSnapshot<dynamic> snapshot,
  }) =>
      snapshot.hasData
          ? CameraPage(
              camera: snapshot.data,
            )
          : const LoadingPage();
}
