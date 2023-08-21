import 'dart:io';

class RespostaHttp
{
  String    message = "";
  dynamic   status;
  int       code = 0;
  dynamic   data;
  DateTime  timestamp = DateTime.now();

  RespostaHttp.empty();

  RespostaHttp(
      this.message,
      this.status,
      this.code,
      this.data,
      this.timestamp
  );


  RespostaHttp.naoEncontrado({required this.message}) {
    this.code = HttpStatus.notFound;
    this.status = "Internal Server Error";
  }

  RespostaHttp.erro({required this.message}) {
    this.code = HttpStatus.internalServerError;
    this.status = "Internal Server Error";
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{'message: '$message, 'status: '$status, 'code: '$code, 'data: '$data, 'timestamp: '$timestamp}";
  }
}