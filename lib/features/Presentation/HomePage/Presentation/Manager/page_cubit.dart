import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageInitial(0));
  void changePageNumber(int index) {
    emit(PageInitial(index));
  }
}
