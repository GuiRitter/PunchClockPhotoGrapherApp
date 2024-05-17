import 'package:flutter/material.dart'
    show
        Align,
        AlignmentDirectional,
        BuildContext,
        CircularProgressIndicator,
        Column,
        CrossAxisAlignment,
        ElevatedButton,
        Expanded,
        ListView,
        MainAxisAlignment,
        MediaQuery,
        Positioned,
        Scaffold,
        SizedBox,
        Stack,
        StatelessWidget,
        Text,
        Widget;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoadingTagModel, StateModel;
import 'package:punch_clock_photo_grapher_app/redux/loading.action.dart'
    as loading_action;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarCustomWidget;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger("LoadingPage");

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<StateModel, List<LoadingTagModel>>(
        distinct: true,
        converter: StateModel.selectLoadingTagList,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    List<LoadingTagModel> loadingTagList,
  ) {
    final mediaSize = MediaQuery.of(
      context,
    ).size;

    _log("connectorBuilder").mapList("loadingTagList", loadingTagList).print();

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
            Expanded(
              child: ListView.builder(
                itemCount: loadingTagList.length,
                itemBuilder: (
                  context,
                  index,
                ) =>
                    Align(
                  child: ElevatedButton(
                    onPressed: () => onCancelPressed(
                      context: context,
                      id: loadingTagList[index].id,
                    ),
                    child: Text(
                      "🛑 ${loadingTagList[index].userFriendlyName} 🛑",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onCancelPressed({
    required BuildContext context,
    required String id,
  }) {
    _log("onCancelPressed").raw("id", id).print();

    final dispatch = getDispatch(
      context: context,
    );

    dispatch(
      loading_action.cancel(
        id: id,
      ),
    );
  }
}
