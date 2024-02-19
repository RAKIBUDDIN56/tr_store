class Response<T> {
  T body;
  int statusCode;
  Map<String, dynamic> headers;

  Response(this.body, this.statusCode, this.headers);
}
