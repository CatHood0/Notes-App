
class ResponseEither<L, R> {
  L? error;
  R? object;
  ResponseEither({this.error, this.object});
}
