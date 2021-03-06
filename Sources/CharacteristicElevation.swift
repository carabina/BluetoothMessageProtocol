//
//  CharacteristicElevation.swift
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

/// BLE Elevation Characteristic
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicElevation: Characteristic {

    public static var name: String {
        return "Elevation"
    }

    public static var uuidString: String {
        return "2A6C"
    }

    /// Elevation
    fileprivate(set) public var elevation: Measurement<UnitLength>

    public init(elevation: Measurement<UnitLength>) {

        self.elevation = elevation

        super.init(name: CharacteristicElevation.name, uuidString: CharacteristicElevation.uuidString)
    }

    open override class func decode(data: Data) throws -> CharacteristicElevation {

        var decoder = DataDecoder(data)

        let meters = Double(decoder.decodeInt24()) * 0.01

        let elevation: Measurement = Measurement(value: meters, unit: UnitLength.meters)

        return CharacteristicElevation(elevation: elevation)
    }

    open override func encode() throws -> Data {
        //Not Yet Supported
        throw BluetoothMessageProtocolError.init(.unsupported)
    }

}

