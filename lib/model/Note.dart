class note{

  int? _id;
  String _title;
  String _content;
  DateTime _createDate;

  note(this._title, this._content, this._createDate, this._id);

  String getTitle(){
    return _title;
  }

  String getContent(){
    return _content;
  }

  DateTime getDate(){
    return _createDate;
  }

  int? getId(){
    return _id;
  }

}