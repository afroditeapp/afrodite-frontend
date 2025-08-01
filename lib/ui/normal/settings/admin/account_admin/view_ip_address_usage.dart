

import 'package:app/localizations.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';

class ViewIpAddressUsageScreen extends StatefulWidget {
  final AccountId accountId;
  const ViewIpAddressUsageScreen({
    required this.accountId,
    super.key,
  });

  @override
  State<ViewIpAddressUsageScreen> createState() => _ViewIpAddressUsageScreenState();
}

class _ViewIpAddressUsageScreenState extends State<ViewIpAddressUsageScreen> {
  final api = LoginRepository.getInstance().repositories.api;

  GetIpAddressStatisticsResult? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await api
      .commonAdmin(
        (api) => api.postGetIpAddressUsageData(GetIpAddressStatisticsSettings(account: widget.accountId))
      ).ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        data = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IP address usage"),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final currentData = data;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError || currentData == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showData(context, currentData);
    }
  }

  Widget showData(BuildContext context, GetIpAddressStatisticsResult ipData) {
    final List<Widget> widgets = [];

    widgets.add(const Padding(padding: EdgeInsets.all(8.0)));

    for (final ip in ipData.values) {
      widgets.add(hPad(IpInfoWidget(ip)));
      widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}

class IpInfoWidget extends StatelessWidget {
  final IpAddressInfo ip;

  const IpInfoWidget(this.ip, {super.key});

  @override
  Widget build(BuildContext context) {
    final latest = "Latest usage: ${fullTimeString(ip.l.toUtcDateTime())}";
    final first = "First usage: ${fullTimeString(ip.f.toUtcDateTime())}";

    final String? listInfo;
    if (ip.lists.isNotEmpty) {
      listInfo = "On lists: ${ip.lists.join(", ")}";
    } else {
      listInfo = null;
    }

    final String? countryInfo;
    if (ip.country != null) {
      countryInfo = "Country: ${ip.country}";
    } else {
      countryInfo = null;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ip.a, style: Theme.of(context).textTheme.titleMedium),
        Text(latest),
        Text(first),
        Text("Count: ${ip.c}"),
        if (listInfo != null) Text(listInfo),
        if (countryInfo != null) Text(countryInfo),
      ],
    );
  }
}
