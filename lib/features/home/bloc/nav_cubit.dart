import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/section.dart';

/// Tracks which section is currently active — driven by the scroll
/// position — so the nav bar can highlight it and the URL can reflect it.
class NavCubit extends Cubit<Section> {
  NavCubit() : super(Section.about);

  void setActive(Section section) {
    if (state != section) emit(section);
  }
}
