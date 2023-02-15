class note{

  String _title;
  String _content;
  DateTime _createDate;

  note(this._title, this._content, this._createDate);

  String getTitle(){
    return _title;
  }

  String getContent(){
    return _content;
  }

  DateTime getDate(){
    return _createDate;
  }


}