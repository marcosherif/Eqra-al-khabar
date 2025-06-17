import 'package:eqra_el_khabar/core/util/string_truncate.dart';
import 'package:eqra_el_khabar/features/home_screen/data/models/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../news_details/presentation/screen/news_details.dart';

class NewsTile extends StatelessWidget {
  final Article article;

  const NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => NewsDetailScreen(
                  article: article,
                  heroTag: article.urlToImage ?? article.title ?? 'hero-tag',
                ),
          ),
        );
      },
      child: Card(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: article.urlToImage ?? article.title ?? 'news-hero',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    article.urlToImage ?? '',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          width: 100,
                          height: 100,
                          child: Icon(Icons.broken_image),
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.source?.name ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: (article.author ?? '').isNotEmpty,
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.pencil),
                              SizedBox(width: 2),
                              Text(
                                truncate(article.author ?? '', length: 15),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (article.publishedAt != null)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              timeago.format(
                                article.publishedAt!,
                                locale:
                                    Localizations.localeOf(
                                      context,
                                    ).languageCode,
                              ),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
