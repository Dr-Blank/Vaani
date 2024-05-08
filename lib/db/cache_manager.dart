import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final imageCacheManager = CacheManager(
  Config(
    'image_cache_manager',
    stalePeriod: const Duration(days: 365 * 10),
    repo: JsonCacheInfoRepository(),
    maxNrOfCacheObjects: 1000,
  ),
);

final apiResponseCacheManager = CacheManager(
  Config(
    'api_response_cache_manager',
    stalePeriod: const Duration(days: 1),
    repo: JsonCacheInfoRepository(),
    maxNrOfCacheObjects: 1000,
  ),
);
