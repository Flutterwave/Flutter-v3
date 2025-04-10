import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Standard Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "NGN";
  bool isLoading = false;
  bool isTestMode = true;

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;

    return Scaffold(
      appBar: AppBar(title: Text('Flutterwave Payment Demo')),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Amount"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Amount is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: currencyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: _openBottomSheet,
                  decoration: InputDecoration(hintText: "Currency"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Currency is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  children: [
                    Text("Use Debug"),
                    Switch(
                      onChanged:
                          (value) => {
                            setState(() {
                              isTestMode = value;
                            }),
                          },
                      value: isTestMode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  onPressed: isLoading ? null : makePayment,
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void makePayment() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final Customer customer = Customer(
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
      );

      final Flutterwave flutterwave = Flutterwave(
        publicKey: "YOUR_PUBLIC_KEY", // Input your public key
        currency: selectedCurrency,
        amount: amountController.text.toString().trim(),
        customer: customer,
        txRef: Uuid().v4(),
        paymentOptions: "card, ussd, bank transfer",
        customization: Customization(
          title: "Payment for Product/Service",
          description: "Payment for items in cart",
        ),
        redirectUrl: "https://www.flutterwave.com",
        isTestMode: isTestMode,
      );

      final ChargeResponse response = await flutterwave.charge(
        context,
      );

      if (mounted) {
        if (response.success == true) {
          // Payment was successful
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Payment Successful'),
                content: Text(
                  'Transaction Reference: ${response.txRef}',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Payment failed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Payment Failed'),
                content: Text('Status: ${response.status}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _getCurrency();
      },
    );
  }

  Widget _getCurrency() {
    final currencies = [
      "NGN",
      "RWF",
      "UGX",
      "KES",
      "ZAR",
      "USD",
      "GHS",
      "TZS",
    ];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children:
            currencies
                .map(
                  (currency) => ListTile(
                    onTap: () => {_handleCurrencyTap(currency)},
                    title: Column(
                      children: [
                        Text(
                          currency,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 4),
                        Divider(height: 1),
                      ],
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    amountController.dispose();
    currencyController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
