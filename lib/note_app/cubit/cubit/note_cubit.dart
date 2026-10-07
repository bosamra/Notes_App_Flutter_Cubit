import 'package:bloc/bloc.dart';
import 'package:notes_app_cubit/core/helpers/hive_helper.dart';

import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  String searchQuery = "";

  void getNotes() async {
    emit(NoteLoadingState());
    await HiveHelper.getNotes();
    if (HiveHelper.myNotes.isEmpty) {
      emit(NoteEmptyState());
    } else {
      emit(NoteSuccessState());
    }
  }

  void addNote(String title, String content) {
    HiveHelper.addNote(title, content);
    emit(NoteAddedState());
  }

  void updateNote(int index, String title, String content) {
    HiveHelper.updateNote(index, title, content);
    emit(NoteAddedState());
  }

  void deleteNote(int index) {
    HiveHelper.deleteNote(index);
    emit(NoteDeleteNoteState());
  }

  void clearAllNotes() {
    HiveHelper.deleteAllNotes();
    emit(NoteClearAllState());
  }

  void sortNotes() {
    HiveHelper.sortNotes();
    emit(NoteSortedState());
  }

  void search(String query) {
    searchQuery = query;
    emit(NoteSearchState());
  }
}
