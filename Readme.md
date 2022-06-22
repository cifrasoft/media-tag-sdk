
# MediatagSDK
Мы хотели бы собирать анонимную информацию о действиях пользователя в Интернете для статистического анализа. 

данный фреймворк дает вам возможность :
- устанавливать конфигурацию отправителя
  > сгенерировать и закэшировать «базовый набор» параметров отправки, необходимых для подсчета статистики
- отправлять [Event](https://github.com/miromax21/miromaxPod/blob/master/Sources/models/Event.swift/) с пользовательскими данными
- автоматическое управление передачей данных на сервер

## Установка

### CocoaPods

```rb
  pod 'MediatagSDK'
```

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) - инструмент для распространения кода Swift, интегрированный в swiftкомпилятор.

После того, как вы настроили свой пакет Swift, добавьте EventSDK в зависимости от качества так просто, как добавьте его к dependenciesвашему же файлу Package.swift.

```swift
  dependencies: [
      .package(url: "https://github.com/miromax21/miromaxPod.git", .upToNextMajor(from: "0.1.1"))
  ]
```
> Эта статья об интеграции в `swift`, если вы хотите использовать `Objective-C`, вам [сюда](https://github.com/miromax21/miromaxPod/blob/master/Sources/NS/Readme.ns.md)

В любом файле, в котором вы хотите использовать MediatagSDK, не забудьте `import MediatagSDK`.

## Применение
### Запуск
```swift
  let mediatagSDK = MediatagSDK(cid: "cid", tms: "tms", uid: "uid", hid: "hid", uidc: 3123)
```
> пример расширенной конфигураций  [здесь](https://github.com/miromax21/miromaxPod/blob/master/Sources/Readme.advanced.md)
#### Проверка базовых аттрибутов
  ```swift
    var userAttributes:  [[String: Any?]]
    // mediatagSDK.userAttributes -> [[String: Any?]] 
  ```

### Отправка событий
> все события [см. здесь](https://github.com/miromax21/miromaxPod/blob/master/Sources/models/Event.swift)
```swift
  let event = Event(contactType: .undefined, view: .start)
  mediatagSDK.next(event)
```

- `Sending availability` 
  если запрос не может быть отправлен или отклонен, URL-адрес будет добавлен в [очередь сообщений](https://github.com/miromax21/miromaxPod#sending-queue) 
  ```swift 
    var sendingIsAvailable: Bool
  ```

  > After the internet connection is restored  the requests from the `sending queue` will try to resume, otherwise the sending of pending requests will be suspended
  > После восстановления интернет-подключения запросы от сервера `sending queue` будут возобновлены,иначе отправка ожидающих отправки запросов будет приостановлена.
  
- `Sending queue`
  ```swift
    var sendingQueue: [String?]
    // mediatagSDK.sendingQueue -> [String?]
  ```
  
