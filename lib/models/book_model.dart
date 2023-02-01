class Book {
  int _id;
  String _item_id;
  String _name;
  String _intro;
  String _author;
  String _edition;
  String _size;
  String _rating;
  // String _image;

  Book(this._item_id, this._name, this._intro, this._author, this._edition, this._size, this._rating);

  Book.WithID(this._item_id, this._id, this._name, this._intro, this._author, this._edition, this._size, this._rating);

  int get id => _id;
  String get item_id => _item_id;
  String get name => _name;
  String get intro => _intro;
  String get author => _author;
  String get edition => _edition;
  String get size => _size;
  String get rating => _rating;

  set name(String name){
    this._name = name;
  }

  set item_id(String value) {
    _item_id = value;
  }

  set intro(String intro){
    this._intro = intro;
  }
  set author(String author){
    this._author = author;
  }
  set edition(String edition){
    this._edition = edition;
  }

  set size(String value) {
    _size = value;
  }

  set rating(String rating){
    this._rating = rating;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['item_id'] = _item_id;
    map['name'] = _name;
    map['intro'] = _intro;
    map['author'] = _author;
    map['edition'] = _edition;
    map['size'] = _size;
    map['rating'] = _rating;

    return map;

  }

  Book.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._item_id = map['item_id'];
    this._name = map['name'];
    this._intro = map['intro'];
    this._author = map['author'];
    this._edition = map['edition'];
    this._size = map['size'];
    this._rating = map['rating'];
  }
}