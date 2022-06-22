
## Применение
### Запуск
#### Для инициализации SDK используйте `convenience init`

```swift
    NSMediatagSDK  *mediatagSDK   = [[NSMediatagSDK alloc]  initWithCid : @"cid" 
                                                                    tms : @"tms" 
                                                                    uid : @"uid"
                                                                    hid : @"hid" 
                                                                   uidc : @1
    ];
```
  
#### или через объект конфигурации:

```swift
    NSConfiguration *configuration = [[NSConfiguration alloc] initWithCid : @"userCid" 
                                                                      tms : @"tms" 
                                                                      uid : @"uid" 
                                                                      hid : @"hid" 
                                                                     uidc : @1
  ];
  NSMediatagSDK *mediatagSDK = [[NSMediatagSDK alloc] initWithConfiguration: configuration];

```

### Проверка конфигурации
  ```swift
    func getUserAttributes() -> NSMutableDictionary
  ```
### Отправка событий
> все свойства события [см. здесь](https://github.com/cifrasoft/media-tag-sdk/blob/master/Sources/models/Event.swift)
```swift
  [mediatagSDK nextWithContactType : @1
                              view : @2
                               idc : @3
                              idlc : @"idlc"
                               fts : 43234
                              urlc : @"http://event_url.ru?query=query"
                             media : @"media"
                               ver : @36 
  ];
```
- `Sending availability` 
  если запрос не может быть отправлен или отклонен, URL-адрес будет добавлен в `очередь отправки`
  ```swift 
    func getSendingAbility() -> Bool
  ```

  > После восстановления интернет-соединения выполнится попытка отправить запросы из `очереди отправки`, в противном случае отправка ожидающих запросов будет приостановлена.
  
- `Sending queue`
  ```swift
    func getSendingQueue() -> Array<String>
  ```
