import 'package:fats_mobile_demo/Services/receiving/receiving_controller.dart';
import 'package:fats_mobile_demo/cubit/receiving/receiving_states.dart';
import 'package:fats_mobile_demo/models/PODetailsModel.dart';
import 'package:fats_mobile_demo/models/POMasterModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceivingCubit extends Cubit<ReceivingStates> {
  ReceivingCubit() : super(GetPOMasterInitialState());

  List<POMasterModel> poMaster = [];
  List<PODetailsModel> poDetails = [];

  String selectedId = '';
  POMasterModel? selectedPOMaster;

  static ReceivingCubit get(context) => BlocProvider.of(context);

  getPOMaster() async {
    emit(GetPOMasterLoadingState());
    try {
      var poMasterList = await ReceivingController.getPOMaster();
      poMaster = poMasterList;
      emit(GetPOMasterSuccessState(poMasterList));
    } catch (e) {
      emit(GetPOMasterErrorState(e.toString()));
    }
  }

  getPODetails(String pOMasterID) async {
    emit(GetPODetailsLoadingState());
    try {
      var poDetailsList = await ReceivingController.getPODetails(pOMasterID);
      poDetails = poDetailsList;
      selectedPOMaster =
          poMaster.firstWhere((element) => element.id.toString() == pOMasterID);
      emit(GetPODetailsSuccessState(poDetailsList));
    } catch (e) {
      emit(GetPODetailsErrorState(e.toString()));
    }
  }

  // Add this method to update selectedPOMaster
  void updateSelectedPOMaster(POMasterModel poMaster) {
    selectedPOMaster = poMaster;
    selectedId = poMaster.id.toString();
    emit(UpdateSelectedPOMasterState());
  }
}
