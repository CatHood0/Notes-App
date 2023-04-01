import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/domain/notifier/note_notifier.dart';
import '../entities/Note.dart';

final noteNotifierProvider = StateNotifierProvider<notesNotifier, List<note>>((ref) => notesNotifier());
