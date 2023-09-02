//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:openapi/api.dart';
import 'package:test/test.dart';


/// tests for CommonAdminApi
void main() {
  // final instance = CommonAdminApi();

  group('tests for CommonAdminApi', () {
    // Get latest software build information available for update from manager
    //
    // Get latest software build information available for update from manager instance.
    //
    //Future<BuildInfo> getLatestBuildInfo(SoftwareOptions softwareOptions) async
    test('test getLatestBuildInfo', () async {
      // TODO
    });

    // Get software version information from manager instance.
    //
    // Get software version information from manager instance.
    //
    //Future<SoftwareInfo> getSoftwareInfo() async
    test('test getSoftwareInfo', () async {
      // TODO
    });

    // Get system information from manager instance.
    //
    // Get system information from manager instance.
    //
    //Future<SystemInfoList> getSystemInfo() async
    test('test getSystemInfo', () async {
      // TODO
    });

    // Save dynamic backend config.
    //
    // Save dynamic backend config.  # Capabilities Requires admin_server_maintentance_save_backend_settings.
    //
    //Future postBackendConfig(BackendConfig backendConfig) async
    test('test postBackendConfig', () async {
      // TODO
    });

    // Request building new software from manager instance.
    //
    // Request building new software from manager instance.
    //
    //Future postRequestBuildSoftware(SoftwareOptions softwareOptions) async
    test('test postRequestBuildSoftware', () async {
      // TODO
    });

    // Request restarting or reseting backend through app-manager instance.
    //
    // Request restarting or reseting backend through app-manager instance.  # Capabilities Requires admin_server_maintentance_restart_backend. Also requires admin_server_maintentance_reset_data if reset_data is true.
    //
    //Future postRequestRestartOrResetBackend(bool resetData) async
    test('test postRequestRestartOrResetBackend', () async {
      // TODO
    });

    // Request updating new software from manager instance.
    //
    // Request updating new software from manager instance.  Reboot query parameter will force reboot of the server after update. If it is off, the server will be rebooted when the usual reboot check is done.  Reset data query parameter will reset data like defined in current app-manager version. If this is true then specific capability is needed for completing this request.  # Capablities Requires admin_server_maintentance_update_software. Also requires admin_server_maintentance_reset_data if reset_data is true.
    //
    //Future postRequestUpdateSoftware(SoftwareOptions softwareOptions, bool reboot, bool resetData) async
    test('test postRequestUpdateSoftware', () async {
      // TODO
    });

  });
}
