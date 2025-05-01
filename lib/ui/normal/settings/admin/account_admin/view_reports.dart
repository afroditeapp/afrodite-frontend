
import 'package:app/data/login_repository.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/report/process_reports.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ViewReportsScreen extends ContentDecicionScreen<WrappedReportDetailed> {
  ViewReportsScreen({
    required AccountId account,
    required ReportIteratorMode mode,
    required super.title,
    super.key,
  }) : super(
    infoMessageRowHeight: ROW_HEIGHT,
    screenInstructions: ReportUiBuilder.instructions,
    io: ViewReportReportIo(account, mode),
    builder: ViewReportUiBuilder(),
  );
}

class ViewReportReportIo extends ContentIo<WrappedReportDetailed> {
  final api = LoginRepository.getInstance().repositories.api;
  ViewReportReportIo(this.account, this.mode);

  AccountId account;
  ReportIteratorMode mode;

  UnixTime? startPosition;
  int page = 0;

  Set<ReportId> addedReports = {};

  @override
  Future<Result<List<WrappedReportDetailed>, void>> getNextContent() async {
    final currentStartPosition = startPosition;
    final UnixTime start;
    if (currentStartPosition == null) {
      final s = await api.accountCommonAdmin((api) => api.getLatestReportIteratorStartPosition()).ok();
      if (s == null) {
        return const Err(null);
      }
      startPosition = s;
      start = s;
    } else {
      start = currentStartPosition;
    }

    final q = ReportIteratorQuery(
      startPosition: start,
      page: page,
      mode: mode,
      aid: account,
    );

    final result = await api.accountCommonAdmin((api) => api.postGetReportIteratorPage(
      q
    ));

    switch (result) {
      case Err():
        return const Err(null);
      case Ok():
        final getReportListResult = await handleReportList(api, addedReports, result.v.values, onlyNotProcessed: false);
        if (getReportListResult.isOk()) {
          page += 1;
        }
        return getReportListResult;
    }
  }

  @override
  Future<void> sendToServer(WrappedReportDetailed content, bool accept) async {
    return;
  }
}

class ViewReportUiBuilder extends ReportUiBuilder {
  @override
  bool get allowAccepting => false;
}
