//
//  CharacteristicBodySensorLocation.swift
//  BluetoothMessageProtocol
//
//  Created by Kevin Hoogheem on 8/5/17.
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

/// BLE Body Sensor Location Characteristic
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicBodySensorLocation: Characteristic {

    public static var name: String {
        return "Body Sensor Location"
    }

    public static var uuidString: String {
        return "2A38"
    }

    public enum BodyLocation: UInt8 {
        case other      = 0
        case chest      = 1
        case wrist      = 2
        case finger     = 3
        case hand       = 4
        case earLobe    = 5
        case foot       = 6

        public var stringValue: String {

            switch self {
            case .other:
                return "Other"
            case .chest:
                return "Chest"
            case .wrist:
                return "Wrist"
            case .finger:
                return "Finger"
            case .hand:
                return "Hand"
            case .earLobe:
                return "Ear Lobe"
            case .foot:
                return "Foot"
            }
        }
    }

    fileprivate(set) public var sensorLocation: BodyLocation

    public init(sensorLocation: BodyLocation) {

        self.sensorLocation = sensorLocation

        super.init(name: CharacteristicBodySensorLocation.name, uuidString: CharacteristicBodySensorLocation.uuidString)
    }

    open override class func decode(data: Data) throws -> CharacteristicBodySensorLocation {

        var decoder = DataDecoder(data)

        let location = BodyLocation(rawValue: decoder.decodeUInt8()) ?? .other

        return CharacteristicBodySensorLocation(sensorLocation: location)
    }

    open override func encode() throws -> Data {
        //Not Yet Supported
        throw BluetoothMessageProtocolError.init(.unsupported)
    }
}
