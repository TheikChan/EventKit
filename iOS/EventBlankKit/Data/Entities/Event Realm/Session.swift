////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Foundation
import RealmSwift
import RxDataSources

public class Session: Object {
    public static let keyBeginTime = "beginTime"
    public static let keyVisible = "visible"

    @objc public dynamic var uuid = UUID().uuidString
    @objc public dynamic var visible = false

    @objc public dynamic var title = ""
    @objc public dynamic var sessionDescription = ""
    
    @objc internal dynamic var beginTime: Date?
    public var date: Date {
        guard let beginTime = self.beginTime else {
            return Date.distantPast
        }
        return beginTime
    }

    @objc public dynamic var lengthInMinutes: Int = 0
    
    @objc public dynamic var track: Track?
    @objc public dynamic var location: Location?
    @objc public dynamic var speaker: Speaker?

    override public class func primaryKey() -> String {
        return "uuid"
    }
}

extension Session: IdentifiableType {
    public var identity: Int {
        return self.isInvalidated ? 0 : uuid.hashValue
    }
}

extension Session {
    var isValid: Bool {
        return !title.isEmpty && visible && beginTime != nil && speaker != nil && track != nil
    }
}
