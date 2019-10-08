import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import '../models/result_model.dart';

class DetailMoviesBloc {
  final _repository = Repository();
  final _detailMovieFetcher = PublishSubject<Result>();

  Observable<Result> get getDetails => _detailMovieFetcher.stream;

  getAllDetails(int selectedIndex) async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    Result detail = itemModel.results[selectedIndex];
    _detailMovieFetcher.sink.add(detail);
  }

  dispose() {
    _detailMovieFetcher.close();
  }
}

final detailBloc = DetailMoviesBloc();
