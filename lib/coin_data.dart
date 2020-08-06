import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

//const apikey = '6F7FB452-0856-45BE-9A9A-CB8FD0D05FFF';
const apikey = '4B1DF4AF-C9F7-42FB-A761-D6B52E679164';

const kStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
);

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apikey';
      http.Response response = await http.get(requestURL);

      print(response.body);
        var decodedData = jsonDecode(response.body);

        if(decodedData['error'] == null){
        double price = decodedData['rate'];
        print(price);
        cryptoPrices[crypto] = price.toStringAsFixed(2);
      } else {
        print(decodedData['error']);
        AlertDialog(
            title: Text('Error'),
            content: Text(decodedData['error']),
        );
        throw 'Problem with the get request';
      }
    }
    print(cryptoPrices);
    return cryptoPrices;
  }
}