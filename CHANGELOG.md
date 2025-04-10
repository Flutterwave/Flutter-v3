## [1.1.0] | 2025-04-10

### Version Changes

- Modified `Flutterwave.charge()` method to accept a BuildContext parameter.
- Added context.mounted checks to prevent setState calls after widget disposal.
- Enhanced success status check logic to handle different status values ("success" and "completed").
- Improved error handling and state management.
- Removed deprecated components: `flutterwave_style.dart` and `standard_webview.dart`.
- Updated SDK requirements to `>=2.17.0`.
- Upgraded dependencies to the latest versions.
- Removed unused dependencies: webview_flutter, modal_bottom_sheet and uuid.

## [1.0.7] - February, 2023

- Fixed iOS bug where webview couldn't close when close buttons are clicked
- Removed required `name` and `phone number` fields in `Customer` object

## [1.0.6] - October, 2022

- Fixed bug where transaction gets stuck after redirecting on webview
- Fixed iOS build bug by removing inAppBrowser library

## [1.0.5] - October, 2022

- Fixed null when transaction is cancelled.
- Removed modal pop up before launching web view.
- Removed intermediate make payment screen before webview.
- Deprecated FlutterwaveStyle.
- Updated README file.

## [1.0.4] - July 4, 2022

- Renamed property `isDebug` to `isTestMode`
- Made property `redirectUrl` required
- Updated README file

## [1.0.3] - October 4, 2021.

- Fixed issue with webview

## [1.0.2] - September 23, 2021.

- Fixed bug where cancel payment buttons are not clickable on iOS devices.

## [1.0.1] - September 14, 2021.

- Fixed bug where response is not returned to initiating screen when user cancels transaction.

## [1.0.0] - September 9, 2021.

- Initial release
