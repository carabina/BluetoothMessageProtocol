//
//  CharacteristicSupportedInclinationRange.swift
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

/// BLE Supported Inclination Range Characteristic
///
/// The Supported Inclination Range characteristic is used to send the supported inclination range as well as the minimum inclination increment supported by the Server
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicSupportedInclinationRange: Characteristic {

    public static var name: String {
        return "Supported Inclination Range"
    }

    public static var uuidString: String {
        return "2AD5"
    }

    /// Minimum Inclination
    private(set) public var minimum: Measurement<UnitPercent>

    /// Maximum Inclination
    private(set) public var maximum: Measurement<UnitPercent>

    /// Minimum Increment
    private(set) public var minimumIncrement: Measurement<UnitPercent>


    public init(minimum: Measurement<UnitPercent>, maximum: Measurement<UnitPercent>, minimumIncrement: Measurement<UnitPercent>) {

        self.minimum = minimum
        self.maximum = maximum
        self.minimumIncrement = minimumIncrement

        super.init(name: CharacteristicSupportedInclinationRange.name, uuidString: CharacteristicSupportedInclinationRange.uuidString)
    }

    open override class func decode(data: Data) throws -> CharacteristicSupportedInclinationRange {

        var decoder = DataDecoder(data)

        let minValue = Double(decoder.decodeInt16()) * 0.1
        let minimum = Measurement(value: minValue, unit: UnitPercent.percent)

        let maxValue = Double(decoder.decodeInt16()) * 0.1
        let maximum = Measurement(value: maxValue, unit: UnitPercent.percent)

        let incrValue = Double(decoder.decodeUInt16()) * 0.1
        let minimumIncrement = Measurement(value: incrValue, unit: UnitPercent.percent)

        return CharacteristicSupportedInclinationRange(minimum: minimum, maximum: maximum, minimumIncrement: minimumIncrement)
    }

    open override func encode() throws -> Data {
        var msgData = Data()

        let minValue = Int16(minimum.value * (1 / 0.1))
        let maxValue = Int16(maximum.value * (1 / 0.1))
        let incrValue = UInt16(maximum.value * (1 / 0.1))

        msgData.append(Data(from: minValue.littleEndian))
        msgData.append(Data(from: maxValue.littleEndian))
        msgData.append(Data(from: incrValue.littleEndian))

        return msgData
    }
}
