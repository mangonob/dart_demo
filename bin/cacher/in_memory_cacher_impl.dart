import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';

import 'cacher.dart';
import 'dcache/dcache.dart';

class InMemoryCacherImpl extends CacherImpl {
  @override
  final String identifier;

  @override
  final int maxSize;

  final int maxDiskCount;

  InMemoryCacherImpl(
    this.identifier, {
    required this.maxSize,
    this.maxDiskCount = 4 * 1024 * 1024,
  });

  late Box<dynamic> _hiveBox;
  late SimpleCache _inMemory;

  @override
  Future<void> init() async {
    _hiveBox = await Hive.openBox(identifier);
    unawaited(_trimHiveBox());

    _inMemory = LruCache(
      storage: InMemoryStorage(maxSize),
      onEvict: onInMemoryEvict,
    );

    for (final key in _hiveBox.keys) {
      _inMemory.set(key, _hiveBox.get(key));
    }
  }

  Future<void> _trimHiveBox() async {
    while (_hiveBox.length > maxDiskCount) {
      await _hiveBox.deleteAt(0);
    }
  }

  /// Reigste some Hive TypeAdapter
  static void registerAdapters(List<TypeAdapter<dynamic>> adapters) {
    for (final adapter in adapters) {
      Hive.registerAdapter(adapter);
    }
  }

  Future<void> onInMemoryEvict(dynamic key, dynamic value) async {
    await _hiveBox.delete(key);
  }

  @override
  void dispose() {
    if (_hiveBox.isOpen) {
      _hiveBox.close();
    }
  }

  @override
  dynamic read(key) {
    final mValue = _inMemory.get(key);
    if (mValue != null) {
      return mValue;
    } else {
      final hValue = _hiveBox.get(key);
      if (hValue != null) {
        _inMemory.set(key, hValue);
        return hValue;
      }
    }
  }

  @override
  Future<void> write(key, value) async {
    _inMemory.set(key, value);
    await _hiveBox.put(key, value);
  }

  @override
  int get size => _inMemory.length;
}
