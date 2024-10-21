import 'package:fats_mobile_demo/models/PODetailsModel.dart';
import 'package:fats_mobile_demo/models/POMasterModel.dart';

class ReceivingStates {}

class GetPOMasterInitialState extends ReceivingStates {}

class GetPOMasterLoadingState extends ReceivingStates {}

class GetPOMasterSuccessState extends ReceivingStates {
  final List<POMasterModel> poMasterList;

  GetPOMasterSuccessState(this.poMasterList);
}

class GetPOMasterErrorState extends ReceivingStates {
  final String error;

  GetPOMasterErrorState(this.error);
}

class GetPODetailsLoadingState extends ReceivingStates {}

class GetPODetailsSuccessState extends ReceivingStates {
  final List<PODetailsModel> poDetailsList;

  GetPODetailsSuccessState(this.poDetailsList);
}

class GetPODetailsErrorState extends ReceivingStates {
  final String error;

  GetPODetailsErrorState(this.error);
}

class UpdateSelectedPOMasterState extends ReceivingStates {}
