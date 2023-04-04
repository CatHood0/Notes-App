import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/data/notifier/note_notifier.dart';
import '../../domain/entities/Note.dart';

final noteNotifierProvider = StateNotifierProvider<notesNotifier, List<note>>((ref) => notesNotifier());
