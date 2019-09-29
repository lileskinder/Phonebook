import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:exemplo/src/shared/models/contact.dart';
import 'package:exemplo/src/shared/repository/contact_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../app_module.dart';

class HomeBloc extends BlocBase {
  // ModelContact modelContact = ModelContact();
  final contactRepository =
      AppModule.to.getDependency<ContactRepository>(); //pega a injeção do BLoC

  List<Map> contacts;
  Map contact;
  bool searchButton = false;
  bool showSearch = false;

  BehaviorSubject<List<Map>> _listContactController;
  BehaviorSubject<Map> _contactController;
  BehaviorSubject<bool> _searchButtonController;
  BehaviorSubject<bool> _searchController;

  HomeBloc() {
    _listContactController = BehaviorSubject.seeded(contacts);
    _contactController = BehaviorSubject.seeded(contact);
    _searchButtonController = BehaviorSubject.seeded(searchButton);
    _searchController = BehaviorSubject.seeded(showSearch);
    getListContact();
  }

  Observable<bool> get searchOut => _searchController.stream;
  Observable<bool> get buttonSearchOut => _searchButtonController.stream;
  Observable<Map> get contactOut => _contactController.stream;
  Observable<List<Map>> get listContactOut => _listContactController.stream;

  getListContact() async {
    _listContactController.add(await contactRepository.list());
  }

  getListBySearch(String keywords) async {
    _listContactController.add(await contactRepository.list());
  }

  setVisibleButtonSearch(bool visible) {
    _searchButtonController.add(visible);
  }

  setContact(Map contact) {
    _contactController.add(contact);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _listContactController.close();
    _contactController.close();
    super.dispose();
  }
}
