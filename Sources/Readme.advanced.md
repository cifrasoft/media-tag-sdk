
## Применение

Вы должны создать объект конфигурациий с реализацией протокола `ConfigurationType`

  ```swift
    final class SDKConfiguration: ConfigurationType{

      var cid: String! = "example_com"
      
      var hid: String? = "27fa89c8-e7af-435d-b0b7-0dd2b17b3fa7"
      
      var uid: String? = nil
      
      var idc: Int? = nil
      
      var uidc: Int?  = 2

    }
  ```
### Настройка параметров конфигурации по умолчанию:
Протокол ConfigurationTyp eнаследуется от [RequestConfiguration](https://github.com/cifrasoft/media-tag-sdk/blob/master/Sources/models/Configuration.swift)
> Вы можете переопределить методы построения URL-адреса

- `baseUrl` (базовая реализация):
  ```swift
    var baseUrl: URL {
      return URL(string: "https/tns-counter.ru/e/msdkev")!
    }
  ```
  > не забывайте '/' в конце хоста или в начале пути, иначе запрос будет отклонен

- `toQuery()` 
  преобразовать конфигурацию в Dictionary<String, Any?> для [инициализации](https://github.com/cifrasoft/media-tag-sdk#check-configuration) элементов базового url
  ```swift
    func toQuery() -> [[String: Any?]] {}
  ```

- `mapQuery` 
  измените элементы запроса URL-адреса перед отправкой запроса по адресу `только при инициализации url`:
  ```swift
    func mapQuery(query: [[String: Any?]]) -> [URLQueryItem] {}
  ```

   - [x] для прроверки
   - [x] фильтрации
   - [x] добавления кастомных параметров
   
- `urlReplacingOccurrences`
  заменяет все вхождения key в url на value
  ```swift
      var urlReplacingOccurrences: [String: String] 
  ```
  по умолчанию для baseUrl : ["msdkev/?": "msdkev/"] для оптимизации работы сервера
  
### Запуск
```swift
  let mediatagSDK = MediatagSDK(configuration: config)
```
  
### Подготовка запроса
```swift
  // MARK: - PluginType Implementation
  struct SDKPlugin :PluginType {
    func prepare(_ request: URLRequest) -> URLRequest {
      ///  some request modification code
      return request
    }
  }

  let mediatagSDK = MediatagSDK(configuration: config, plugins: [SDKPlugin()])
  
```
