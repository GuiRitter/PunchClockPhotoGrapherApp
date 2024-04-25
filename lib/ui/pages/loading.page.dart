import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_custom.widget.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

final _log = logger("LoadingPage");

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final mediaSize = MediaQuery.of(
      context,
    ).size;

    // TODO
    final testList = List.generate(
      16,
      (
        int index,
      ) =>
          const Align(
        child: ElevatedButton(
          onPressed: null,
          child: Text(
            "Checking saved credential",
          ),
        ),
      ),
      growable: false,
    );

    return Scaffold(
      appBar: const AppBarCustomWidget(),
      body: SizedBox(
        height: mediaSize.height,
        width: mediaSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Positioned(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
            // const CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: testList.length,
                itemBuilder: (
                  context,
                  index,
                ) =>
                    testList[index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onCancelPressed({
    required BuildContext context,
  }) {
    // TODO
    // _log("onCancelPressed").print();

    // final loadingBloc = Provider.of<LoadingBloc>(
    //   context,
    //   listen: false,
    // );

    // loadingBloc.cancelRequest();
  }
}
