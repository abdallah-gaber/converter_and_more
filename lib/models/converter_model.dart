import 'package:converter_and_more/network/api_caller.dart';
import 'package:flutter/material.dart';

class ConverterModel with ChangeNotifier{
  Map allCurrencySymbols = {};
  Map allRatesBasedOnEUR = {};
  Map allRatesToShow = {};
  String gettingAllSymbolsError;
  String gettingAllRatesError;
  String selectedBaseCurrency = "EUR";
  bool gettingAllSymbols = false;
  bool gettingAllRates = false;


  retrieveAllCurrencySymbols() async{
    gettingAllSymbols = true;
    notifyListeners();
    try{
      allCurrencySymbols = await ApiCaller().getAllSymbols();
    }catch(ex){
      gettingAllSymbolsError = ex.toString();
    }
    gettingAllSymbols = false;
    notifyListeners();
  }

  retrieveAllRates() async{
    gettingAllRates = true;
    notifyListeners();
    try{
      allRatesBasedOnEUR = await ApiCaller().getAllRatesBasedOnEUR();
      allRatesToShow = Map.from(allRatesBasedOnEUR);
    }catch(ex){
      gettingAllRatesError = ex.toString();
    }
    gettingAllRates = false;
    notifyListeners();
  }

  baseCurrencyChanged(String newBaseCurrency){
    selectedBaseCurrency = newBaseCurrency;
    _updateRatesBasedOnNewBase();
    notifyListeners();
  }

  _updateRatesBasedOnNewBase(){
    for(var key in allRatesToShow.keys.toList()){
      allRatesToShow[key] = rateFromTo(selectedBaseCurrency, key, 1);
    }
  }

  double rateFromTo(String bCurrency, String tCurrency, double value){
    if(bCurrency == "EUR"){
      return value * allRatesBasedOnEUR[tCurrency];
    }
    double fromBaseToEUR = value / allRatesBasedOnEUR[bCurrency];
    double fromEURToTargetCurrency = fromBaseToEUR * allRatesBasedOnEUR[tCurrency];

    return fromEURToTargetCurrency;
  }
}