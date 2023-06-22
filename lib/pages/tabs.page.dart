import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/pages/home.page.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/pages/loading.page.dart';

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
    } else {
      return HomePage();
    }
  }
}
