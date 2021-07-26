import 'dart:async';

import 'in_memory_cacher_impl.dart';

class Cacher {
  final CacherImpl _imp;

  Future<void> init() => _imp.init();

  void dispose() {
    final id = _imp.identifier;
    final refCount = _refCounts[id] ?? 0;

    if (refCount <= 1) {
      _imp.dispose();
      _refCounts.remove(id);
    } else {
      _refCounts[id] = refCount - 1;
    }
  }

  dynamic read(dynamic key) => _imp.read(key);

  Future<void> write(dynamic key, dynamic value) => _imp.write(key, value);

  int get size => _imp.size;

  Cacher(this._imp);

  static final _completers = <String, Completer<Cacher>>{};
  static final _refCounts = <String, int>{};

  static Future<Cacher> getInstance(
    String identifier, {
    int maxSize = 4 * 1024,
  }) async {
    var _completer = _completers[identifier];

    _refCounts[identifier] = (_refCounts[identifier] ?? 0) + 1;

    if (_completer == null) {
      final completer = Completer<Cacher>();
      _completer = completer;
      _completers[identifier] = completer;
      try {
        final cacher = Cacher(InMemoryCacherImpl(identifier, maxSize: maxSize));
        await cacher.init();
        completer.complete(cacher);
      } on Exception catch (e) {
        completer.completeError(e);
        _completer = null;
        return completer.future;
      }
    }

    return _completer.future;
  }
}

abstract class CacherImpl {
  /// Unique identifier of cache
  late String identifier;

  /// Max count of in memory cache (default: 4K)
  late int maxSize;

  /// Initialize cache
  Future<void> init();

  /// Recycle the compute Resource
  void dispose();

  /// Read value from cache
  dynamic read(dynamic key);

  /// Write value to cache
  Future<void> write(dynamic key, dynamic value);
  int get size;
}
