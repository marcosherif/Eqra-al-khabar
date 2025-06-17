import 'package:eqra_el_khabar/features/news_details/presentation/widget/web_view_widget.dart';
import 'package:flutter/material.dart';

class NewsDetailsWebViewScreen extends StatelessWidget {
  const NewsDetailsWebViewScreen({super.key, required this.loadUrl});

  final String loadUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).primaryColor),
        elevation: 0,
        centerTitle: true,
      ),
      body: NewsDetailsWebView(loadUrl: loadUrl),
    );
  }
}
