

class Book{
  final String label;
  final String detail;
  final String imageUrl;
  final String rating;
  final String genres;

  Book({
    required this.detail,
    required this.genres,
    required this.imageUrl,
    required this.label,
    required this.rating
});

  factory Book.fromJson(Map<String, dynamic> json){
    return Book(
        detail: json['detail'],
        genres: json['genres'],
        imageUrl: json['imageUrl'],
        label: json['label'],
        rating: json['rating']
    );
  }

}



final  books = [
  {
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/c/c0/The_Little_Mermaid_%28Official_1989_Film_Poster%29.png',
    'label': 'The Little mermaid1',
    'detail': 'Sixteen-year-old mermaid princess Ariel is dissatisfied with underwater life in the kingdom of Atlantica, a fantasy kingdom in the Atlantic Ocean. She is fascinated by the human world. With her best friend ',
    'rating': '⭐⭐⭐⭐⭐',
    'genres': 'FairyTales'
  },
  {
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/c/c0/The_Little_Mermaid_%28Official_1989_Film_Poster%29.png',
    'label': 'The Little mermaid2',
    'detail': 'Sixteen-year-old mermaid princess Ariel is dissatisfied with underwater life in the kingdom of Atlantica, a fantasy kingdom in the Atlantic Ocean. She is fascinated by the human world. With her best friend ',
    'rating': '⭐⭐⭐⭐',
    'genres': 'FairyTales'
  },
  {
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/c/c0/The_Little_Mermaid_%28Official_1989_Film_Poster%29.png',
    'label': 'The Little mermaid3',
    'detail': 'Sixteen-year-old mermaid princess Ariel is dissatisfied with underwater life in the kingdom of Atlantica, a fantasy kingdom in the Atlantic Ocean. She is fascinated by the human world. With her best friend ',
    'rating': '⭐⭐⭐',
    'genres': 'FairyTales'
  },
];

List<Book> booksData = books.map((e) => Book.fromJson(e)).toList();

