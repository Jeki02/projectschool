abstract class QREvent {}

class QRStarted extends QREvent {}

class QRCodeScanned extends QREvent {
  final String? code;

  QRCodeScanned(this.code);
}