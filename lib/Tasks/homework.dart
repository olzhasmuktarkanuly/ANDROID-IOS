void main() {
  Library myLibrary = Library();

  myLibrary.addBook(Book(title: "1984", author: "George Orwell", price: 35.0));
  myLibrary.addBook(Book(title: "Dart in Action", author: "Chris Buckett", price: 50.0, isBorrowed: true));
  myLibrary.addBook(Book(title: "Clean Code", author: "Robert Martin", price: 65.0));
  var availableBooks= myLibrary.getAvailableBooks();
  for (var book in availableBooks) {
    print("${book.title} (${book.author}) - \$${book.price}");
  }
  print("\nTotal Library Value\$${myLibrary.getTotalValue()}");



  ShoppingCart cart = ShoppingCart();

  cart.addItem(EBook(
    id: "B001",
    title: "Flutter for Beginners",
    price: 45.0,
    fileSizeMB: 15.5,
    author: "John Doe",
  ));
  cart.addItem(Audiobook(
    id: "A001",
    title: "Dart Mastery",
    price: 60.0,
    durationHours: 8.5,
    narrator: "Jane Smith",
  ));

  var cheapItems = cart.filterByMaxPrice(50.0);
  for (var item in cheapItems) {
    print(item.getDetails());
}
}

class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed= false,
  });
}

class Library {
  final List<Book> _books=[];

  void addBook(Book book) {
    _books.add(book);
  }
  Iterable<Book> getAvailableBooks() {
    return _books.where((book) => book.isBorrowed == false);
  }
  double getTotalValue() {
    return _books.fold(0.0, (sum, book) => sum + book.price);
  }
}
abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({
    required this.id,
    required this.title,
    required this.price,
  });

  String getDetails();
}

mixin Downloadable{
  void download(String title) {
    print("Downloading$title");
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });




  @override
  String getDetails() {
    return "Audiobook: $title (Narrator: $narrator, $durationHours h.) - \$$price";
  }
}
class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() {
    return "E-Book$title (Author$author, $fileSizeMB Mb - \$$price";
  }
}

class ShoppingCart {
  final List<MediaItem> _items= [];


  void addItem(MediaItem item) {
    _items.add(item);
  }
  double calculateTotalWithTax({double taxRate = 0.12}) {
    double totalWithoutTax = _items.fold(0.0, (sum, item) => sum + item.price);
    return totalWithoutTax + (totalWithoutTax * taxRate);
  }





  Iterable<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item)=> item.price <= maxPrice);
  }
  void printReceipt() {
    for (var item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print("Total to pay (incl. 12% tax):\$${calculateTotalWithTax()}");
  }
}