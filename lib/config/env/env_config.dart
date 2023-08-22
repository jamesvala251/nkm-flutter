enum EnvTypeEnum { dev, prod }

class EnvConfig {
  final EnvTypeEnum envType;
  final String appName;
  final String baseUrl;

  static EnvConfig? _instance;

  EnvConfig._({
    this.envType = EnvTypeEnum.dev,
    this.appName = "NKM LLP-Dev",
    this.baseUrl = "'http://13.126.207.50/api/'",
  });

  factory EnvConfig({
    EnvTypeEnum? envType,
    String? appName,
    String? baseUrl,
  }) {
    _instance ??= EnvConfig._(
      envType: envType!,
      appName: appName!,
      baseUrl: baseUrl!,
    );
    return _instance!;
  }

  static EnvConfig get instance {
    return _instance!;
  }
}
