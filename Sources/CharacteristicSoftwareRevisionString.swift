//
//  CharacteristicSoftwareRevisionString.swift
//  BluetoothMessageProtocol
//
//  Created by Kevin Hoogheem on 8/20/17.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import DataDecoder
import FitnessUnits

/// BLE Software Revision String Characteristic
///
/// The value of this characteristic is a UTF-8 string representing the software revision for the software within the device
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicSoftwareRevisionString: Characteristic {

    public static var name: String {
        return "Software Revision String"
    }

    public static var uuidString: String {
        return "2A28"
    }

    /// Software Revision
    fileprivate(set) public var softwareRevision: String

    public init(softwareRevision: String) {

        self.softwareRevision = softwareRevision

        super.init(name: CharacteristicSoftwareRevisionString.name, uuidString: CharacteristicSoftwareRevisionString.uuidString)
    }

    open override class func decode(data: Data) throws -> CharacteristicSoftwareRevisionString {

        let softwareRevision = data.safeStringValue ?? ""

        return CharacteristicSoftwareRevisionString(softwareRevision: softwareRevision)
    }

    open override func encode() throws -> Data {
        //Not Yet Supported
        throw BluetoothMessageProtocolError.init(.unsupported)
    }
}
