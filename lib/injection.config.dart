// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:redux/redux.dart' as _i33;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart'
    as _i7;
import 'package:sembast/sembast.dart' as _i17;
import 'package:shared_preferences/shared_preferences.dart' as _i32;
import 'package:simple_bible/components/recent_verse.dart' as _i26;
import 'package:simple_bible/data/sembast_db.dart' as _i30;
import 'package:simple_bible/data/shared_prefs.dart' as _i28;
import 'package:simple_bible/layouts/bible_navigation_layout.dart' as _i5;
import 'package:simple_bible/layouts/main_layout.dart' as _i21;
import 'package:simple_bible/models/simple_objects/bible.dart' as _i3;
import 'package:simple_bible/models/simple_objects/bible_book.dart' as _i4;
import 'package:simple_bible/models/simple_objects/bible_chapter.dart' as _i16;
import 'package:simple_bible/models/simple_objects/bible_verse.dart' as _i27;
import 'package:simple_bible/models/simple_objects/bibleinfo.dart' as _i12;
import 'package:simple_bible/modules/app.module.dart' as _i36;
import 'package:simple_bible/redux/state/bible_app_state.dart' as _i34;
import 'package:simple_bible/redux/store.dart' as _i10;
import 'package:simple_bible/screens/stateful/book_search_screen.dart' as _i13;
import 'package:simple_bible/screens/stateful/chapters_screen.dart' as _i15;
import 'package:simple_bible/screens/stateful/material_root.dart' as _i22;
import 'package:simple_bible/screens/stateful/search_screen.dart' as _i29;
import 'package:simple_bible/screens/stateful/settings_screen.dart' as _i31;
import 'package:simple_bible/screens/stateless/bible_screen.dart' as _i8;
import 'package:simple_bible/screens/stateless/book_screen.dart' as _i11;
import 'package:simple_bible/screens/stateless/chapter_screen.dart' as _i14;
import 'package:simple_bible/screens/stateless/home_options_screen.dart'
    as _i18;
import 'package:simple_bible/screens/stateless/home_screen.dart' as _i19;
import 'package:simple_bible/screens/stateless/memorize_scripture_screen.dart'
    as _i23;
import 'package:simple_bible/screens/stateless/recent_activity_screen.dart'
    as _i25;
import 'package:simple_bible/screens/stateless/verses_screen.dart' as _i35;
import 'package:simple_bible/services/bible.service.dart' as _i9;
import 'package:simple_bible/services/log.service.dart' as _i20;
import 'package:simple_bible/shared/menu_bar.dart' as _i24;

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
          child: gh<_i6.Widget>(),
          scrollController: gh<_i7.ItemScrollController>(),
        ));
    gh.factory<_i8.BibleScreen>(() => _i8.BibleScreen(key: gh<_i6.Key>()));
    gh.factory<_i9.BibleService>(() => _i9.BibleService());
    gh.singleton<_i10.BibleStore>(_i10.BibleStore());
    gh.factory<_i11.BookScreen>(() => _i11.BookScreen(
          key: gh<_i6.Key>(),
          bookName: gh<String>(),
          book: gh<_i4.BibleBook>(),
          bible: gh<_i3.Bible>(),
          bibleInfo: gh<_i12.BibleInfo>(),
        ));
    gh.factory<_i13.BookSearchScreen>(() => _i13.BookSearchScreen(
          gh<int>(),
          gh<double>(),
          key: gh<_i6.Key>(),
          bibleService: gh<_i9.BibleService>(),
        ));
    gh.factory<_i14.ChapterScreen>(() => _i14.ChapterScreen(
          key: gh<_i6.Key>(),
          scrollController: gh<_i7.ItemScrollController>(),
        ));
    gh.factory<_i15.ChaptersScreen>(() => _i15.ChaptersScreen(
          key: gh<_i6.Key>(),
          bookName: gh<String>(),
          chapters: gh<List<_i16.BibleChapter>>(),
          bibleInfo: gh<_i12.BibleInfo>(),
          bible: gh<_i3.Bible>(),
        ));
    await gh.factoryAsync<_i17.Database>(
      () => appModule.database,
      preResolve: true,
    );
    gh.factory<_i18.HomeOptionsScreen>(
        () => _i18.HomeOptionsScreen(key: gh<_i6.Key>()));
    gh.factory<_i19.HomeScreen>(() => _i19.HomeScreen(key: gh<_i6.Key>()));
    gh.singleton<_i20.LogService>(_i20.LogService());
    gh.factory<_i21.MainLayout>(() => _i21.MainLayout(
          key: gh<_i6.Key>(),
          child: gh<_i6.Widget>(),
          title: gh<String>(),
          drawer: gh<bool>(),
          floatingBack: gh<bool>(),
          floatingBackHero: gh<String>(),
        ));
    gh.factory<_i22.MaterialRoot>(() => _i22.MaterialRoot(key: gh<_i6.Key>()));
    gh.factory<_i23.MemorizeScriptureScreen>(
        () => _i23.MemorizeScriptureScreen(key: gh<_i6.Key>()));
    gh.factory<_i24.MenuDrawer>(() => _i24.MenuDrawer(key: gh<_i6.Key>()));
    gh.factory<_i25.RecentActivityScreen>(
        () => _i25.RecentActivityScreen(key: gh<_i6.Key>()));
    gh.factory<_i26.RecentVerse>(() => _i26.RecentVerse(
          key: gh<_i6.Key>(),
          verse: gh<_i27.BibleVerse>(),
        ));
    gh.factory<_i28.SPSettings>(() => _i28.SPSettings());
    gh.factory<_i29.SearchScreen>(() => _i29.SearchScreen(key: gh<_i6.Key>()));
    gh.singleton<_i30.SembastDb>(_i30.SembastDb());
    gh.factory<_i31.SettingsScreen>(
        () => _i31.SettingsScreen(key: gh<_i6.Key>()));
    await gh.factoryAsync<_i32.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    await gh.factoryAsync<_i33.Store<_i34.BibleAppState>>(
      () => appModule.store,
      preResolve: true,
    );
    gh.factory<_i35.VersesScreen>(() => _i35.VersesScreen(
          key: gh<_i6.Key>(),
          scrollController: gh<_i7.ItemScrollController>(),
        ));
    return this;
  }
}

class _$AppModule extends _i36.AppModule {}
