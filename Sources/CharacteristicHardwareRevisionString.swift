//
//  CharacteristicHardwareRevisionString.swift
//  BluetoothMessageProtocol
//
//  Created by Kevin Hoogheem on 8/19/17.
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

/// BLE Hardware Revision String Characteristic
///
/// The value of this characteristic is a UTF-8 string representing the hardware revision for the hardware within the device
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicHardwareRevisionString: Characteristic {

    public static var name: String {
        return "Hardware Revision String"
    }

    public static var uuidString: String {
        return "2A27"
    }

    /// Hardware Revision
    fileprivate(set) public var hardwareRevision: String

    public init(hardwareRevision: String) {

        self.hardwareRevision = hardwareRevision

        super.init(name: CharacteristicHardwareRevisionString.name, uuidString: CharacteristicHardwareRevisionString.uuidString)
    }

    open override class func decode(data: Data) throws -> CharacteristicHardwareRevisionString {

        let hardwareRevision = data.safeStringValue ?? ""

        return CharacteristicHardwareRevisionString(hardwareRevision: hardwareRevision)
    }

    open override func encode() throws -> Data {
        //Not Yet Supported
        throw BluetoothMessageProtocolError.init(.unsupported)
    }
}

