class Response<L,T>{
  L? error;
  T? object;

  static L left<L>(L error){
    return error;
  }

  static T right<T>(T object){
    return object;
  }

}