class note{

  static String? _title;
  static String? _content;
  static DateTime? _createDate;

  note({title, content,createDate});

  static String? getTitle(){
    return _title;
  }

  static String? content(){
    return _content;
  }

  static DateTime? getDate(){
    return _createDate;
  }


}