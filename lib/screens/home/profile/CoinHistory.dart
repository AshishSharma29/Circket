import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/transaction_history_model.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
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
        body: Stack(
      children: [
        Container(
          child: Image.asset(
            ImageUtils.appBg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Container(
          child: transactionList == null
              ? Util().getLoader()
              : transactionList.length == 0
                  ? Center(
                      child: TextWidget(
                        text: 'No transaction found',
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  ImageUtils.backArrow,
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                            ),
                            TextWidget(
                              padding: const EdgeInsets.all(24),
                              color: ColorUtils.white,
                              textSize: 18,
                              fontWeight: FontStyles.bold,
                              text: Strings.coinHistory,
                            ),
                            SizedBox(
                              width: 32,
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: transactionList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              text:
                                                  transactionList[index].amount,
                                              color: transactionList[index]
                                                      .amount
                                                      .contains('+')
                                                  ? ColorUtils.colorPrimary
                                                  : ColorUtils.colorAccent,
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
                        ),
                      ],
                    ),
        ),
      ],
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
