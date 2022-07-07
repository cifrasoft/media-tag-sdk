//
//  SendService.swift
//  MediatagSDK
//
//  Created by Maksim Mironov on 17.05.2022.
//

import Foundation

final class SendService {

  var baseQueryItems: [[String: Any]] = [[:]]
  var sendingQueue: RingBuffer<String>!
  var sendingIsAvailable: Bool = true
  var clientConfiguration: ConfigurationType!

  private let lock = NSRecursiveLock()
  private var hasFullinformation = false
  private var timer: Timer?

  init(configuration: ConfigurationType) {
    setConfiguration(configuration: configuration)
    self.sendingQueue = RingBuffer(count: clientConfiguration.sendingQueueBufferSize)
  }

  func sendNext(event: Event) {
    if !hasFullinformation {
      setConfiguration(configuration: clientConfiguration)
    }
    let nextQueryDictionary = extendQuery(join: event.toQuery())
    let queryItems = clientConfiguration.mapQuery(query: nextQueryDictionary)

    guard var stringUrl = clientConfiguration.baseUrl.appending(queryItems)?.absoluteString else {
      return
    }

    if clientConfiguration.urlReplacingOccurrences.count > 0 {
      for (spChar, repl) in clientConfiguration.urlReplacingOccurrences {
        stringUrl = stringUrl.replacingOccurrences(of: spChar, with: repl, options: .literal, range: nil)
      }
    }

    guard sendingIsAvailable else {
      write(url: stringUrl)
      return
    }
    sendEvent(url: stringUrl) { [weak self] success, url in
      if !success {
        self?.write(url: url)
      }
    }
  }

  func sendFromQueue() {
    guard sendingIsAvailable, !sendingQueue.isEmpty else {return}
    while sendingIsAvailable && !sendingQueue.isEmpty {
      lock.with { [weak self] in
        guard
          let target = sendingQueue.read(),
          let url = target.item
        else {
          return
        }
        sendEvent(url: url) { [weak self] success, _ in
          if !success {return}
          self?.sendingQueue.clear(atIndex: target.at)
        }
      }
    }
  }

  private func setConfiguration(configuration: ConfigurationType) {
    self.clientConfiguration = configuration
    let depaultPackage = DefaultPackageData()
    baseQueryItems = depaultPackage.initBaseQuery(join: clientConfiguration.toQuery())
    hasFullinformation = depaultPackage.hasFullinformation
  }

  private func write(url: String) {
    lock.with { [weak self] in
      self?.sendingQueue.write(url)
    }
  }

  private func sendEvent(url: String, completion: Action? = nil) {
    var service = RequestService()
    service.plugins = clientConfiguration.plugins ?? []
    let nextUrl = url + "&\(QueryKeys.tsc.rawValue)=\(Date().getCurrentTimeStamp())"

    service.sendRequest(request: URLRequest(url: URL(string: nextUrl)!)) { success in
      completion?(success, url)
    }
  }

  private func extendQuery(join with: [[String: Any?]] ) -> [[String: Any?]] {
    return baseQueryItems + with
  }
}
