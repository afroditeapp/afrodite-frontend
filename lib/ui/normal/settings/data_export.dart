
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/data_export.dart';
import 'package:app/model/freezed/logic/settings/data_export.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:openapi/api.dart';

void openDataExportScreen(BuildContext context, String title, AccountId account, DataExportType dataExportType) {
  MyNavigator.push(context, MaterialPage<void>(child:
    DataExportScreen(title: title, account: account, dataExportType: dataExportType),
  ));
}

class DataExportScreen extends StatefulWidget {
  final String title;
  final AccountId account;
  final DataExportType dataExportType;
  const DataExportScreen({
    required this.title,
    required this.account,
    required this.dataExportType,
    super.key,
  });

  @override
  State<DataExportScreen> createState() => _DataExportScreenState();
}

class _DataExportScreenState extends State<DataExportScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          BlocBuilder<DataExportBloc, DataExportData>(
            builder: (context, state) {
              if (state.dataExport == null) {
                return const SizedBox.shrink();
              } else {
                return IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<DataExportBloc>().add(DeleteCurrentDataExport());
                  },
                );
              }
            }
          ),
        ],
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    return BlocBuilder<DataExportBloc, DataExportData>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsetsGeometry.only(top: 8)),
            hPad(Row(
              spacing: 16,
              children: [
                downloadButton(context, state),
                if (state.isLoading) CircularProgressIndicator(),
              ],
            )),
            Padding(padding: EdgeInsetsGeometry.only(top: 8)),
            hPad(Row(
              spacing: 16,
              children: [
                saveButton(context, state),
                Expanded(child: statusText(context, state)),
              ],
            )),
          ],
        );
      }
    );
  }

  Widget statusText(BuildContext context, DataExportData state) {
    final dataExport = state.dataExport;
    if (state.isError) {
      return Text(context.strings.generic_error);
    } else if (dataExport != null) {
      return Text(dataExport.name);
    } else {
      return Text("");
    }
  }

  Widget downloadButton(BuildContext context, DataExportData state) {
    return ElevatedButton(
      onPressed: state.dataExport == null ? () async {
        final r = await showConfirmDialog(context, context.strings.generic_download_question, yesNoActions: true);
        if (r == true && context.mounted) {
          context.read<DataExportBloc>().add(DownloadDataExport(widget.account, widget.dataExportType));
        }
      } : null,
      child: Text(context.strings.generic_download),
    );
  }

  Widget saveButton(BuildContext context, DataExportData state) {
    final dataExport = state.dataExport;
      return ElevatedButton(
        onPressed: dataExport != null ? () async {
          try {
            await FlutterFileSaver().writeFileAsBytes(fileName: dataExport.name, bytes: dataExport.data);
          } catch (_) {
            return;
          }
          showSnackBar(R.strings.generic_action_completed);
        } : null,
        child: Text(context.strings.generic_save),
      );

  }
}
