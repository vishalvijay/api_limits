$redis = Redis::Namespace.new("api_limits", redis: Redis.new)
