//
//  RingBuffer.swift
//  MediatagSDK
//
//  Created by Maksim Mironov on 18.05.2022.
//
/*
 Based on the original article
 @author: Matthijs Hollemans
 @link: http://raywenderlich.github.io/swift-algorithm-club/Ring%20Buffer/
*/
import Foundation

public struct RingBuffer<T> {

  public typealias BufferTarget = (item: T?, at: Int)

  fileprivate var readIndex = 0
  fileprivate var writeIndex = 0
  fileprivate let arraySize: Int!
  fileprivate var array: [T?]

  public var state: [T] {
    return array.compactMap { $0 }
  }

  public init(count: Int) {
    array = [T?](repeating: nil, count: count)
    arraySize = count
  }

  mutating func insert(items: [T]) {
    let withCount = items.count
    if withCount > 0 {
      items.forEach {
        self.write($0)
      }
    }
  }

  public mutating func write(_ element: T) {
    array[writeIndex % array.count] = element
    writeIndex = increment(target: writeIndex)
  }

  public mutating func clear(atIndex: Int) {
    array[atIndex] = nil
    readIndex = increment(target: readIndex)
  }

  public mutating func read() -> BufferTarget? {
    if !isEmpty {
      let nextIndex = readIndex % array.count
      let element = array[nextIndex]
      return (item: element, at: nextIndex)
    } else {
      return nil
    }
  }

  fileprivate func increment(target: Int) -> Int {
    let next = target + 1
    let goToStart = next > arraySize
    return goToStart ? 0 : next
  }

  fileprivate var availableSpaceForReading: Int {
    return writeIndex - readIndex
  }

  public var isEmpty: Bool {
    return availableSpaceForReading == 0
  }

  fileprivate var availableSpaceForWriting: Int {
    return arraySize - availableSpaceForReading
  }

  public var isFull: Bool {
    return availableSpaceForWriting == 0
  }
}
