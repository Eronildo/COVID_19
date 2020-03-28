import 'package:covid19/src/models/data.dart';
import 'package:covid19/src/utils/repository.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc {

  final Repository _repository = new Repository();

  final BehaviorSubject<Data> _dataController = new BehaviorSubject<Data>();
  final BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();

  // Output
  Stream<Data> get getData => _dataController.stream;
  Stream<bool> get getLoading => _loadingController.stream;
  // Input
  Function(Data) get _setData => _dataController.sink.add;
  Function(bool) get _setLoading => _loadingController.sink.add;

  AppBloc() {
    setData();
  }

  void setData() async {
    _setLoading(true);
    _setData(await _repository.getData());
    _setLoading(false);
  }

  void dispose() {
    _dataController.close();
    _loadingController.close();
  }
}
