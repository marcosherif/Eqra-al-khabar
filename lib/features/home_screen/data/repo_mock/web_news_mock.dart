import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/entities/articles_list.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/repo/news_repo.dart';

class MockNewsRepo implements NewsRepo {
  @override
  Future<NetworkResponse<ArticlesList?>> getLatestNews({
    required int pageIndex,
    String? typeOfNews,
    String? language,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return NetworkResponse<ArticlesList>(
      success: true,
      statusCode: '200',
      payload: ArticlesList.fromJson({
        "totalResults": 667,
        "articles": [
          {
            "source": {"id": null, "name": "Android Central"},
            "author":
                "michael.hicks@futurenet.com (Michael L Hicks) , Michael L Hicks",
            "title":
                "Best of AWE 2025: The most promising XR gadgets from Niantic, Sony, Android XR, and more",
            "description":
                "From futuristic XR prototypes to next-gen headsets and smart glasses, these were my favorite demos on the AWE 2025 show floor!",
            "url":
                "https://www.androidcentral.com/gaming/virtual-reality/best-of-awe-2025-coolest-xr-demos-niantic-viture-sony-android-xr",
            "urlToImage":
                "https://cdn.mos.cms.futurecdn.net/KjXjRj8V8ZVyZPvBWEtgsM.jpg",
            "publishedAt": "2025-06-14T23:00:00Z",
            "content":
                "Across a whirlwind three days of Augmented World Expo USA 2025 in Long Beach, California, I tested out demos from some of the biggest names in XR, while also checking out prototypes from start-ups th… [+9918 chars]",
          },
          {
            "source": {"id": null, "name": "MacRumors"},
            "author": "Joe Rossignol",
            "title":
                "Apple Launches 2023 Mac Mini Repair Program Due to Power Issue",
            "description":
                "Apple today launched a repair program for Mac mini models with the M2 chip, after it determined that a \"very small percentage\" of these computers may no longer power on. No other Mac mini models are part of this program.\n\n\n\n\n\nIf your Mac mini has exhibited th…",
            "url":
                "https://www.macrumors.com/2025/06/13/apple-launches-2023-mac-mini-repair-program/",
            "urlToImage":
                "https://images.macrumors.com/t/2fNsxdETt5aS_NobBCL0JKFupA0=/1600x/article-new/2023/01/Mac-mini-M2-2023.jpeg",
            "publishedAt": "2025-06-14T03:31:46Z",
            "content":
                "Apple today launched a repair program for Mac mini models with the M2 chip, after it determined that a \"very small percentage\" of these computers may no longer power on. No other Mac mini models are … [+559 chars]",
          },
          {
            "source": {"id": null, "name": "MacRumors"},
            "author": "Mitchel Broussard",
            "title":
                "AirPods Pro 2 Available for Lowest Price of the Year So Far at \$169, Plus AirPods 4 at \$99",
            "description":
                "Amazon has the AirPods Pro 2 for \$169.00 this weekend, down from \$249.00. Free delivery options provide an estimated delivery date of around June 19, while Prime members should get the headphones sooner in most cases.\n\n\n\nNote: MacRumors is an affiliate partne…",
            "url":
                "https://www.macrumors.com/2025/06/14/airpods-pro-2-169-airpods-4-99/",
            "urlToImage":
                "https://images.macrumors.com/t/T07At4JWez19K3RtsMef30uvPQs=/2500x/article-new/2023/05/Airpods-Pro-2-Discount-Feature-Blue-Triad.jpg",
            "publishedAt": "2025-06-14T18:51:29Z",
            "content":
                "Amazon has the AirPods Pro 2 for \$169.00 this weekend, down from \$249.00. Free delivery options provide an estimated delivery date of around June 19, while Prime members should get the headphones soo… [+761 chars]",
          },
          {
            "source": {"id": null, "name": "CNET"},
            "author": "Amanda Kooser",
            "title":
                "My T-Mobile 5G Home Internet Experience: 5 Things I Love and a Few I Don't",
            "description":
                "I've been using this cellular home internet service for nearly three years. It's superior to my old DSL, but it's not perfect.",
            "url":
                "https://www.cnet.com/home/internet/my-t-mobile-5g-home-internet-experience-5-things-i-love-and-a-few-i-dont/",
            "urlToImage":
                "https://www.cnet.com/a/img/resize/02a9b6286bb469b6128b4d9a95e67edea4f4d856/hub/2024/09/25/bb120ff9-8846-4fea-8627-1c0a4fd660b2/tmobile3.jpg?auto=webp&fit=crop&height=675&width=1200",
            "publishedAt": "2025-06-14T10:30:00Z",
            "content":
                "Albuquerque, New Mexico: home of green chiles, 300 days of sunshine, the International Balloon Fiesta... and achingly slow internet. Of the top 100 cities in the US, Albuquerque ranks 85th, according… [+8725 chars]",
          },
        ],
      }),
    );
  }
}
