
<p align="center">  
   <img title="Flutterwave" height="200" src="https://flutterwave.com/images/logo/full.svg" width="50%"/>
</p>  

# Flutterwave Flutter SDK (Standard)

The Flutter library helps you create seamless payment experiences in your dart mobile app. By connecting to our modal, you can start collecting payment in no time.


Available features include:

- Collections: Card, Account, Mobile money, Bank Transfers, USSD, Barter.
- Recurring payments: Tokenization and Subscriptions.
- Split payments


## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Support](#support)
5. [Contribution guidelines](#contribution-guidelines)
6. [License](#license)


## Requirements

1. Flutterwave for business [API Keys](https://developer.flutterwave.com/docs/integration-guides/authentication)
2. Supported Flutter version >= 1.17.0


## Installation

1. Add the dependency to your project. In your `pubspec.yaml` file add: `flutterwave_standard: 1.0.2`
2. Run `flutter pub get`


## Usage

### Initializing a Flutterwave instance

To create an instance, you should call the Flutterwave constructor. This constructor accepts a mandatory instance of the following:

- The calling `Context`
-  `publicKey`
-  `Customer`
-  `amount`
-  `currency`
-  `email`
-  `fullName`
-  `txRef`
-  `isDebug`
-  `paymentOptions`
-  `Customization` 

It returns an instance of Flutterwave which we then call the async method `.charge()` on.

    _handlePaymentInitialization() async { 
    final style = FlutterwaveStyle(
     appBarText: "My Standard Blue", 
     buttonColor: Color(0xffd0ebff), 
     appBarIcon: Icon(Icons.message, color: Color(0xffd0ebff)),
     buttonTextStyle: TextStyle( 
	     color: Colors.black, 
	     fontWeight: FontWeight.bold, 
	     fontSize: 18), 
    appBarColor: Color(0xffd0ebff), 
    dialogCancelTextStyle: TextStyle(
	    color: Colors.redAccent, 
	    fontSize: 18
	    ),
    dialogContinueTextStyle: TextStyle(
		    color: Colors.blue, 
		    fontSize: 18
		    ) 
		  ); 

    final Customer customer = Customer(
		    name: "FLW Developer", 
		    phoneNumber: "1234566677777", 
		    email: "customer@customer.com"
		    );  
		    
    final Flutterwave flutterwave = Flutterwave(
	    context: context, 
	    style: style, 
	    publicKey: "Public Key", 
	    currency: "RWF", 
	    redirectUrl: "my_redirect_url" ,
	    txRef: "unique_transaction_reference", 
	    amount: "3000", 
	    customer: customer, 
	    paymentOptions: "ussd, card, barter, payattitude", 
	    customization: Customization(title: "Test Payment"),
	    isTestMode: true
	    ); 
		} 

### Handling the response

Calling the `.charge()` method returns a Future of `ChargeResponse` which we await for the actual response as seen above.



     final ChargeResponse response = await flutterwave.charge(); 
     if (response != null) { 
	     print(response.toJson()); 
		 if(response.success) { 
		 Call the verify transaction endpoint with the transactionID returned in `response.transactionId` to verify transaction before offering value to customer 
		 } else { 
		  // Transaction not successful 
		} 
	 } else {
	  // User cancelled 
	 }

#### Note

 1. `ChargeResponse` can be null if a user cancels the transaction by pressing back.
 2. You need to confirm the transaction is succesful. Ensure that the txRef, amount, and status are correct and successful. Be sure to [verify the transaction details](https://developer.flutterwave.com/docs/verifications/transaction) before providing value.


## Support

For additional assistance using this library, contact the developer experience (DX) team via [email](mailto:developers@flutterwavego.com) or on [slack](https://bit.ly/34Vkzcg). 

You can also follow us [@FlutterwaveEng](https://twitter.com/FlutterwaveEng) and let us know what you think 😊.


## Contribution guidelines

Read more about our community contribution guidelines [here](/CONTRIBUTING).


## License

By contributing to the Flutter library, you agree that your contributions will be licensed under its [MIT license](/LICENSE).

Copyright (c) Flutterwave Inc.


## Built Using

- [flutter](https://flutter.dev/)
- [http](https://pub.dev/packages/http)
- [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview)
- [fluttertoast](https://pub.dev/packages/fluttertoast)
