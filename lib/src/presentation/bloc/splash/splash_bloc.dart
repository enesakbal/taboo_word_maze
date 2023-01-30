import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecaces/taboo_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final TabooUsecase tabooUsecase;
  SplashBloc(this.tabooUsecase) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
  }
}
