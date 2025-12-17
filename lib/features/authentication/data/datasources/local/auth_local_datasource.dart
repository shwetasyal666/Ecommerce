
import 'package:ecommerce/core/constant/hive_constant.dart';
import 'package:ecommerce/core/error/exception.dart';
import 'package:ecommerce/features/authentication/data/datasources/local/hive_services.dart';

import '../../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<void> cacheAuthToken(String token);
  Future<String?> getAuthToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hiveService;

  AuthLocalDataSourceImpl(this.hiveService);

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await hiveService.put(
        HiveConstants.userBox,
        HiveConstants.currentUserKey,
        user,
      );
    } catch (e) {
      throw CacheException('Failed to cache user');
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final user = await hiveService.get<UserModel>(
        HiveConstants.userBox,
        HiveConstants.currentUserKey,
      );
      return user;
    } catch (e) {
      throw CacheException('Failed to get cached user');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await hiveService.delete(
        HiveConstants.userBox,
        HiveConstants.currentUserKey,
      );
      await hiveService.delete(
        HiveConstants.userBox,
        HiveConstants.authTokenKey,
      );
    } catch (e) {
      throw CacheException('Failed to clear cache');
    }
  }

  @override
  Future<void> cacheAuthToken(String token) async {
    try {
      await hiveService.put(
        HiveConstants.userBox,
        HiveConstants.authTokenKey,
        token,
      );
    } catch (e) {
      throw CacheException('Failed to cache token');
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      return await hiveService.get<String>(
        HiveConstants.userBox,
        HiveConstants.authTokenKey,
      );
    } catch (e) {
      throw CacheException('Failed to get auth token');
    }
  }
}