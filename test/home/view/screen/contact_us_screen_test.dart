// ignore_for_file: lines_longer_than_80_chars
// import 'dart:async';

// import 'package:news_app/core/data/api_manager.dart';

// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import 'package:news_app/core/app.dart';
// import 'package:news_app/core/services/loader.dart';
// import 'package:news_app/core/view/widgets/buttons/app_button.dart';
// import 'package:news_app/di/injection_container.dart';
// import 'package:news_app/l10n/l10n.dart';
// import 'package:news_app/home/data/model/parameter/mock/name_mock.dart'; 
// import 'package:news_app/home/data/model/parameter/mock/name_mock.dart'; 
// import 'package:news_app/home/data/model/parameter/mock/email_mock.dart'; 
// import 'package:news_app/home/data/model/parameter/mock/message_title_mock.dart'; 
// import 'package:news_app/home/data/model/parameter/mock/message_type_mock.dart'; 
// import 'package:news_app/home/data/model/parameter/mock/message_description_mock.dart'; 
// import 'package:news_app/home/data/model/parameter/mock/string_mock.dart'; 
// import 'package:news_app/home/data/model/contact_us/mock/contact_us_response_model_mock.dart';
// import 'package:news_app/home/view/screen/contact_us_screen.dart';

// import '../../../core/view/services/alert_test.dart' as alert;
// import '../../../core/view/services/generic_error_handler_test.dart' as failure_handler;
// import '../../../core/view/services/loader_test.dart' as loader;
// import '../../../helper/init_main.dart';
// import '../../faker.dart';

// Future<void> main() async {
//   late MockHomeRepository repository;

//   setUpAll(() {
//     setupFaker();
//     repository = MockHomeRepository();
//   });

//   group('ContactUs page Text fields validations', () {
//     setUpAll(() async {
//       await initnMock();
//     });

//     tearDownAll(() async {
//       await di.reset();
//     });

//     testWidgets(
//       '''
//       Given user entered valid form 
//       then submit button should be activated if valid''',
//       (WidgetTester tester) async {
//         await tester.runAsync(() async {
//           // arrange
//           late BuildContext buildContext;
//           await tester.pumpWidget(
//             MainApp(
//               home: Builder(
//                 builder: (context) {
//                   buildContext = context;
//                   return const ContactUsScreen();
//                 },
//               ),
//             ),
//           );
//           await tester.pumpAndSettle();
//           //act
//           await enterValidForm(tester);
//           //assert
//           await assertValidForm(tester, buildContext);
//         });
//       },
//     );

//     testWidgets(
//       '''
//       Given user entered invalid form then should shows an error
//       and submit button should be inactive''',
//       (WidgetTester tester) async {
//         await tester.runAsync(() async {
//           // arrange
//           late BuildContext buildContext;
//           await tester.pumpWidget(
//             MainApp(
//               home: Builder(
//                 builder: (context) {
//                   buildContext = context;
//                   return const ContactUsScreen();
//                 },
//               ),
//             ),
//           );
//           await tester.pumpAndSettle();
//           //act
//           await enterInValidForm(tester);
//           //assert
//           await assertInValidForm(tester, buildContext);
//         });
//       },
//     );

//     testWidgets('''
//         Given user entered invalid form then valid one
//         then should shows an error while invaid and submit button should be activated if valid''',
//         (WidgetTester tester) async {
//       await tester.runAsync(() async {
//         // arrange
//         late BuildContext buildContext;
//         await tester.pumpWidget(
//           MainApp(
//             home: Builder(
//               builder: (context) {
//                 buildContext = context;
//                 return const ContactUsScreen();
//               },
//             ),
//           ),
//         );
//         await tester.pumpAndSettle();
//         //act
//         await enterInValidForm(tester);
//         //assert
//         await assertInValidForm(tester, buildContext);
//         //act
//         await enterValidForm(tester);
//         //assert
//         await assertValidForm(tester, buildContext);
//       });
//     });
//   });

//   group('ContactUs Action', () {
//     setUpAll(() async {
//       await initnMock(homeRepository: repository);
//     });

//     tearDownAll(() async {
//       await di.reset();
//     });

