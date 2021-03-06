import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../application/exchange_rate/exchange_rate_bloc.dart';
import '../domain/exchange_rate/exchange_rate.dart';
import '../generated/l10n.dart';
import '../utils/constants.dart';
import 'one_day_exchange_rate_widget.dart';
import 'widgets/loading_progress_indicator.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ExchangeRateBloc>();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                S.of(context).appTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  letterSpacing: -1,
                ),
              ),
              Text(
                DateFormat(dateFormat).format(DateTime.now()).toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              )
            ],
          ),
        ),
      ),
      body: bloc.state.when(
        initial: () => LoadingProgressIndicator(),
        loaded: (List<ExchangeRate> rates) => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          color: Theme.of(context).accentColor,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 10 : 0,
                  bottom: index == rates.length - 1 ? 30 : 0,
                ),
                child: OneDayExchangeRateWidget(
                  exchangeRate: rates[index],
                ),
              );
            },
            itemCount: rates.length,
            separatorBuilder: (BuildContext context, int index) {
              return Column(
                children: const [
                  Divider(color: Colors.grey),
                ],
              );
            },
          ),
        ),
        loading: () => LoadingProgressIndicator(),
      ),
    );
  }
}
