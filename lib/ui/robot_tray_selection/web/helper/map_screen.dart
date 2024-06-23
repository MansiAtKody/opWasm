// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kody_operator/ui/utils/theme/theme.dart';
// import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';
// import 'package:webviewx_plus/webviewx_plus.dart';
//
// class MapScreenWeb extends ConsumerStatefulWidget {
//   const MapScreenWeb({super.key});
//
//   @override
//   ConsumerState createState() => _MapScreenWebState();
// }
//
// class _MapScreenWebState extends ConsumerState<MapScreenWeb> {
//   WebViewXController? webviewController;
//   bool contentLoaded = false;
//
//   final initialContent = '<h4> This is some hardcoded HTML code embedded inside the webview <h4> <h2> Hello world! <h2>';
//   final initialDiv = '<div></div>';
//   final executeJsErrorMessage = 'Failed to execute this task because the current content is (probably) URL that allows iFrame embedding, on Web.\n\n'
//       'A short reason for this is that, when a normal URL is embedded in the iFrame, you do not actually own that content so you cant call your custom functions\n'
//       '(read the documentation to find out why).';
//
//   @override
//   void initState() {
//     super.initState();
//     contentLoaded = false;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(15.r),
//       child: Stack(
//         children: [
//           _buildWebViewX(context),
//           !contentLoaded
//               ? Positioned(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.r),
//                       color: AppColors.blue88CCCF,
//                     ),
//                     height: context.height * 0.7,
//                     width: context.width * 0.6,
//                     child: const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.black,
//                       ),
//                     ),
//                   ),
//                 )
//               : const Offstage()
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWebViewX(BuildContext context) {
//     return WebViewX(
//       key: const ValueKey('webviewx'),
//       initialContent: initialContent,
//       initialSourceType: SourceType.html,
//       height: context.height * 0.7,
//       width: context.width * 0.6,
//       onWebViewCreated: (controller) {
//         webviewController = controller;
//         _setUrl();
//         return webviewController;
//       },
//       onPageStarted: (src) => debugPrint('A new page has started loading: $src\n'),
//       onPageFinished: (src) => debugPrint('The page has finished loading: $src\n'),
//       jsContent: const {
//         EmbeddedJsContent(
//           js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
//         ),
//         EmbeddedJsContent(
//           webJs: "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
//           mobileJs: "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
//         ),
//       },
//       dartCallBacks: {
//         DartCallback(
//           name: 'TestDartCallback',
//           callBack: (msg) => showCommonErrorDialog(context: context, message: msg.toString()),
//         )
//       },
//       webSpecificParams: const WebSpecificParams(
//         printDebugInfo: true,
//       ),
//       mobileSpecificParams: const MobileSpecificParams(
//         androidEnableHybridComposition: true,
//       ),
//       navigationDelegate: (navigation) {
//         debugPrint(navigation.content.sourceType.toString());
//         return NavigationDecision.navigate;
//       },
//     );
//   }
//
//   Widget _buildWebViewX2(BuildContext context) {
//     return WebViewX(
//       key: const ValueKey('webviewx2'),
//       initialContent: initialDiv,
//       initialSourceType: SourceType.html,
//       height: context.height * 0.4,
//       width: context.width * 0.1,
//       onWebViewCreated: (controller) {},
//       onPageStarted: (src) => debugPrint('A new page has started loading: $src\n'),
//       onPageFinished: (src) => debugPrint('The page has finished loading: $src\n'),
//       jsContent: const {
//         EmbeddedJsContent(
//           js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
//         ),
//         EmbeddedJsContent(
//           webJs: "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
//           mobileJs: "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
//         ),
//       },
//       dartCallBacks: {
//         DartCallback(
//           name: 'TestDartCallback',
//           callBack: (msg) => showCommonErrorDialog(context: context, message: msg.toString()),
//         )
//       },
//       webSpecificParams: const WebSpecificParams(
//         printDebugInfo: true,
//       ),
//       mobileSpecificParams: const MobileSpecificParams(
//         androidEnableHybridComposition: true,
//       ),
//       navigationDelegate: (navigation) {
//         debugPrint(navigation.content.sourceType.toString());
//         return NavigationDecision.navigate;
//       },
//     );
//   }
//
//   void _setUrl() async {
//     await webviewController?.loadContent('http://192.168.1.50/pad');
//     Future.delayed(const Duration(seconds: 3), () {
//       contentLoaded = true;
//       setState(() {});
//     });
//   }
// }
