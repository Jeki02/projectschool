import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_school/Presentation/Bloc/QR/QR_event.dart';
import 'package:flutter_school/Presentation/Bloc/QR/QR_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRBloc extends Bloc<QREvent, QRState> {
  QRViewController? qrViewController;

  QRBloc() : super(QRInitial()) {
    on<QRStarted>((event, emit) {
    });

    on<QRCodeScanned>((event, emit) {
      if (event.code != null) {
        emit(QRSuccess(event.code!));
      } else {
        emit(QRFailure());
      }
    });
  }

  void setController(QRViewController controller) {
    this.qrViewController = controller;
    qrViewController!.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        add(QRCodeScanned(scanData.code!));
      }
    });
  }
}