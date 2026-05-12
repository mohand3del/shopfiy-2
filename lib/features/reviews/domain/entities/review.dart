class Review {
  final String comment;
  final int rating;
  final DateTime createdAt;
  final String userName;
  final String? userPicture;

  const Review({
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.userName,
    this.userPicture,
  });
}
