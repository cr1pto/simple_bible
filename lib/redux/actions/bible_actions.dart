import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

ThunkAction<BibleAppState> loadBible = (Store<BibleAppState> store) async {
  if(store.state.bibleState.bibleVm.bibleInfo.books.isEmpty) return store.dispatch(LoadBibleAction(store.state.bibleState.bibleVm));
  BibleService bibleService = getIt();

  var vm = await bibleService.loadBible();

  store.dispatch(LoadBibleAction(vm));
};

ThunkAction<BibleAppState> updateChapter = (Store<BibleAppState> store) async {
  if(store.state.bibleState.bibleVm.bibleInfo.books.isEmpty) return store.dispatch(LoadBibleAction(store.state.bibleState.bibleVm));

  BibleChapter currentChapter = store.state.bibleState.currentChapter;

  UpdateChapterAction action = UpdateChapterAction(currentChapter.chapterNumber, currentChapter.verses);

  store.dispatch(action);
};

ThunkAction<BibleAppState> updateBook = (Store<BibleAppState> store) async {
  if(store.state.bibleState.bibleVm.bibleInfo.books.isEmpty) return store.dispatch(LoadBibleAction(store.state.bibleState.bibleVm));

  BibleBook currentBook = store.state.bibleState.book;
  BibleInfoBook currentBookInfo = store.state.bibleState.bibleInfoBook;

  UpdateBookAction action = UpdateBookAction(currentBookInfo, currentBook);

  store.dispatch(action);
};

ThunkAction<BibleAppState> updateToNextChapter = (Store<BibleAppState> store) async {
  if(store.state.bibleState.bibleVm.bibleInfo.books.isEmpty) return store.dispatch(LoadBibleAction(store.state.bibleState.bibleVm));
  BibleService bibleService = getIt();

  BibleChapter currentChapter = store.state.bibleState.currentChapter;

  // BibleChapter previousChapter = store.state.bibleState.previousChapter;
  // BibleChapter nextChapter = store.state.bibleState.nextChapter;

  BibleChapter nextChapter = bibleService.getNextChapterFromCurrentChapter(store.state.bibleState.bibleVm.bible, store.state.bibleState.bibleVm.bibleInfo, currentChapter);

  UpdateChapterAction action = UpdateChapterAction(nextChapter.chapterNumber, nextChapter.verses);

  store.dispatch(action);
};

ThunkAction<BibleAppState> updateToPreviousChapter = (Store<BibleAppState> store) async {
  if(store.state.bibleState.bibleVm.bibleInfo.books.isEmpty) return store.dispatch(LoadBibleAction(store.state.bibleState.bibleVm));
  BibleService bibleService = getIt();

  BibleChapter currentChapter = store.state.bibleState.currentChapter;

  // BibleChapter previousChapter = store.state.bibleState.previousChapter;
  // BibleChapter nextChapter = store.state.bibleState.nextChapter;

  BibleChapter previousChapter = bibleService.getPreviousChapterFromCurrentChapter(store.state.bibleState.bibleVm.bible, store.state.bibleState.bibleVm.bibleInfo, currentChapter);

  UpdateChapterAction action = UpdateChapterAction(previousChapter.chapterNumber, previousChapter.verses);

  store.dispatch(action);
};

//Action that dispatches to the store
//the action definition containing the properties to dispatch
class UpdateChapterAction {
  final int _chapterNumber;
  final List<BibleVerse> _verses;

  int get chapterNumber => _chapterNumber;
  List<BibleVerse> get verses => _verses;

  UpdateChapterAction(this._chapterNumber, this._verses);
}

class UpdateBookAction {
  final BibleInfoBook _bookInfo;
  final BibleBook _book;

  BibleInfoBook get bookInfo => _bookInfo;
  BibleBook get book => _book;

  UpdateBookAction(this._bookInfo, this._book);
}

class FetchBibleBooksAction {
  final List<BibleBook> _books;

  List<BibleBook> get books => _books;

  FetchBibleBooksAction(this._books);
}

class LoadBibleAction{
  final BibleVm _bibleVm;

  BibleVm get bibleVm => _bibleVm;

  LoadBibleAction(this._bibleVm);
}

class FetchBibleVmAction{
  final BibleVm _bibleVm;

  BibleVm get bibleVm => _bibleVm;

  FetchBibleVmAction(this._bibleVm);
}
class FetchBibleBookAction {
  final BibleBook _book;

  BibleBook get book => _book;

  FetchBibleBookAction(this._book);
}

class FetchBibleInfoBooksAction {
  final List<BibleInfoBook> _booksInfo;

  List<BibleInfoBook> get booksInfo => _booksInfo;

  FetchBibleInfoBooksAction(this._booksInfo);
}

class FetchBibleInfoBookAction {
  final BibleInfoBook _bookInfo;

  BibleInfoBook get bookInfo => _bookInfo;

  FetchBibleInfoBookAction(this._bookInfo);
}

class FetchBibleChaptersAction {
  final List<BibleChapter> _bibleChapters;

  List<BibleChapter> get bibleChapters => _bibleChapters;

  FetchBibleChaptersAction(this._bibleChapters);
}

class FetchBibleChapterAction {
  final BibleChapter _bibleChapter;

  BibleChapter get bibleChapter => _bibleChapter;

  FetchBibleChapterAction(this._bibleChapter);
}

class FetchVersesAction {
  final List<BibleVerse> _verses;

  List<BibleVerse> get verses => _verses;

  FetchVersesAction(this._verses);
}

class FetchVerseAction {
  final BibleVerse _bibleVerse;

  BibleVerse get verse => _bibleVerse;

  FetchVerseAction(this._bibleVerse);
}

class FetchVerseLookupAction {
  BibleBook _book;
  BibleChapter _chapter;
  List<BibleVerse> _verses;
  SettingsState _settings;

  BibleBook get book => _book;
  BibleChapter get chapter => _chapter;
  List<BibleVerse> get verses => _verses;
  SettingsState get settings => _settings;

  FetchVerseLookupAction(this._book, this._chapter, this._verses, this._settings);
}