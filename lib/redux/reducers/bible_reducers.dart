import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/redux/state/search_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

class BibleReducers {
  BibleAppState reducer(BibleAppState prev, dynamic action) {
    if (action is FetchVerseLookupAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: prev.bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    if (action is UpdateChapterAction) {
      BibleInfoBook bookInfo = prev.bibleState.bibleVm.bibleInfo.books[action.verses[0].bookNumber - 1];
      BibleBook book = prev.bibleState.bibleVm.bible.books[action.verses[0].bookNumber - 1];

      BibleState bibleState = BibleState(
          bibleVm: prev.bibleState.bibleVm,
          bibleInfoBook: bookInfo,
          book: book,
          chapter: BibleChapter(action.chapterNumber, action.verses),
          verses: action.verses,
          chapters: prev.bibleState.chapters,
          currentChapter: BibleChapter(action.chapterNumber, action.verses),
          previousChapter: prev.bibleState.previousChapter, nextChapter: prev.bibleState.nextChapter);
      return BibleAppState(settingsState: prev.settingsState, bibleState: bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    if (action is UpdateBookAction) {
      BibleState bibleState = BibleState(bibleVm: prev.bibleState.bibleVm,
          bibleInfoBook: action.bookInfo,
          book: action.book,
          chapter: prev.bibleState.chapter,
          verses: prev.bibleState.verses,
          chapters: prev.bibleState.chapters,
          currentChapter: prev.bibleState.currentChapter,
          previousChapter: prev.bibleState.previousChapter,
          nextChapter: prev.bibleState.nextChapter);
      return BibleAppState(settingsState: prev.settingsState, bibleState: bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    if (action is FetchVerseLookupAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: prev.bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is LoadBibleAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: BibleState.bible(bibleVm: action.bibleVm), chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is FetchBibleVmAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: BibleState.bible(bibleVm: action.bibleVm), chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is FetchSettingsAction) {
      SettingsState settingsState = SettingsState(fontWeightIndex: action.fontWeightIndex,
          fontStyleName: action.fontStyleName,
          settingColor: action.settingColor,
          fontSize: action.fontSize,
          fontType: action.fontType,
          isDarkModeOn: action.isDarkModeOn);
      return BibleAppState(bibleState: prev.bibleState, settingsState: settingsState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is UpdateColorAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: action.settingColor,
          fontSize: prev.settingsState.fontSize,
          fontType: prev.settingsState.fontType,
          isDarkModeOn: prev.settingsState.isDarkModeOn);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is UpdateBrightnessAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: prev.settingsState.settingColor,
          fontSize: prev.settingsState.fontSize,
          fontType: prev.settingsState.fontType,
          isDarkModeOn: action.isDarkMode);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is UpdateFontSizeAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: prev.settingsState.settingColor,
          fontSize: action.fontSize,
          fontType: prev.settingsState.fontType,
          isDarkModeOn: prev.settingsState.isDarkModeOn);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is UpdateFontTypeAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: prev.settingsState.settingColor,
          fontSize: prev.settingsState.fontSize,
          fontType: action.fontType,
          isDarkModeOn: prev.settingsState.isDarkModeOn);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState, searchState: prev.searchState);
    }
    else if(action is UpdateSearchAction) {
      SearchState searchState = SearchState(searchText: action.searchText, verses: action.verses);
      return BibleAppState(settingsState: prev.settingsState, bibleState: prev.bibleState, chapterState: prev.chapterState, searchState: searchState);
    }
    else {
      return prev;
    }
  }
}