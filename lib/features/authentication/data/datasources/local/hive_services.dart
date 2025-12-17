import 'package:ecommerce/core/error/exception.dart';
import 'package:hive/hive.dart';

class HiveService {
  Future<Box<T>> openBox<T>(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        return Hive.box<T>(boxName);
      }
      return await Hive.openBox<T>(boxName);
    } catch (e) {
      throw CacheException('Failed to open box: $boxName');
    }
  }

  Future<void> put<T>(String boxName, String key, T value) async {
    try {
      final box = await openBox<T>(boxName);
      await box.put(key, value);
    } catch (e) {
      throw CacheException('Failed to save data');
    }
  }

  Future<T?> get<T>(String boxName, String key) async {
    try {
      final box = await openBox<T>(boxName);
      return box.get(key);
    } catch (e) {
      throw CacheException('Failed to retrieve data');
    }
  }

  Future<void> delete(String boxName, String key) async {
    try {
      final box = await openBox(boxName);
      await box.delete(key);
    } catch (e) {
      throw CacheException('Failed to delete data');
    }
  }

  Future<void> clear(String boxName) async {
    try {
      final box = await openBox(boxName);
      await box.clear();
    } catch (e) {
      throw CacheException('Failed to clear box');
    }
  }

  Future<void> deleteBox(String boxName) async {
    try {
      await Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      throw CacheException('Failed to delete box');
    }
  }
}