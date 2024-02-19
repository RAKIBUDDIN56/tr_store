import 'dart:convert';

List<Products> productFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

class Products {
  final int id;
  final String slug;
  final String url;
  final String title;
  final String content;
  final String image;
  final String thumbnail;
  final String publishedAt;
  final String updatedAt;
  final int userId;

  Products({
    required this.id,
    required this.slug,
    required this.url,
    required this.title,
    required this.content,
    required this.image,
    required this.thumbnail,
    required this.publishedAt,
    required this.updatedAt,
    required this.userId,
  });

  Products copyWith({
    int? id,
    String? slug,
    String? url,
    String? title,
    String? content,
    String? image,
    String? thumbnail,
    String? publishedAt,
    String? updatedAt,
    int? userId,
  }) =>
      Products(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        url: url ?? this.url,
        title: title ?? this.title,
        content: content ?? this.content,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
        publishedAt: publishedAt ?? this.publishedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        slug: json["slug"],
        url: json["url"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        publishedAt: json["publishedAt"],
        updatedAt: json["updatedAt"],
        userId: json["userId"],
      );
}
