part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchLoading extends SearchState {

}

final class SearchLoaded extends SearchState {
  final List<Product> products;

  const SearchLoaded({this.products = const <Product>[]});
  @override
  List<Object> get props => [products];

}
