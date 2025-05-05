import 'dart:math';

import 'package:flutter/material.dart'
    show
        BoxFit,
        BuildContext,
        Center,
        CircularProgressIndicator,
        MediaQuery,
        Scaffold,
        SizedBox,
        Stack,
        StatelessWidget,
        Widget;
import 'package:flutter_svg/svg.dart' show SvgPicture;

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final mediaSize = MediaQuery.of(
      context,
    ).size;

    final smallestSize = min(
      mediaSize.height,
      mediaSize.width,
    );

    final smallestSizeHalf = smallestSize / 2;

    return Scaffold(
      body: SizedBox(
        height: mediaSize.height,
        width: mediaSize.width,
        child: Stack(
          // fit: StackFit.passthrough,
          children: [
            SvgPicture.asset(
              'asset/logo_background_texture.svg',
              semanticsLabel: 'logo background imitating wood',
              fit: BoxFit.fill,
              height: mediaSize.height,
              width: mediaSize.width,
            ),
            Center(
              child: SizedBox(
                width: smallestSizeHalf,
                height: smallestSizeHalf,
                child: SvgPicture.asset(
                  'asset/logo.svg',
                  semanticsLabel: 'logo representing a matrix of receipts',
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: smallestSizeHalf,
                height: smallestSizeHalf,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
