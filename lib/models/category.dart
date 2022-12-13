class Category {
  String title;
  String urlToImage;

  Category(
    this.title,
    this.urlToImage,
  );

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     category: json['category'],
  //     image: json['image'],
  //     price: json['price'],
  //   );
  // }

  static List<Category> searchCategoryList = [
    Category("Business",
        "https://images.pexels.com/photos/323705/pexels-photo-323705.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Category("Entertainment",
        "https://th.bing.com/th/id/OIP.rCHMgW1YtjW_fqpgiqktzQHaFj?pid=ImgDet&rs=1"),
    Category("Health",
        "https://th.bing.com/th/id/OIP.XBQq1BESnxEa1gXKqWlPIQHaEH?pid=ImgDet&rs=1"),
    Category("Science",
        "https://www.pexels.com/photo/scientist-in-laboratory-3735709/"),
    Category("Sports",
        "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2012/04/s.shutterstock_128336561.jpg"),
    Category("Technology",
        "https://th.bing.com/th/id/R.50554465251c081bc378d496b74f1c97?rik=mAhxQDL8DG%2bC0Q&riu=http%3a%2f%2fwww.newdesignfile.com%2fpostpic%2f2013%2f10%2ffree-stock-technology-photos_377682.jpg&ehk=q2bprZP7UiAYr1gPQsYi8YEyChKLu7GBCKBcEwYmERY%3d&risl=&pid=ImgRaw&r=0"),
  ];
}
