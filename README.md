<p align="center">    
   <img title="Flutterwave" height="200" src="https://flutterwave.com/images/logo/full.svg" width="50%"/>  
</p>

# Flutterwave Flutter SDK (Standard)

The Flutter library helps you create seamless payment experiences in your dart mobile app. By connecting to our modal, you can start collecting payment in no time.

Available features include:

- Collections: Card, Account, Mobile money, Bank Transfers, USSD.
- Recurring payments: Tokenization and Subscriptions.
- Split payments.

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
3. Dart SDK >= 2.17.0
4. For Android development, ensure the NDK version >= `27.0.12077973` on your project's `android/app/build.gradle.kts` file with android `{ ndkVersion = "27.0.12077973" }`.

## Installation

1. Add the dependency to your project. In your `pubspec.yaml` file add: `flutterwave_standard: 1.1.0`
2. Run `flutter pub get`.

## Usage

### Initializing a Flutterwave instance

To create an instance, you should call the Flutterwave constructor. This constructor accepts a mandatory instance of the following:

- `publicKey`
- `Customer`
- `amount`
- `email`
- `fullName`
- `txRef`
- `isTestMode`
- `paymentOptions`
- `redirectUrl`
- `Customization`

It returns an instance of Flutterwave which we then call the async method `.charge()` on.

\_

    handlePaymentInitialization() async {
    	 final Customer customer = Customer(
    	 name: "Flutterwave Developer",
    	 phoneNumber: "1234566677777",
         email: "customer@customer.com"
     );
        final Flutterwave flutterwave = Flutterwave(
            publicKey: "Public Key-here",
    		currency: "currency-here",
            redirectUrl: "add-your-redirect-url-here",
            txRef: "add-your-unique-reference-here",
            amount: "3000",
            customer: customer,
            paymentOptions: "ussd, card, bank transfer",
            customization: Customization(title: "My Payment"),
            isTestMode: true );

             final ChargeResponse response = await flutterwave.charge(context);

        // Handle the response
        if (response.success == true) {
        // Payment was successful
        } else {
        // Payment failed or was cancelled
        }
     }

### Handling the response

Calling the `.charge()` method returns a `Future` of `ChargeResponse` which we await for the actual response as seen above.

    final ChargeResponse response = await flutterwave.charge(context);

Call the verify transaction [endpoint](https://developer.flutterwave.com/docs/transaction-verification) with the `transactionID` returned in `response.transactionId` or the `txRef` you provided to verify transaction before offering value to customer

#### Note
- `ChargeResponse` can be null, depending on if the user cancels the transaction by pressing back.
- You need to confirm the transaction status is successful. Ensure that the txRef, amount, and status are correct and successful. Be sure to [verify the transaction details](https://developer.flutterwave.com/docs/transaction-verification) before providing value.
- Some payment methods are not instant, such a `Pay with Bank Transfers, Pay with Bank`, and so you would need to rely on [webhooks](https://developer.flutterwave.com/docs/webhooks) or call the transaction verification service using the [`transactionId`](https://developer.flutterwave.com/reference/verify-transaction), or transaction reference you created(`txRef`)
- For such long payments like the above, closing the payment page returns a `cancelled` status, so your final source of truth has to be calling the transaction verification service.


## Support
For additional assistance using this library, contact the developer experience (DX) team via [email](mailto:developers@flutterwavego.com) or on [slack](https://bit.ly/34Vkzcg).

You can also follow us [@FlutterwaveEng](https://twitter.com/FlutterwaveEng) and let us know what you think 😊.


## Contribution guidelines
Read more about our community contribution guidelines [here](CONTRIBUTING.md).


## License
By contributing to the Flutter library, you agree that your contributions will be licensed under its [MIT license](/LICENSE).

Copyright (c) Flutterwave Inc.

## Built Using
- [flutter](https://flutter.dev/)
- [http](https://pub.dev/packages/http)
- [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview)
- [fluttertoast](https://pub.dev/packages/fluttertoast)

<a id="references"></a>

## Other Resources
- [Flutterwave API Doc](https://developer.flutterwave.com)
- [Flutterwave Inline Payment Doc](https://developer.flutterwave.com/docs/inline)
- [Flutterwave Dashboard](https://dashboard.flutterwave.com/login)
