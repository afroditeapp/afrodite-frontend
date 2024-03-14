import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup/gender.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/utils/date.dart";


// class AskGenderScreen extends StatelessWidget {
//   const AskGenderScreen({Key? key}) : super(key: key);

//   @override
//   Widget buildRootWidget(BuildContext context) {
//     return commonInitialSetupScreenContent(
//       context: context,
//       child: QuestionAsker(
//         getContinueButtonCallback: (context, state) {
//           final birthdate = state.birthdate;
//           if (birthdate != null && birthdate.isNowAdult()) {
//             return () {
//               Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen))
//             };
//           } else {
//             return null;
//           }
//         },
//         question: const AskBirthdate(),
//       ),
//     );
//   }
// }
