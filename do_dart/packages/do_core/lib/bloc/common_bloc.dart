import 'package:do_core/bloc/common_event.dart';
import 'package:do_core/bloc/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc(CommonState state) : super(state);

  @override
  Stream<CommonState> mapEventToState(CommonEvent event) async* {
    if (event is RequestedEvent) {
      yield RequestInProgressState();
      try {
        dynamic data = await getData();
        yield RequestSuccessState(data: data);
      } catch (e) {
        yield RequestFailureState(error: e.toString());
      }
    } else if (event is SubmittedEvent) {
      yield SubmitInProgressState();
      try {
        dynamic data = await putData();
        yield SubmitSuccessState(data: data);
      } catch (e) {
        yield SubmitFailureState(error: e.toString());
      }
    }
  }

  Future<dynamic> getData();

  Future<dynamic> putData();
}
