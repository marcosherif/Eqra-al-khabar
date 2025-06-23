import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';

import '../../../../core/util/string_truncate.dart';
import '../../../news_by_category/data/models/article.dart';
import '../../../news_details/presentation/screen/news_details.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final heroTag = uuid.v4();
    final imageUrl = article.urlToImage ?? '';
    final author = article.author ?? 'Unknown';
    final title = article.title ?? '';
    final timeAgo =
        article.publishedAt != null
            ? timeago.format(
              article.publishedAt!,
              locale: Localizations.localeOf(context).languageCode,
            )
            : '';

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (_) => NewsDetailScreen(article: article, heroTag: heroTag),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    height: 350,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 64),
                  ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Card(
                  margin: EdgeInsets.zero,
                  color: Colors.grey[300],
                  child: SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.source?.name ?? '',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Column(
                      children: [
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Text(
                                      (article.source?.name ?? 'NA').substring(
                                        0,
                                        1,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    truncate(author, length: 15),
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical:  6.0),
                                child: Text(
                                  timeAgo,
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //copy url icon
            // Positioned(
            //   top: 12,
            //   right: 12,
            //   child: InkWell(
            //     onTap: onBookmarkTap,
            //     borderRadius: BorderRadius.circular(20),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.redAccent,
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       padding: const EdgeInsets.all(8),
            //       child: Icon(Icons.bookmark_border, color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
