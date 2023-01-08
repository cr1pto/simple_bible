// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i26;
import 'package:simple_bible/bloc/bible/bible_bloc.dart' as _i30;
import 'package:simple_bible/components/recent_verse.dart' as _i21;
import 'package:simple_bible/data/sembast_db.dart' as _i24;
import 'package:simple_bible/data/shared_prefs.dart' as _i23;
import 'package:simple_bible/layouts/bible_navigation_layout.dart' as _i5;
import 'package:simple_bible/layouts/main_layout.dart' as _i16;
import 'package:simple_bible/models/bible.dart' as _i3;
import 'package:simple_bible/models/bible_book.dart' as _i4;
import 'package:simple_bible/models/bible_chapter.dart' as _i7;
import 'package:simple_bible/models/bible_verse.dart' as _i22;
import 'package:simple_bible/models/bibleinfo.dart' as _i10;
import 'package:simple_bible/screens/bible_screen.dart' as _i8;
import 'package:simple_bible/screens/book_screen.dart' as _i9;
import 'package:simple_bible/screens/book_search_screen.dart' as _i29;
import 'package:simple_bible/screens/chapter_screen.dart' as _i11;
import 'package:simple_bible/screens/chapters_screen.dart' as _i12;
import 'package:simple_bible/screens/home.dart' as _i14;
import 'package:simple_bible/screens/home_options_screen.dart' as _i13;
import 'package:simple_bible/screens/memorize_scripture_screen.dart' as _i17;
import 'package:simple_bible/screens/myapp.dart' as _i19;
import 'package:simple_bible/screens/recent_activity_screen.dart' as _i20;
import 'package:simple_bible/screens/settings.dart' as _i25;
import 'package:simple_bible/screens/verses_screen.dart' as _i27;
import 'package:simple_bible/services/app.module.dart' as _i31;
import 'package:simple_bible/services/bible.service.dart' as _i28;
import 'package:simple_bible/services/log.service.dart' as _i15;
import 'package:simple_bible/shared/menu_bar.dart' as _i18;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.Bible>(() => _i3.Bible(
          gh<String>(),
          gh<List<_i4.BibleBook>>(),
        ));
    gh.factory<_i5.BibleNavigationLayout>(() => _i5.BibleNavigationLayout(
          key: gh<_i6.Key>(),
          chapter: gh<_i7.BibleChapter>(),
          child: gh<_i6.Widget>(),
          title: gh<String>(),
          drawer: gh<bool>(),
          floatingBack: gh<bool>(),
          floatingBackHero: gh<String>(),
        ));
    gh.factory<_i8.BibleScreen>(() => _i8.BibleScreen(key: gh<_i6.Key>()));
    gh.factory<_i9.BookScreen>(() => _i9.BookScreen(
          key: gh<_i6.Key>(),
          bookName: gh<String>(),
          book: gh<_i4.BibleBook>(),
          bible: gh<_i3.Bible>(),
          bibleInfo: gh<_i10.BibleInfo>(),
        ));
    gh.factory<_i11.ChapterScreen>(() => _i11.ChapterScreen(
          key: gh<_i6.Key>(),
          bookName: gh<String>(),
          chapter: gh<_i7.BibleChapter>(),
          bibleInfo: gh<_i10.BibleInfo>(),
          bible: gh<_i3.Bible>(),
        ));
    gh.factory<_i12.ChaptersScreen>(() => _i12.ChaptersScreen(
          key: gh<_i6.Key>(),
          bookName: gh<String>(),
          chapters: gh<List<_i7.BibleChapter>>(),
          bibleInfo: gh<_i10.BibleInfo>(),
          bible: gh<_i3.Bible>(),
        ));
    gh.factory<_i13.HomeOptionsScreen>(
        () => _i13.HomeOptionsScreen(key: gh<_i6.Key>()));
    gh.factory<_i14.HomeScreen>(() => _i14.HomeScreen(key: gh<_i6.Key>()));
    gh.singleton<_i15.LogService>(_i15.LogService());
    gh.factory<_i16.MainLayout>(() => _i16.MainLayout(
          key: gh<_i6.Key>(),
          child: gh<_i6.Widget>(),
          title: gh<String>(),
          drawer: gh<bool>(),
          floatingBack: gh<bool>(),
          floatingBackHero: gh<String>(),
        ));
    gh.factory<_i17.MemorizeScriptureScreen>(
        () => _i17.MemorizeScriptureScreen(key: gh<_i6.Key>()));
    gh.factory<_i18.MenuDrawer>(() => _i18.MenuDrawer(
          key: gh<_i6.Key>(),
          color: gh<_i6.Color>(),
          fontSize: gh<double>(),
        ));
    gh.factory<_i19.MyApp>(() => _i19.MyApp(key: gh<_i6.Key>()));
    gh.factory<_i20.RecentActivityScreen>(
        () => _i20.RecentActivityScreen(key: gh<_i6.Key>()));
    gh.factory<_i21.RecentVerse>(() => _i21.RecentVerse(
          key: gh<_i6.Key>(),
          verse: gh<_i22.BibleVerse>(),
        ));
    gh.factory<_i23.SPSettings>(() => _i23.SPSettings());
    gh.singleton<_i24.SembastDb>(_i24.SembastDb());
    gh.factory<_i25.SettingsScreen>(
        () => _i25.SettingsScreen(key: gh<_i6.Key>()));
    await gh.factoryAsync<_i26.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i27.VersesScreen>(() => _i27.VersesScreen(
          key: gh<_i6.Key>(),
          title: gh<String>(),
          verses: gh<List<_i22.BibleVerse>>(),
          bibleInfo: gh<_i10.BibleInfo>(),
          bible: gh<_i3.Bible>(),
        ));
    gh.factory<_i28.BibleService>(
        () => _i28.BibleService(gh<_i15.LogService>()));
    gh.factory<_i29.BookSearchScreen>(() => _i29.BookSearchScreen(
          gh<int>(),
          gh<double>(),
          key: gh<_i6.Key>(),
          bibleService: gh<_i28.BibleService>(),
        ));
    gh.factory<_i30.BibleBloc>(() => _i30.BibleBloc(gh<_i28.BibleService>()));
    return this;
  }
}

class _$AppModule extends _i31.AppModule {}