//     testWidgets(
//       '''
//       Given user entered valid and correct form
//       When repository returns Right(ContactUsResponseModel)
//       Then should make the success action''',
//       (WidgetTester tester) async {
//         await tester.runAsync(() async {
//           // arrange
//           Loader.newInstance();
//           late BuildContext buildContext;
//           await tester.pumpWidget(
//             MainApp(
//               home: Builder(
//                 builder: (context) {
//                   buildContext = context;
//                   return const ContactUsScreen();
//                 },
//               ),
//             ),
//           );
//           await tester.pumpAndSettle();
//           // act
//           await enterValidForm(tester);
//           // assert
//           await assertValidForm(tester, buildContext);
//           // arrange
//           when(() => repository.contactUs(any())).thenAnswer(
//             (_) async => Future.delayed(loadingDuration).then(
//               (value) => Right(ContactUsResponseModelMock.mock),
//             ),
//           );
//           // act
//           await presscontactUs(tester);
//           // assert
//           await loader.assertLoadingAppeardAndDisAppeared(tester);
//           await assertSuccess(tester);
//         });
//       },
//     );

//     testWidgets(
//       '''
//       Given user entered valid but incorrect form
//       When repository returns Error failure
//       Then error message should be presented''',
//       (WidgetTester tester) async {
//         await tester.runAsync(() async {
//           // arrange
//           Loader.newInstance();
//           late BuildContext buildContext;
//           await tester.pumpWidget(
//             MainApp(
//               home: Builder(
//                 builder: (context) {
//                   buildContext = context;
//                   return const ContactUsScreen();
//                 },
//               ),
//             ),
//           );
//           await tester.pumpAndSettle();
//           // act
//           await enterValidForm(tester);
//           // assert
//           await assertValidForm(tester, buildContext);
//           // arrange
//           const errorMessage = 'Failed';
//           when(() => repository.contactUs(any())).thenAnswer(
//             (_) async => Future.delayed(loadingDuration).then(
//               (value) => Left(
//                 Failures.errorFailure(
//                   errorStatus: ErrorStatus.authenticationError,
//                   error: MessageResponseModel(message: errorMessage),
//                 ),
//               ),
//             ),
//           );
//           // act
//           await presscontactUs(tester);
//           // assert
//           await loader.assertLoadingAppeardAndDisAppeared(tester);
//           await tester.pumpAndSettle();
//           await alert.assertAlertShownWithDuration(tester,
//               message: errorMessage);
//         });
//       },
//     );

//     testWidgets(
//       '''
//       Given user entered valid form 
//       When repository returns ConnectionFailure
//       Then Retry Dialog Should be Presented''',
//       (WidgetTester tester) async {
//         await tester.runAsync(() async {
//           // arrange
//           reset(repository);
//           Loader.newInstance();
//           late BuildContext buildContext;
//           await tester.pumpWidget(
//             MainApp(
//               home: Builder(
//                 builder: (context) {
//                   buildContext = context;
//                   return const ContactUsScreen();
//                 },
//               ),
//             ),
//           );
//           await tester.pumpAndSettle();
//           // act
//           await enterValidForm(tester);
//           // assert
//           await assertValidForm(tester, buildContext);
//           // arrange
//           when(() => repository.contactUs(any())).thenAnswer(
//             (_) async => Future.delayed(loadingDuration).then(
//               (value) => Left(Failures.connectionFailure()),
//             ),
//           );
//           // act
//           await presscontactUs(tester);
//           // assert
//           await loader.assertLoadingAppeardAndDisAppeared(tester);

//           await failure_handler.assertConnectionFailureDialogVisible();
//           // arrange
//           when(() => repository.contactUs(any())).thenAnswer(
//             (_) async => Future.delayed(loadingDuration).then(
//               (value) => Right(ContactUsResponseModelMock.mock),
//             ),
//           );
//           // act
//           await failure_handler.pressRetry(tester);
//           await failure_handler.assertConnectionFailureDialogInVisible();
//           verify(() => repository.contactUs(any())).called(2);
//         });
//       },
//     );
//   });
// }


