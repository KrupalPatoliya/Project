import 'package:bloc/bloc.dart';
import 'package:training_app/helpers/api_helpper/lazy_loading_api_helpper.dart';
import '../../models/userdata.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiLoading()) {
    on<GetApiList>((event, emit) async {
      emit(ApiLoading());

      List<UserData>? data = await LazyLoadingApiHelpper.lazyLoadingApiHelpper.fetchingMultipleData(id: 1,result: 50);

      if (data!.isEmpty) {
        emit(const ApiError("Data Not Found"));
      } else {
        emit(ApiLoaded(data));
      }
    });
  }
}
