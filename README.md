# thecheat_flutter
[![pub package](https://img.shields.io/pub/v/thecheat_flutter.svg)](https://pub.dev/packages/thecheat_flutter)

금융사기방지 더치트 API를 플러터에서 이용할 수 있게 해주는 플러그인입니다.

## Getting Started

### 의존성

먼저 첫 번째로, `pubspec.yaml`파일에 아래 코드를 작성하여 프로젝트에 본 플러그인을 추가합니다.
```yaml
dependencies:
  thecheat_flutter: ^1.0.0
```

본 플러그인에서는 아래 리스트와 같은 패키지를 사용합니다. 개발을 진행할 떄 참고해주세요.
1. [dio](https://pub.dev/packages/dio) (5.0.0)
1. [encrypt](https://pub.dev/packages/encrypt) (5.0.1)
1. [intl](https://pub.dev/packages/intl) (0.18.0)


### 구현 가이드

먼저 플러그인을 사용하기 위하여, 어플리케이션을 시작함과 동시에 본 플러그인을 초기화 시켜주어야 합니다.
`main.dart` 파일에 아래 코드를 추가해주세요. [더치트 API Center](https://apicenter.thecheat.co.kr/)에서 발급받은 API KEY와 ENC KEY를 initializeApp 함수를 실행할 때 입력해주세요.
```dart
import 'package:thecheat_flutter/thecheat_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  TheCheatFlutterPlugin().initializeApp(
      "YOUR_API_KEY",
      "YOUR_ENCRYPT_KEY"
  );

  runApp(MyApp());
}
```

더치트 피해사례 검색을 구현하는 코드는 다음과 같습니다.
```dart
import 'package:thecheat_flutter/thecheat_flutter.dart';

FraudSearchResponse = await (ThecheatFraudSearch().search(keyword, keywordType))
```


## Author

[@doch13_](https://github.com/doch2)
