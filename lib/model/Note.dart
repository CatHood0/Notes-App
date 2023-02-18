class note{

  int? _id;
  String _title;
  String _content;
  bool favorite;
  DateTime _createDate;
  DateTime? _dateTimeModification;

  note(this._title, this._content, this._createDate, this._id, this.favorite, [this._dateTimeModification]);

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
    if(_dateTimeModification == null){
      print("Es nulo");
       return _createDate;
    }
    else{
      print("No es nulo");
      return _dateTimeModification!;
    }
  }

  void setDateModification(DateTime timeNow){
     _dateTimeModification = timeNow;
  }

  DateTime getDate(){
    return _createDate;
  }

  int? getId(){
    return _id;
  }

}