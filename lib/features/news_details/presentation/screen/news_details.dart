import 'package:eqra_el_khabar/features/news_details/presentation/screen/news_details_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/features/home_screen/data/models/article.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;
  final String heroTag;

  const NewsDetailScreen({
    super.key,
    required this.article,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: heroTag,
              child:
                  article.urlToImage != null && article.urlToImage!.isNotEmpty
                      ? Image.network(
                        article.urlToImage!,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(color: Colors.grey[300]),
                      )
                      : Container(color: Colors.grey[300]),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                  stops: const [0.4, 0.8],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 🏷️ Source and Time
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            (article.source?.name ?? 'NA').substring(0, 1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          article.source?.name ?? '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '· ${timeago.format(article.publishedAt ?? DateTime.now(), locale: locale)}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if ((article.description ?? '').isNotEmpty)
                      Text(
                        article.description ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => NewsDetailsWebViewScreen(
                                  loadUrl: article.url ?? '',
                                ),
                          ),
                        );
                      },
                      child: Text('Read_More'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
