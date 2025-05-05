// import 'package:flutter/material.dart'
//     show
//         BuildContext,
//         InputDecoration,
//         StatelessWidget,
//         TextEditingController,
//         TextFormField,
//         TextInputType,
//         Widget;
// import 'package:flutter_guiritter/common/common.import.dart'
//     as common_gui_ritter show AppLocalizationsGuiRitter;
// import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
// import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
//     show AppLocalizations;
// import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
//     show StateModel, L10nModel;

// class TextFormFieldL10n extends StatelessWidget {
//   final String autofillHint;
//   final TextEditingController? controller;

//   final String Function(
//     common_gui_ritter.AppLocalizationsGuiRitter?,
//   )? invalidMessageL10nGuiRitter;

//   final String Function(
//     AppLocalizations?,
//   )? invalidMessageL10n;

//   final TextInputType keyboardType;

//   final String Function(
//     common_gui_ritter.AppLocalizationsGuiRitter?,
//   )? labelL10nGuiRitter;

//   final String Function(
//     AppLocalizations?,
//   )? labelL10n;

//   final bool? obscureText;

//   const TextFormFieldL10n({
//     super.key,
//     required this.autofillHint,
//     required this.controller,
//     this.invalidMessageL10nGuiRitter,
//     this.invalidMessageL10n,
//     required this.keyboardType,
//     this.labelL10nGuiRitter,
//     this.labelL10n,
//     this.obscureText,
//   });

//   @override
//   Widget build(
//     BuildContext context,
//   ) =>
//       StoreConnector<StateModel, L10nModel>(
//         distinct: true,
//         converter: L10nModel.select,
//         builder: connectorBuilder,
//       );

//   Widget connectorBuilder(
//     BuildContext context,
//     L10nModel l10nModel,
//   ) {
//     return TextFormField(
//       autofillHints: [
//         autofillHint,
//       ],
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: getLabel(
//           l10nModel,
//         ),
//       ),
//       keyboardType: keyboardType,
//       obscureText: obscureText ?? false,
//       validator: (
//         value,
//       ) =>
//           (value?.isEmpty ?? true)
//               ? getInvalidMessage(
//                   l10nModel,
//                 )
//               : null,
//     );
//   }

//   String getInvalidMessage(
//     L10nModel l10nModel,
//   ) =>
//       (invalidMessageL10nGuiRitter != null)
//           ? invalidMessageL10nGuiRitter!(l10nModel.l10nGuiRitter!)
//           : (invalidMessageL10n != null)
//               ? invalidMessageL10n!(l10nModel.l10n!)
//               : "";

//   String getLabel(
//     L10nModel l10nModel,
//   ) =>
//       (labelL10nGuiRitter != null)
//           ? labelL10nGuiRitter!(l10nModel.l10nGuiRitter!)
//           : (labelL10n != null)
//               ? labelL10n!(l10nModel.l10n!)
//               : "";
// }
