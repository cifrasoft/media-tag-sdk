//
//  NSMediatagSDK.swift
//  MediatagSDK
//
//  Created by Maksim Mironov on 02.06.2022.
//

import Foundation
public class NSMediatagSDK: NSObject{
  private var mediatagSDK: MediatagSDK!

  @objc public init(configuration: NSConfiguration){
    super.init()
    mediatagSDK = MediatagSDK(configuration: configuration)
  }
  
  @objc public convenience init(cid: String, tms: String!, uid: String?, hid: String?, uidc: NSNumber?) {
    self.init(configuration: NSConfiguration(cid: cid, tms: tms, uid: uid, hid: hid, uidc: uidc))
  }

  @objc public func next(contactType: NSNumber, view: NSNumber?, idc: NSNumber?, idlc: NSString,  fts: Int64,  urlc: NSString,  media: String, ver: NSNumber?) {
    var eventView: EventType? = nil
    if let view = view {
      eventView = EventType(rawValue: Int(truncating: view))
    }
    mediatagSDK.next(Event(contactType: ContactType(rawValue: contactType.intValue), view: eventView, idc: idc as? Int, idlc: idlc as String, fts: fts, urlc: urlc as String, media: media, ver: ver as? Int))
  }

  @objc public func getSendingQueue() -> Array<String>{
    return mediatagSDK.sendingQueue.compactMap {$0}
  }
  
  @objc public func getSendingAbility() -> Bool{
    return mediatagSDK.sendingIsAvailable
  }
  
  @objc public func getUserAttributes() -> NSMutableDictionary  {
    let nsAttributes: NSMutableDictionary = [:]
    mediatagSDK.userAttributes.forEach{
      if let next = $0.first{
        nsAttributes.setObject(next.value, forKey: next.key as NSCopying)
      }
    }
    return nsAttributes
  }
}
