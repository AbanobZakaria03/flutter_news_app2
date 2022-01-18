import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app2/shared/cubit/states.dart';
import 'package:flutter_news_app2/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState()) {
    isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;
  }

  static AppCubit get(context) => BlocProvider.of(context);

  late bool isDark;

  void changeAppMode({required bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    }
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});

    emit(AppChangeModeState());
  }
}
