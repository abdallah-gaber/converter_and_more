import 'package:converter_and_more/models/converter_model.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ForthPointScreen extends StatefulWidget {
  @override
  _ForthPointScreenState createState() => _ForthPointScreenState();
}

class _ForthPointScreenState extends State<ForthPointScreen> {
  ConverterModel _converterModel = ConverterModel();
  TextEditingController _fromAmountController;
  TextEditingController _toAmountController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _converterModel.retrieveAllCurrencySymbols();
      _converterModel.retrieveAllRates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _converterModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Forth Point"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Consumer<ConverterModel>(
              builder: (context, convModel, _) {
                return Column(
                  children: [
                    if (convModel.gettingAllSymbols)
                      Center(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      )),
                    if (!convModel.gettingAllSymbols)
                      Center(
                          child: Text(
                        "Currency Exchange Rates",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    if (!convModel.gettingAllSymbols)
                      SizedBox(
                        height: 20,
                      ),
                    if (!convModel.gettingAllSymbols)
                      Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text("Select Base Currency:")),
                    if (!convModel.gettingAllSymbols)
                      renderBaseCurrencyInput(convModel.allCurrencySymbols),
                    SizedBox(
                      height: 50,
                    ),
                    if (!convModel.gettingAllSymbols &&
                        convModel.gettingAllRates)
                      Center(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      )),
                    if (!convModel.gettingAllSymbols &&
                        !convModel.gettingAllRates)
                      Center(
                        child: Text(
                          "All Rates",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: convModel.allCurrencySymbols.keys.length,
                          itemBuilder: (context, index) {
                            if (convModel.allCurrencySymbols.keys
                                    .toList()[index] ==
                                convModel.selectedBaseCurrency)
                              return Container();
                            return ListTile(
                              onTap: () async {
                                _fromAmountController =
                                    TextEditingController(text: "1");
                                _toAmountController = TextEditingController(
                                    text:
                                        "${convModel.allRatesToShow[convModel.allCurrencySymbols.keys.toList()[index]]}");
                                await showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Center(
                                        child: Text(
                                            "${convModel.selectedBaseCurrency} to ${convModel.allCurrencySymbols.keys.toList()[index]}"),
                                      ),
                                      content: Container(
                                        height: 150,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            3 /
                                                            7,
                                                    child: TextField(
                                                        controller:
                                                            _fromAmountController,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .bottom,
                                                        textAlign:
                                                            TextAlign.left,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            if (value.isEmpty)
                                                              _toAmountController
                                                                  .text = "";
                                                            else
                                                              _toAmountController
                                                                      .text =
                                                                  "${convModel.rateFromTo(convModel.selectedBaseCurrency, convModel.allCurrencySymbols.keys.toList()[index], double.parse(value))}";
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                                width: 1.0),
                                                          ),
                                                          hintText:
                                                              'Enter Amount',
                                                        ))),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    "${convModel.selectedBaseCurrency}"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            3 /
                                                            7,
                                                    child: TextField(
                                                        enabled: false,
                                                        controller:
                                                            _toAmountController,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        textAlign:
                                                            TextAlign.left,
                                                        decoration:
                                                            InputDecoration(
                                                          disabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1.0),
                                                          ),
                                                              hintText:
                                                              'Enter Base Amount',
                                                        ))),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    "${convModel.allCurrencySymbols.keys.toList()[index]}"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                              leading: Column(
                                children: [
                                  Text(
                                    convModel.allCurrencySymbols.keys
                                        .toList()[index],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Flag(
                                    convModel.allCurrencySymbols.keys
                                        .toList()[index]
                                        .toString()
                                        .substring(0, 2)
                                        .toLowerCase(),
                                    height: 15,
                                    width: 30,
                                  ),
                                ],
                              ),
                              title: Column(
                                children: [
                                  Text(convModel.allCurrencySymbols.values
                                      .toList()[index]),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${convModel.allRatesToShow[convModel.allCurrencySymbols.keys.toList()[index]] ?? ""}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget renderBaseCurrencyInput(Map allCurrencies) {
    if (allCurrencies.isNotEmpty) {
      List<DropdownMenuItem> items = [];
      allCurrencies.keys.forEach((item) {
        items.add(
          DropdownMenuItem(
            child: Row(
              children: [
                Flag(
                  item.toString().substring(0, 2).toLowerCase(),
                  height: 15,
                  width: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(item),
                SizedBox(
                  width: 15,
                ),
                Expanded(child: Text(allCurrencies[item])),
              ],
            ),
            value: item,
          ),
        );
      });
      return SearchableDropdown.single(
        items: items,
        value: _converterModel.selectedBaseCurrency,
        displayClearIcon: false,
        onChanged: (val) {
          _converterModel.baseCurrencyChanged(val);
        },
        isExpanded: true,
        hint: Text("Base Currency"),
      );
    } else {
      return Container(
        height: 80,
      );
    }
  }
}
