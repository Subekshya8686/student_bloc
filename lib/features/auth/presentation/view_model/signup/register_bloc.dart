import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';
import 'package:softwarica_student_management_bloc/features/course/presentation/view_model/bloc/course_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final BatchBloc _batchBloc;
  final CourseBloc _courseBloc;

  RegisterBloc({
    required BatchBloc batchBloc,
    required CourseBloc courseBloc,
  })  : _batchBloc = batchBloc,
        _courseBloc = courseBloc,
        super(RegisterState.initial()) {
    on<LoadCoursesAndBatches>(_onRegisterEvent);

    add(LoadCoursesAndBatches());
  }

  void _onRegisterEvent(
    LoadCoursesAndBatches event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isLoading: true));
    _batchBloc.add(LoadBatches());
    _courseBloc.add(LoadCourses());
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
