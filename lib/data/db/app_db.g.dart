// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $EntriesTable extends Entries with TableInfo<$EntriesTable, Entry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    day,
    textContent,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Entry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(attachedDatabase, alias);
  }
}

class Entry extends DataClass implements Insertable<Entry> {
  final int id;

  /// Normalized as local midnight for that day.
  final DateTime day;
  final String textContent;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Entry({
    required this.id,
    required this.day,
    required this.textContent,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day'] = Variable<DateTime>(day);
    map['text_content'] = Variable<String>(textContent);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: Value(id),
      day: Value(day),
      textContent: Value(textContent),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Entry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<int>(json['id']),
      day: serializer.fromJson<DateTime>(json['day']),
      textContent: serializer.fromJson<String>(json['textContent']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'day': serializer.toJson<DateTime>(day),
      'textContent': serializer.toJson<String>(textContent),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Entry copyWith({
    int? id,
    DateTime? day,
    String? textContent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Entry(
    id: id ?? this.id,
    day: day ?? this.day,
    textContent: textContent ?? this.textContent,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Entry copyWithCompanion(EntriesCompanion data) {
    return Entry(
      id: data.id.present ? data.id.value : this.id,
      day: data.day.present ? data.day.value : this.day,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('textContent: $textContent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, day, textContent, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.day == this.day &&
          other.textContent == this.textContent &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EntriesCompanion extends UpdateCompanion<Entry> {
  final Value<int> id;
  final Value<DateTime> day;
  final Value<String> textContent;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.day = const Value.absent(),
    this.textContent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime day,
    this.textContent = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : day = Value(day),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Entry> custom({
    Expression<int>? id,
    Expression<DateTime>? day,
    Expression<String>? textContent,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (day != null) 'day': day,
      if (textContent != null) 'text_content': textContent,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? day,
    Value<String>? textContent,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return EntriesCompanion(
      id: id ?? this.id,
      day: day ?? this.day,
      textContent: textContent ?? this.textContent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('textContent: $textContent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EntryImagesTable extends EntryImages
    with TableInfo<$EntryImagesTable, EntryImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, entryId, imagePath, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntryImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryImage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $EntryImagesTable createAlias(String alias) {
    return $EntryImagesTable(attachedDatabase, alias);
  }
}

class EntryImage extends DataClass implements Insertable<EntryImage> {
  final int id;
  final int entryId;
  final String imagePath;
  final int sortOrder;
  const EntryImage({
    required this.id,
    required this.entryId,
    required this.imagePath,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<int>(entryId);
    map['image_path'] = Variable<String>(imagePath);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  EntryImagesCompanion toCompanion(bool nullToAbsent) {
    return EntryImagesCompanion(
      id: Value(id),
      entryId: Value(entryId),
      imagePath: Value(imagePath),
      sortOrder: Value(sortOrder),
    );
  }

  factory EntryImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryImage(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'imagePath': serializer.toJson<String>(imagePath),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  EntryImage copyWith({
    int? id,
    int? entryId,
    String? imagePath,
    int? sortOrder,
  }) => EntryImage(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    imagePath: imagePath ?? this.imagePath,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  EntryImage copyWithCompanion(EntryImagesCompanion data) {
    return EntryImage(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryImage(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('imagePath: $imagePath, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entryId, imagePath, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryImage &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.imagePath == this.imagePath &&
          other.sortOrder == this.sortOrder);
}

class EntryImagesCompanion extends UpdateCompanion<EntryImage> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<String> imagePath;
  final Value<int> sortOrder;
  const EntryImagesCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  EntryImagesCompanion.insert({
    this.id = const Value.absent(),
    required int entryId,
    required String imagePath,
    this.sortOrder = const Value.absent(),
  }) : entryId = Value(entryId),
       imagePath = Value(imagePath);
  static Insertable<EntryImage> custom({
    Expression<int>? id,
    Expression<int>? entryId,
    Expression<String>? imagePath,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (imagePath != null) 'image_path': imagePath,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  EntryImagesCompanion copyWith({
    Value<int>? id,
    Value<int>? entryId,
    Value<String>? imagePath,
    Value<int>? sortOrder,
  }) {
    return EntryImagesCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      imagePath: imagePath ?? this.imagePath,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryImagesCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('imagePath: $imagePath, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $VoiceNotesTable extends VoiceNotes
    with TableInfo<$VoiceNotesTable, VoiceNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VoiceNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryId,
    audioPath,
    durationMs,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'voice_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<VoiceNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    } else if (isInserting) {
      context.missing(_audioPathMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VoiceNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VoiceNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VoiceNotesTable createAlias(String alias) {
    return $VoiceNotesTable(attachedDatabase, alias);
  }
}

class VoiceNote extends DataClass implements Insertable<VoiceNote> {
  final int id;
  final int entryId;
  final String audioPath;
  final int? durationMs;
  final int sortOrder;
  final DateTime createdAt;
  const VoiceNote({
    required this.id,
    required this.entryId,
    required this.audioPath,
    this.durationMs,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<int>(entryId);
    map['audio_path'] = Variable<String>(audioPath);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VoiceNotesCompanion toCompanion(bool nullToAbsent) {
    return VoiceNotesCompanion(
      id: Value(id),
      entryId: Value(entryId),
      audioPath: Value(audioPath),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory VoiceNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VoiceNote(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'audioPath': serializer.toJson<String>(audioPath),
      'durationMs': serializer.toJson<int?>(durationMs),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VoiceNote copyWith({
    int? id,
    int? entryId,
    String? audioPath,
    Value<int?> durationMs = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => VoiceNote(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    audioPath: audioPath ?? this.audioPath,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  VoiceNote copyWithCompanion(VoiceNotesCompanion data) {
    return VoiceNote(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VoiceNote(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('audioPath: $audioPath, ')
          ..write('durationMs: $durationMs, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entryId, audioPath, durationMs, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoiceNote &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.audioPath == this.audioPath &&
          other.durationMs == this.durationMs &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class VoiceNotesCompanion extends UpdateCompanion<VoiceNote> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<String> audioPath;
  final Value<int?> durationMs;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const VoiceNotesCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VoiceNotesCompanion.insert({
    this.id = const Value.absent(),
    required int entryId,
    required String audioPath,
    this.durationMs = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
  }) : entryId = Value(entryId),
       audioPath = Value(audioPath),
       createdAt = Value(createdAt);
  static Insertable<VoiceNote> custom({
    Expression<int>? id,
    Expression<int>? entryId,
    Expression<String>? audioPath,
    Expression<int>? durationMs,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (audioPath != null) 'audio_path': audioPath,
      if (durationMs != null) 'duration_ms': durationMs,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VoiceNotesCompanion copyWith({
    Value<int>? id,
    Value<int>? entryId,
    Value<String>? audioPath,
    Value<int?>? durationMs,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return VoiceNotesCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      audioPath: audioPath ?? this.audioPath,
      durationMs: durationMs ?? this.durationMs,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VoiceNotesCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('audioPath: $audioPath, ')
          ..write('durationMs: $durationMs, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $EntriesTable entries = $EntriesTable(this);
  late final $EntryImagesTable entryImages = $EntryImagesTable(this);
  late final $VoiceNotesTable voiceNotes = $VoiceNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    entries,
    entryImages,
    voiceNotes,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('entry_images', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('voice_notes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$EntriesTableCreateCompanionBuilder =
    EntriesCompanion Function({
      Value<int> id,
      required DateTime day,
      Value<String> textContent,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$EntriesTableUpdateCompanionBuilder =
    EntriesCompanion Function({
      Value<int> id,
      Value<DateTime> day,
      Value<String> textContent,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$EntriesTableReferences
    extends BaseReferences<_$AppDb, $EntriesTable, Entry> {
  $$EntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntryImagesTable, List<EntryImage>>
  _entryImagesRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.entryImages,
    aliasName: $_aliasNameGenerator(db.entries.id, db.entryImages.entryId),
  );

  $$EntryImagesTableProcessedTableManager get entryImagesRefs {
    final manager = $$EntryImagesTableTableManager(
      $_db,
      $_db.entryImages,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryImagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VoiceNotesTable, List<VoiceNote>>
  _voiceNotesRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.voiceNotes,
    aliasName: $_aliasNameGenerator(db.entries.id, db.voiceNotes.entryId),
  );

  $$VoiceNotesTableProcessedTableManager get voiceNotesRefs {
    final manager = $$VoiceNotesTableTableManager(
      $_db,
      $_db.voiceNotes,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_voiceNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EntriesTableFilterComposer extends Composer<_$AppDb, $EntriesTable> {
  $$EntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> entryImagesRefs(
    Expression<bool> Function($$EntryImagesTableFilterComposer f) f,
  ) {
    final $$EntryImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryImages,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryImagesTableFilterComposer(
            $db: $db,
            $table: $db.entryImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> voiceNotesRefs(
    Expression<bool> Function($$VoiceNotesTableFilterComposer f) f,
  ) {
    final $$VoiceNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.voiceNotes,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VoiceNotesTableFilterComposer(
            $db: $db,
            $table: $db.voiceNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntriesTableOrderingComposer extends Composer<_$AppDb, $EntriesTable> {
  $$EntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntriesTableAnnotationComposer
    extends Composer<_$AppDb, $EntriesTable> {
  $$EntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> entryImagesRefs<T extends Object>(
    Expression<T> Function($$EntryImagesTableAnnotationComposer a) f,
  ) {
    final $$EntryImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryImages,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.entryImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> voiceNotesRefs<T extends Object>(
    Expression<T> Function($$VoiceNotesTableAnnotationComposer a) f,
  ) {
    final $$VoiceNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.voiceNotes,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VoiceNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.voiceNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntriesTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $EntriesTable,
          Entry,
          $$EntriesTableFilterComposer,
          $$EntriesTableOrderingComposer,
          $$EntriesTableAnnotationComposer,
          $$EntriesTableCreateCompanionBuilder,
          $$EntriesTableUpdateCompanionBuilder,
          (Entry, $$EntriesTableReferences),
          Entry,
          PrefetchHooks Function({bool entryImagesRefs, bool voiceNotesRefs})
        > {
  $$EntriesTableTableManager(_$AppDb db, $EntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EntriesCompanion(
                id: id,
                day: day,
                textContent: textContent,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime day,
                Value<String> textContent = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => EntriesCompanion.insert(
                id: id,
                day: day,
                textContent: textContent,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({entryImagesRefs = false, voiceNotesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (entryImagesRefs) db.entryImages,
                    if (voiceNotesRefs) db.voiceNotes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (entryImagesRefs)
                        await $_getPrefetchedData<
                          Entry,
                          $EntriesTable,
                          EntryImage
                        >(
                          currentTable: table,
                          referencedTable: $$EntriesTableReferences
                              ._entryImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).entryImagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (voiceNotesRefs)
                        await $_getPrefetchedData<
                          Entry,
                          $EntriesTable,
                          VoiceNote
                        >(
                          currentTable: table,
                          referencedTable: $$EntriesTableReferences
                              ._voiceNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).voiceNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $EntriesTable,
      Entry,
      $$EntriesTableFilterComposer,
      $$EntriesTableOrderingComposer,
      $$EntriesTableAnnotationComposer,
      $$EntriesTableCreateCompanionBuilder,
      $$EntriesTableUpdateCompanionBuilder,
      (Entry, $$EntriesTableReferences),
      Entry,
      PrefetchHooks Function({bool entryImagesRefs, bool voiceNotesRefs})
    >;
typedef $$EntryImagesTableCreateCompanionBuilder =
    EntryImagesCompanion Function({
      Value<int> id,
      required int entryId,
      required String imagePath,
      Value<int> sortOrder,
    });
typedef $$EntryImagesTableUpdateCompanionBuilder =
    EntryImagesCompanion Function({
      Value<int> id,
      Value<int> entryId,
      Value<String> imagePath,
      Value<int> sortOrder,
    });

final class $$EntryImagesTableReferences
    extends BaseReferences<_$AppDb, $EntryImagesTable, EntryImage> {
  $$EntryImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntriesTable _entryIdTable(_$AppDb db) => db.entries.createAlias(
    $_aliasNameGenerator(db.entryImages.entryId, db.entries.id),
  );

  $$EntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$EntriesTableTableManager(
      $_db,
      $_db.entries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntryImagesTableFilterComposer
    extends Composer<_$AppDb, $EntryImagesTable> {
  $$EntryImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$EntriesTableFilterComposer get entryId {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableFilterComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryImagesTableOrderingComposer
    extends Composer<_$AppDb, $EntryImagesTable> {
  $$EntryImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntriesTableOrderingComposer get entryId {
    final $$EntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableOrderingComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryImagesTableAnnotationComposer
    extends Composer<_$AppDb, $EntryImagesTable> {
  $$EntryImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$EntriesTableAnnotationComposer get entryId {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryImagesTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $EntryImagesTable,
          EntryImage,
          $$EntryImagesTableFilterComposer,
          $$EntryImagesTableOrderingComposer,
          $$EntryImagesTableAnnotationComposer,
          $$EntryImagesTableCreateCompanionBuilder,
          $$EntryImagesTableUpdateCompanionBuilder,
          (EntryImage, $$EntryImagesTableReferences),
          EntryImage,
          PrefetchHooks Function({bool entryId})
        > {
  $$EntryImagesTableTableManager(_$AppDb db, $EntryImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntryImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntryImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntryImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => EntryImagesCompanion(
                id: id,
                entryId: entryId,
                imagePath: imagePath,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int entryId,
                required String imagePath,
                Value<int> sortOrder = const Value.absent(),
              }) => EntryImagesCompanion.insert(
                id: id,
                entryId: entryId,
                imagePath: imagePath,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntryImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$EntryImagesTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$EntryImagesTableReferences
                                    ._entryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EntryImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $EntryImagesTable,
      EntryImage,
      $$EntryImagesTableFilterComposer,
      $$EntryImagesTableOrderingComposer,
      $$EntryImagesTableAnnotationComposer,
      $$EntryImagesTableCreateCompanionBuilder,
      $$EntryImagesTableUpdateCompanionBuilder,
      (EntryImage, $$EntryImagesTableReferences),
      EntryImage,
      PrefetchHooks Function({bool entryId})
    >;
typedef $$VoiceNotesTableCreateCompanionBuilder =
    VoiceNotesCompanion Function({
      Value<int> id,
      required int entryId,
      required String audioPath,
      Value<int?> durationMs,
      Value<int> sortOrder,
      required DateTime createdAt,
    });
typedef $$VoiceNotesTableUpdateCompanionBuilder =
    VoiceNotesCompanion Function({
      Value<int> id,
      Value<int> entryId,
      Value<String> audioPath,
      Value<int?> durationMs,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

final class $$VoiceNotesTableReferences
    extends BaseReferences<_$AppDb, $VoiceNotesTable, VoiceNote> {
  $$VoiceNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntriesTable _entryIdTable(_$AppDb db) => db.entries.createAlias(
    $_aliasNameGenerator(db.voiceNotes.entryId, db.entries.id),
  );

  $$EntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$EntriesTableTableManager(
      $_db,
      $_db.entries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VoiceNotesTableFilterComposer
    extends Composer<_$AppDb, $VoiceNotesTable> {
  $$VoiceNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EntriesTableFilterComposer get entryId {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableFilterComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VoiceNotesTableOrderingComposer
    extends Composer<_$AppDb, $VoiceNotesTable> {
  $$VoiceNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntriesTableOrderingComposer get entryId {
    final $$EntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableOrderingComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VoiceNotesTableAnnotationComposer
    extends Composer<_$AppDb, $VoiceNotesTable> {
  $$VoiceNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$EntriesTableAnnotationComposer get entryId {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VoiceNotesTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $VoiceNotesTable,
          VoiceNote,
          $$VoiceNotesTableFilterComposer,
          $$VoiceNotesTableOrderingComposer,
          $$VoiceNotesTableAnnotationComposer,
          $$VoiceNotesTableCreateCompanionBuilder,
          $$VoiceNotesTableUpdateCompanionBuilder,
          (VoiceNote, $$VoiceNotesTableReferences),
          VoiceNote,
          PrefetchHooks Function({bool entryId})
        > {
  $$VoiceNotesTableTableManager(_$AppDb db, $VoiceNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VoiceNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VoiceNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VoiceNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> audioPath = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VoiceNotesCompanion(
                id: id,
                entryId: entryId,
                audioPath: audioPath,
                durationMs: durationMs,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int entryId,
                required String audioPath,
                Value<int?> durationMs = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
              }) => VoiceNotesCompanion.insert(
                id: id,
                entryId: entryId,
                audioPath: audioPath,
                durationMs: durationMs,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VoiceNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$VoiceNotesTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$VoiceNotesTableReferences
                                    ._entryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VoiceNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $VoiceNotesTable,
      VoiceNote,
      $$VoiceNotesTableFilterComposer,
      $$VoiceNotesTableOrderingComposer,
      $$VoiceNotesTableAnnotationComposer,
      $$VoiceNotesTableCreateCompanionBuilder,
      $$VoiceNotesTableUpdateCompanionBuilder,
      (VoiceNote, $$VoiceNotesTableReferences),
      VoiceNote,
      PrefetchHooks Function({bool entryId})
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$EntriesTableTableManager get entries =>
      $$EntriesTableTableManager(_db, _db.entries);
  $$EntryImagesTableTableManager get entryImages =>
      $$EntryImagesTableTableManager(_db, _db.entryImages);
  $$VoiceNotesTableTableManager get voiceNotes =>
      $$VoiceNotesTableTableManager(_db, _db.voiceNotes);
}
