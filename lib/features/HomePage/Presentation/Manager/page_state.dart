part of 'page_cubit.dart';

@immutable
sealed class PageState {}

final class PageInitial extends PageState {
  final int pageNumber;
  PageInitial(this.pageNumber);
}
