//
//  CharacteristicRestingHeartRate.swift
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

/// BLE Resting Heart Rate Characteristic
///
/// Lowest Heart Rate a user can reach
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicRestingHeartRate: Characteristic {

    public static var name: String {
        return "Resting Heart Rate"
    }

    public static var uuidString: String {
        return "2A92"
    }

    /// Resting Heart Rate
    private(set) public var heartRate: Measurement<UnitCadence>


    public init(heartRate: UInt8) {

        self.heartRate = Measurement(value: Double(heartRate), unit: UnitCadence.beatsPerMinute)

        super.init(name: CharacteristicRestingHeartRate.name, uuidString: CharacteristicRestingHeartRate.uuidString)
    }

    open override class func decode(data: Data) throws -> CharacteristicRestingHeartRate {

        var decoder = DataDecoder(data)

        let heartRate: UInt8 = decoder.decodeUInt8()

        return CharacteristicRestingHeartRate(heartRate: heartRate)
    }

    open override func encode() throws -> Data {
        var msgData = Data()

        msgData.append(Data(from: UInt8(heartRate.value)))

        return msgData
    }
}
