class note{

  int? _key;//ponemos key porque de esa forma es que se suele registrar en firestore. Key value
  String _title;
  String _content;
  bool favorite;
  DateTime _createDate;
  DateTime _dateTimeModification;

  note(this._title, this._content, this._createDate, this._key, this.favorite, this._dateTimeModification);

  String getTitle(){
    return _title;
  }

  void setFavorite(bool nState){
      favorite = nState;
  }

  bool getFavorite(){
     return favorite;
  }

  String getContent(){
    return _content;
  }

  void setTitle(String? newTitle){
      _title = newTitle!;
  }

  void setContent(String? newContent){
      _content = newContent!;
  }

   DateTime getDateModification(){
      return _dateTimeModification;
  }

  void setDateModification(DateTime timeNow){
     _dateTimeModification = timeNow;
  }

  DateTime getDate(){
    return _createDate;
  }

  int? getKey(){
    return _key;
  }

}