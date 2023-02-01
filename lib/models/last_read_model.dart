class LastRead {
  int _id;
  String _item_id;
  int _pageno;

  LastRead(this._item_id , this._pageno);
  LastRead.WithID(this._id,this._item_id , this._pageno);

  int get id => _id;
  String get item_id => _item_id;
  int get pageno => _pageno;


  set pageno(int value) {
    _pageno = value;
  }

  set item_id(String value) {
    _item_id = value;
  }

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['item_id'] = _item_id;
    map['page_no'] = _pageno;
    return map;
  }

  LastRead.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._item_id = map['item_id'];
    this._pageno = map['page_no'];
  }
}

