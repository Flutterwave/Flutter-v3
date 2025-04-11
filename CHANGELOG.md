## [1.1.1] - April 10, 2025

Changes include

- Fixed broken package deployment action.

## [1.1.0] | April 10, 2025

Changes include:

- Modified `Flutterwave.charge()` method to accept a BuildContext parameter.
- Added context.mounted checks to prevent setState calls after widget disposal.
- Enhanced success status check logic to handle different status values ("success" and "completed").
- Improved error handling and state management.
- Removed deprecated components: `flutterwave_style.dart` and `standard_webview.dart`.
- Removed `flutterwave_style_test.dart`.
- Updated the SDK requirements to `>=2.17.0`.
- Upgraded dependencies to the latest versions.
- Removed unused dependencies: webview_flutter, modal_bottom_sheet and uuid.
- Update deployment workflow.

## [1.0.7] - February, 2023

Changes include

- Fixed iOS bug where webview couldn't close when close buttons are clicked
- Removed required `name` and `phone number` fields in `Customer` object

## [1.0.6] - October, 2022

Changes include:

- Fixed bug where transaction gets stuck after redirecting on webview
- Fixed iOS build bug by removing inAppBrowser library

## [1.0.5] - October, 2022

Changes include:

- Fixed null when transaction is cancelled.
- Removed modal pop up before launching web view.
- Removed intermediate make payment screen before webview.
- Deprecated FlutterwaveStyle.
- Updated README file.

## [1.0.4] - July 4, 2022

Changes include:

- Renamed property `isDebug` to `isTestMode`
- Made property `redirectUrl` required
- Updated README file

## [1.0.3] - October 4, 2021.

Changes include:

- Fixed issue with webview

## [1.0.2] - September 23, 2021.

Changes include:

- Fixed bug where cancel payment buttons are not clickable on iOS devices.

## [1.0.1] - September 14, 2021.

Changes include:

- Fixed bug where response is not returned to initiating screen when user cancels transaction.

## [1.0.0] - September 9, 2021.

Changes include:

- Initial release
