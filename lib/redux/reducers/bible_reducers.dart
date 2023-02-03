import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

class BibleReducers {
  BibleAppState reducer(BibleAppState prev, dynamic action) {
    if (action is FetchVerseLookupAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: prev.bibleState, chapterState: prev.chapterState);
    }
    if (action is UpdateChapterAction) {
      BibleState bibleState = BibleState(bibleVm: prev.bibleState.bibleVm, bibleInfoBook: prev.bibleState.bibleInfoBook,
          book: prev.bibleState.book,
          chapter: BibleChapter(action.chapterNumber, action.verses),
          verses: prev.bibleState.verses,
          chapters: prev.bibleState.chapters,
          currentChapter: BibleChapter(action.chapterNumber, action.verses),
          previousChapter: prev.bibleState.previousChapter, nextChapter: prev.bibleState.nextChapter);
      return BibleAppState(settingsState: prev.settingsState, bibleState: bibleState, chapterState: prev.chapterState);
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
      return BibleAppState(settingsState: prev.settingsState, bibleState: bibleState, chapterState: prev.chapterState);
    }
    if (action is FetchVerseLookupAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: prev.bibleState, chapterState: prev.chapterState);
    }
    else if(action is LoadBibleAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: BibleState.bible(bibleVm: action.bibleVm), chapterState: prev.chapterState);
    }
    else if(action is FetchBibleVmAction) {
      return BibleAppState(settingsState: prev.settingsState, bibleState: BibleState.bible(bibleVm: action.bibleVm), chapterState: prev.chapterState);
    }
    else if(action is FetchSettingsAction) {
      SettingsState settingsState = SettingsState(fontWeightIndex: action.fontWeightIndex,
          fontStyleName: action.fontStyleName,
          settingColor: action.settingColor,
          fontSize: action.fontSize,
          fontType: action.fontType,
          isDarkModeOn: action.isDarkModeOn);
      return BibleAppState(bibleState: prev.bibleState, settingsState: settingsState, chapterState: prev.chapterState);
    }
    else if(action is UpdateColorAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: action.settingColor,
          fontSize: prev.settingsState.fontSize,
          fontType: prev.settingsState.fontType,
          isDarkModeOn: prev.settingsState.isDarkModeOn);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState);
    }
    else if(action is UpdateBrightnessAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: prev.settingsState.settingColor,
          fontSize: prev.settingsState.fontSize,
          fontType: prev.settingsState.fontType,
          isDarkModeOn: action.isDarkMode);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState);
    }
    else if(action is UpdateFontSizeAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: prev.settingsState.settingColor,
          fontSize: action.fontSize,
          fontType: prev.settingsState.fontType,
          isDarkModeOn: prev.settingsState.isDarkModeOn);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState);
    }
    else if(action is UpdateFontTypeAction) {
      SettingsState state = SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex,
          fontStyleName: prev.settingsState.fontStyleName,
          settingColor: prev.settingsState.settingColor,
          fontSize: prev.settingsState.fontSize,
          fontType: action.fontType,
          isDarkModeOn: prev.settingsState.isDarkModeOn);
      return BibleAppState(settingsState: state, bibleState: prev.bibleState, chapterState: prev.chapterState);
    }
    else {
      return prev;
    }
  }
}