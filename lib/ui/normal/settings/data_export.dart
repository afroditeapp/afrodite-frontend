import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/data_export.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/data_export.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

void openDataExportScreenMyData(BuildContext context) {
  MyNavigator.push(context, DataExportPageMyData(context.read<RepositoryInstances>()));
}

class DataExportPageMyData extends MyScreenPage<()> with SimpleUrlParser<DataExportPageMyData> {
  final RepositoryInstances r;
  DataExportPageMyData(this.r)
    : super(builder: (_) => DataExportScreen(account: r.accountId, allowAdminDataExport: false));

  @override
  DataExportPageMyData create() => DataExportPageMyData(r);
}

class DataExportPageAdmin extends MyScreenPageLimited<()> {
  DataExportPageAdmin(AccountId accountId)
    : super(builder: (_) => DataExportScreen(account: accountId, allowAdminDataExport: true));
}

class DataExportScreen extends StatefulWidget {
  final AccountId account;
  final bool allowAdminDataExport;
  const DataExportScreen({required this.account, required this.allowAdminDataExport, super.key});

  @override
  State<DataExportScreen> createState() => _DataExportScreenState();
}

class _DataExportScreenState extends State<DataExportScreen> {
  DataExportType dataExportType = DataExportType.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.allowAdminDataExport
              ? context.strings.data_export_screen_title_export_type_admin
              : context.strings.data_export_screen_title_export_type_user,
        ),
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
            },
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
            if (widget.allowAdminDataExport) exportTypeSelection(context),
            hPad(
              Row(
                spacing: 16,
                children: [
                  downloadButton(context, state),
                  if (state.isLoading) CircularProgressIndicator(),
                ],
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.only(top: 8)),
            hPad(
              Row(
                spacing: 16,
                children: [
                  saveButton(context, state),
                  Expanded(child: statusText(context, state)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget exportTypeSelection(BuildContext context) {
    return RadioGroup<DataExportType>(
      groupValue: dataExportType,
      onChanged: (_) => setState(() {
        dataExportType = DataExportType.user;
      }),
      child: Row(
        children: [
          Expanded(
            child: RadioListTile<DataExportType>(value: DataExportType.user, title: Text("User")),
          ),
          Expanded(
            child: RadioListTile<DataExportType>(value: DataExportType.admin, title: Text("Admin")),
          ),
        ],
      ),
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
      onPressed: state.dataExport == null
          ? () async {
              final r = await showConfirmDialog(
                context,
                context.strings.generic_download_question,
                yesNoActions: true,
              );
              if (r == true && context.mounted) {
                context.read<DataExportBloc>().add(
                  DownloadDataExport(widget.account, dataExportType),
                );
              }
            }
          : null,
      child: Text(context.strings.generic_download),
    );
  }

  Widget saveButton(BuildContext context, DataExportData state) {
    final dataExport = state.dataExport;
    return ElevatedButton(
      onPressed: dataExport != null && !state.isLoading
          ? () async {
              context.read<DataExportBloc>().add(SaveDataExport(dataExport));
            }
          : null,
      child: Text(context.strings.generic_save),
    );
  }
}
