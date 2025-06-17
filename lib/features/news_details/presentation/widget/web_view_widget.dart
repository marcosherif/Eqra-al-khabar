import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsDetailsWebView extends StatefulWidget {
  String loadUrl;
  final Uint8List? postData;

  NewsDetailsWebView({super.key, required this.loadUrl, this.postData});

  @override
  State<NewsDetailsWebView> createState() => _PaymentGatewayWebviewState();
}

class _PaymentGatewayWebviewState extends State<NewsDetailsWebView> {
  double progress = 0;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          InAppWebView(
            gestureRecognizers: {
              Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
              ),
            },
            initialUrlRequest: URLRequest(url: WebUri(widget.loadUrl)),
            onReceivedServerTrustAuthRequest: ((controller, challenge) async {
              debugPrint("onReceivedServerTrustAuthRequest url 000");
              return ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED,
              );
            }),
            shouldOverrideUrlLoading: ((controller, challenge) async {
              return NavigationActionPolicy.ALLOW;
            }),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              transparentBackground: true,
              useShouldOverrideUrlLoading: true,
              clearCache: true,
              domStorageEnabled: true,
              databaseEnabled: true,
            ),
            onConsoleMessage: (controller, consoleMessage) {
              log("Message coming from the JS side: ${consoleMessage.message}");
              log("Message level: ${consoleMessage.messageLevel}");
            },
            onWebViewCreated: (InAppWebViewController controller) {
              if (widget.postData != null) {
                controller.postUrl(
                  url: WebUri(widget.loadUrl),
                  postData: widget.postData!,
                );
              }
            },
            onLoadStart: (InAppWebViewController controller, Uri? url) {
              setState(() {
                widget.loadUrl = url.toString();
              });
            },
            onLoadStop: (InAppWebViewController controller, Uri? url) async {
              setState(() {
                widget.loadUrl = url.toString();
              });
            },
            onProgressChanged: (
              InAppWebViewController controller,
              int progress,
            ) {
              debugPrint('onProgressChanged url $progress');
              setState(() {
                this.progress = progress / 100;
              });
            },
          ),
          Align(alignment: Alignment.center, child: _buildProgressBar()),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    if (progress != 1.0) {
      return const CircularProgressIndicator();
    }
    return Container();
  }
}
