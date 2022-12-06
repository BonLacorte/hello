class NewsData {
  String? title;
  String? author;
  String? content;
  String? urlToImage;
  String? date;

  NewsData(
    this.title,
    this.author,
    this.content,
    this.urlToImage,
    this.date,
  );

  // static news for now
  static List<NewsData> breakingNewsData = [
    NewsData(
        "Trump suggestion of ‘termination’ of Constitution draws few GOP rebukes - The Washington Post",
        "Amy B Wang",
        "Trump’s posts represent an escalation in his attacks on American institutions — one that scholars say must be heeded as a sign of how far he is willing to go to regain power.",
        "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/12-04-2022/t_0c3f6516f75d42ef85acdc711e05fc51_name_THUMB.jpg&w=1440",
        "2022-12-05"),
    NewsData(
        "Trump suggestion of ‘termination’ of Constitution draws few GOP rebukes - The Washington Post",
        "Amy B Wang",
        "Trump’s posts represent an escalation in his attacks on American institutions — one that scholars say must be heeded as a sign of how far he is willing to go to regain power.",
        "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/12-04-2022/t_0c3f6516f75d42ef85acdc711e05fc51_name_THUMB.jpg&w=1440",
        "2022-12-05"),
    NewsData(
        "Trump suggestion of ‘termination’ of Constitution draws few GOP rebukes - The Washington Post",
        "Amy B Wang",
        "Trump’s posts represent an escalation in his attacks on American institutions — one that scholars say must be heeded as a sign of how far he is willing to go to regain power.",
        "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/12-04-2022/t_0c3f6516f75d42ef85acdc711e05fc51_name_THUMB.jpg&w=1440",
        "2022-12-05"),
  ];
}


// ba7df744c6e84c2a95744e72c65ffb92