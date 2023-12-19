abstract class QRState {}

class QRInitial extends QRState {}

class QRSuccess extends QRState {
  final String code;

  QRSuccess(this.code);
}

class QRFailure extends QRState {}