import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/transaction_history_model.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinHistory extends StatefulWidget {
  Map<String, String> argument;

  CoinHistory(this.argument);

  @override
  _CoinHistoryState createState() => _CoinHistoryState();
}

class _CoinHistoryState extends State<CoinHistory> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    cricketProvider = Provider.of<CricketProvider>(context, listen: false);

    if (isLoading) getCoinHistory(context);

    return Scaffold(
        appBar: AppBar(
          title: TextWidget(
            text: Strings.coinHistory,
            color: Colors.white,
          ),
        ),
        body: Container(
          child: transactionList == null
              ? Util().getLoader()
              : transactionList.length == 0
                  ? Center(
                      child: TextWidget(
                        text: 'No transaction found',
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: transactionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        textAlign: TextAlign.start,
                                        text: transactionList[index]
                                            .transactionType,
                                        color: ColorUtils.colorPrimary,
                                        textSize: 16,
                                        fontWeight: FontStyles.regular,
                                      ),
                                      TextWidget(
                                        textAlign: TextAlign.start,
                                        text: transactionList[index].amount,
                                        color: ColorUtils.colorAccent,
                                        textSize: 14,
                                        fontWeight: FontStyles.semiBold,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                    textAlign: TextAlign.start,
                                    text: transactionList[index]
                                        .transactionDate
                                        .split('T')[0]
                                        .toString(),
                                    color: ColorUtils.black,
                                    textSize: 12,
                                    fontWeight: FontStyles.regular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }

  List<TransactionHistoryModel> transactionList;
  CricketProvider cricketProvider;

  Future<void> getCoinHistory(BuildContext context) async {
    transactionList = await cricketProvider.getTransactionHistory(context);
    print(transactionList);
    isLoading = false;
    setState(() {});
  }
}