// const _firstNameKey = Key('contact_us_text_field_first_name'); 
// const _lastNameKey = Key('contact_us_text_field_last_name'); 
// const _emailKey = Key('contact_us_text_field_email'); 
// const _messageTitleKey = Key('contact_us_text_field_message_title'); 
// const _messageTypeKey = Key('contact_us_text_field_message_type'); 
// const _messageDescKey = Key('contact_us_text_field_message_desc'); 
// const _attachmentKey = Key('contact_us_text_field_attachment'); 
// const _contactUsKey = Key('contact_us_button');

// Future<void> enterValidForm(WidgetTester tester) async {
// // act 
//   await tester.enterText(find.byKey(_firstNameKey), NameMock.name); 
//   await tester.enterText(find.byKey(_lastNameKey), NameMock.name); 
//   await tester.enterText(find.byKey(_emailKey), EmailMock.email); 
//   await tester.enterText(find.byKey(_messageTitleKey), MessageTitleMock.messageTitle); 
//   await tester.enterText(find.byKey(_messageTypeKey), MessageTypeMock.messageType); 
//   await tester.enterText(find.byKey(_messageDescKey), MessageDescriptionMock.messageDescription); 
//   await tester.enterText(find.byKey(_attachmentKey), StringMock.string); 
//   await tester.pumpAndSettle();
// }

// Future<void> assertValidForm(
//     WidgetTester tester, BuildContext context) async {
//   // assert 
//   expect(find.text(context.l10n.invalid_name), findsNothing); 
//   expect(find.text(context.l10n.invalid_name), findsNothing); 
//   expect(find.text(context.l10n.invalid_email), findsNothing); 
//   expect(find.text(context.l10n.invalid_message_title), findsNothing); 
//   expect(find.text(context.l10n.invalid_message_type), findsNothing); 
//   expect(find.text(context.l10n.invalid_message_description), findsNothing); 
//   expect(find.text(context.l10n.invalid_string), findsNothing); 
//   final contactUsButton = tester.widget<AppButton>(find.byKey(_contactUsKey));
//   expect(contactUsButton.onpressed, isNotNull);
// }

// Future<void> enterInValidForm(WidgetTester tester) async {
// // act 
//   await tester.enterText(find.byKey(_firstNameKey), NameMock.nameInvalid);

//   await tester.enterText(find.byKey(_lastNameKey), NameMock.nameInvalid);

//   await tester.enterText(find.byKey(_emailKey), EmailMock.emailInvalid);

//   await tester.enterText(find.byKey(_messageTitleKey), MessageTitleMock.messageTitleInvalid);

//   await tester.enterText(find.byKey(_messageTypeKey), MessageTypeMock.messageTypeInvalid);

//   await tester.enterText(find.byKey(_messageDescKey), MessageDescriptionMock.messageDescriptionInvalid);

//   await tester.enterText(find.byKey(_attachmentKey), StringMock.stringInvalid);

//   await tester.pumpAndSettle();
// }

// Future<void> assertInValidForm(
//     WidgetTester tester, BuildContext context) async {
//   // assert 
//   expect(find.text(context.l10n.invalid_name), findsOneWidget); 
//   expect(find.text(context.l10n.invalid_name), findsOneWidget); 
//   expect(find.text(context.l10n.invalid_email), findsOneWidget); 
//   expect(find.text(context.l10n.invalid_message_title), findsOneWidget); 
//   expect(find.text(context.l10n.invalid_message_type), findsOneWidget); 
//   expect(find.text(context.l10n.invalid_message_description), findsOneWidget); 
//   expect(find.text(context.l10n.invalid_string), findsOneWidget); 
//   final contactUsButton = tester.widget<AppButton>(find.byKey(_contactUsKey));
//   expect(contactUsButton.onpressed, isNull);
// }

// Future<void> press(WidgetTester tester) async {
//   //act
//   expect(find.byKey(_contactUsKey), findsOneWidget);
//   await tester.tap(find.byKey(_contactUsKey));
//   await tester.pumpAndSettle();
// }

// //TODO add success condition
// Future<void> assertSuccess(WidgetTester tester) async {}

// //TODO add this to integration_test/app_test.dart
// //!add this line to immports
// import '../test/home/view/screen/contact_us_screen_test.dart' as contact_us_screen;

// //!add this line to the end of main
// await contact_us_screen.main();
