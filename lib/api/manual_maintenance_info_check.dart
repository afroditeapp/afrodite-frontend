import 'package:app/config.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';

sealed class ManualMaintenanceInfoCheckResult {
  const ManualMaintenanceInfoCheckResult();
}

class ManualMaintenanceInfoCheckFailed extends ManualMaintenanceInfoCheckResult {
  const ManualMaintenanceInfoCheckFailed();
}

class MaintenanceOngoing extends ManualMaintenanceInfoCheckResult {
  final StringResource maintenanceInfo;
  const MaintenanceOngoing(this.maintenanceInfo);
}

class NoMaintenance extends ManualMaintenanceInfoCheckResult {
  const NoMaintenance();
}

Future<ManualMaintenanceInfoCheckResult> checkManualMaintenanceInfo({
  required String currentServerAddress,
}) async {
  return await _checkManualMaintenanceInfoInternal(
    currentServerAddress: currentServerAddress,
  ).timeout(const Duration(seconds: 5), onTimeout: () => const ManualMaintenanceInfoCheckFailed());
}

Future<ManualMaintenanceInfoCheckResult> _checkManualMaintenanceInfoInternal({
  required String currentServerAddress,
}) async {
  final alternativeServerUrl = getAlternativeDemoAccountServerUrl();
  if (alternativeServerUrl == null || currentServerAddress == alternativeServerUrl) {
    return const NoMaintenance();
  }

  final alternativeServerApiManager = await ApiManagerNoConnection.create(alternativeServerUrl);

  final info = await alternativeServerApiManager
      .common((api) => api.getManualServerMaintenanceInfoForAnotherServer())
      .ok();
  if (info == null) {
    return const ManualMaintenanceInfoCheckFailed();
  }

  final text = info.text;
  if (text == null) {
    return const NoMaintenance();
  }

  return MaintenanceOngoing(text);
}
