import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/interface/ICrudLocal.dart';
import 'package:notes_project/domain/interface/ISearch.dart';

abstract class INoteLocalRepository implements ICrudLocal<Note>, ISearch<Note>{
  Future<List<Note>> getAllNotes();
  Future<void> openDatabase();
  Future<void> closeDatabase();
}