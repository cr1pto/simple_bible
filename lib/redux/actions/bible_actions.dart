import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

ThunkAction<BibleAppState> fetchVerses = (Store<BibleAppState> store) async {

  // store.dispatch(FetchVersesAction(location, time));
};

ThunkAction<BibleAppState> fetchBible = (Store<BibleAppState> store) async {
  store.dispatch(LoadBibleAction);
};

//Action that dispatches to the store
//the action definition containing the properties to dispatch
class FetchBibleBooksAction {
  final List<BibleBook> _books;

  List<BibleBook> get books => _books;

  FetchBibleBooksAction(this._books);
}

class LoadBibleAction{

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