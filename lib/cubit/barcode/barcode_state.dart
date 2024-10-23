abstract class BarcodeState {}

class BarcodeInitial extends BarcodeState {}

class BarcodeLoading extends BarcodeState {}

class BarcodeSuccess extends BarcodeState {
  final String message;

  BarcodeSuccess({required this.message});
}

class BarcodeError extends BarcodeState {
  final String error;

  BarcodeError({required this.error});
}
