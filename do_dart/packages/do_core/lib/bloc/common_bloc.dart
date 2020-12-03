import 'package:do_core/bloc/common_event.dart';
import 'package:do_core/bloc/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CommonBloc<T> extends Bloc<CommonEvent, CommonState> {
  CommonBloc(CommonState state) : super(state);

  @override
  Stream<CommonState> mapEventToState(CommonEvent event) async* {
    if (event is RequestedEvent) {
      yield InProgressState();
      try {
        T data = await getData();
        yield SuccessState<T>(data: data);
      } catch (e) {
        yield FailureState(error: e.toString());
      }
    } else if (event is SubmittedEvent) {
      yield InProgressState();
      try {
        T data = await getData();
        yield SuccessState<T>(data: data);
      } catch (e) {
        yield FailureState(error: e.toString());
      }
    }
  }

  Future<T> getData();
}
