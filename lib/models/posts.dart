

class Like{
  final List<String> usernames;
  final int like;
  Like({
    required this.like,
    required this.usernames
});
}


class Comment{
  final String username;
  final String text;
  final String userImage;

  Comment({
    required this.text,
    required this.username,
    required this.userImage
});
}



class Post{
 final String id;
 final String userId;
 final String title;
 final String imageUrl;
 final String imageId;
 final String detail;
 final Like like;
 final List<Comment> comments;

 Post({
   required this.imageUrl,
   required this.id,
   required this.title,
   required this.userId,
   required this.detail,
   required this.comments,
   required this.imageId,
   required this.like
});


}