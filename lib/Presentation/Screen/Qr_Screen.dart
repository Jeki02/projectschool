import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_school/Presentation/Bloc/QR/QR_bloc.dart';
import 'package:flutter_school/Presentation/Bloc/QR/QR_event.dart';
import 'package:flutter_school/Presentation/Bloc/QR/QR_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRBloc(),
      child: QRScanView(),
    );
  }
}

class QRScanView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(bottom: 10, child: buildResult()),
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    final bloc = BlocProvider.of<QRBloc>(context);
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) {
        bloc.setController(controller);
        bloc.add(QRStarted());
      },
      overlay: QrScannerOverlayShape(
        borderColor: Colors.indigo,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  Widget buildResult() {
    return BlocBuilder<QRBloc, QRState>(
      builder: (context, state) {
        if (state is QRSuccess) {
          return _buildResultContainer('Result: ${state.code}', Colors.green);
        } else if (state is QRFailure) {
          return _buildResultContainer('Failed to scan QR Code', Colors.red);
        }
        return _buildResultContainer('Scan a QR Code', Colors.white);
      },
    );
  }

  Widget _buildResultContainer(String text, Color textColor) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }

  @override
  void dispose() {
    BlocProvider.of<QRBloc>(context, listen: false).qrViewController?.dispose();
    super.dispose();
  }
}