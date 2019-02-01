#if os(macOS)
import Foundation
import CoreGraphics

public class DeviceVideoInput: VideoInputable {

    public var processor: VideoProcessor = VideoProcessor()

    struct MatrixData {
        let first: UInt8
        let second: UInt8
        let third: UInt8
        let fourth: UInt8
    }

    public required init() {
        print("DeviceVideoInput: Init")
    }

    public func start(index: Int, onColor: @escaping (Float, Float, Float) -> Void) {

    }

    public func stop() {

    }

    public func colors(at relativePointClusters: [[RelativePoint]], for inputIndex: Int) -> [[Color]] {
        let imageFromDisplay = CGDisplayCreateImage(CGMainDisplayID())
        return imageFromDisplay?.pixelColors(at: relativePointClusters) ?? [[]]
    }

    public func colorForInput(index: Int) -> Color? {
        guard
            let image = CGDisplayCreateImage(CGMainDisplayID())?.with(scale: 0.05),
            image.alphaInfo == .premultipliedFirst || image.alphaInfo == .first || image.alphaInfo == .noneSkipFirst,
            image.bitmapInfo.rawValue & CGBitmapInfo.byteOrderMask.rawValue == CGBitmapInfo.byteOrder32Little.rawValue,
            let data = image.dataProvider?.data else { return nil }

        let rawData: UnsafePointer<UInt8> = CFDataGetBytePtr(data)
        let width = image.width
        let height = image.height
        let bytesPerRow = image.bytesPerRow
        var dictionary: [String: UInt32] = [:]

        for pointY in 0...height {
            for pointX in 0...width {

                let pixelInfo = pointY * bytesPerRow + pointX * 4

                let red = UInt8(Float(rawData[pixelInfo + 2]) / 8.000)
                let green = UInt8(Float(rawData[pixelInfo + 1]) / 8.000)
                let blue = UInt8(Float(rawData[pixelInfo + 0]) / 8.000)

                let isMoreThanFourteen: Bool = red >= 14 && green >= 14 && blue >= 14
                let isLessThanOne: Bool = red <= 1 && green <= 1 && blue <= 1

                if isMoreThanFourteen || isLessThanOne {
                    //print("Skip White and Black")
                } else {
                    let stringHash: String = "\(red):\(green):\(blue)"
                    //print(stringHash)
                    if let value = dictionary[stringHash] {
                        dictionary[stringHash] = value + 1
                    } else {
                        dictionary[stringHash] = 1
                    }
                }

            }
        }

        let dominant = dictionary.max { $0.value < $1.value }

        if let dominantColor = dominant?.key.components(separatedBy: ":").map({ Int($0) ?? 0 }) {
            return Color(
                red: Float(dominantColor[0]) / 32.000,
                green: Float(dominantColor[1]) / 32.000,
                blue: Float(dominantColor[2]) / 32.000
            )
        }

        return nil
    }

    func incrementedFlatMatrix(with data: [MatrixData]) -> [String: UInt16] {

        var dictionary: [String: UInt16] = [:]
        data.forEach { item in
            let stringHash: String = "\(item.first):\(item.second):\(item.third)"
            if let value = dictionary[stringHash] {
                dictionary[stringHash] = value + 1
            } else {
                dictionary[stringHash] = 1
            }
        }
        return dictionary
    }

}

extension CGImage {

    func pixelColors(at relativePointClusters: [[RelativePoint]]) -> [[Color]] {

        let width = self.width
        let height = self.height

        var colorClusters: [[Color]] = []

        if let pixelData = self.dataProvider?.data {
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

            for relativePointCluster in relativePointClusters {
                var clusterColors: [Color] = []

                for relativePoint in relativePointCluster {

                    let pos = CGPoint(relativePoint, size: CGSize(width: width, height: height))

                    let pixelInfo: Int = ((Int(self.width) * Int(pos.y)) + Int(pos.x)) * 4

                    let red = Float(data[pixelInfo]) / Float(255.0)
                    let green = Float(data[pixelInfo + 1]) / Float(255.0)
                    let blue = Float(data[pixelInfo + 2]) / Float(255.0)
                    //let a = Double(data[pixelInfo+3]) / Double(255.0)

                    let color = Color(red: red, green: green, blue: blue)

                    clusterColors.append(color)
                }
                colorClusters.append(clusterColors)
            }
        }

        return colorClusters
    }

    func with(scale: CGFloat) -> CGImage? {
        let width = CGFloat(self.width) * scale
        let height = CGFloat(self.height) * scale
        let bitsPerComponent = self.bitsPerComponent
        let bytesPerRow = self.bytesPerRow
        let colorSpace = self.colorSpace
        let bitmapInfo = self.bitmapInfo

        if let colorSpace = colorSpace, let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) {
            context.interpolationQuality = .low
            context.draw(self, in: CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(width), height: CGFloat(height))))
            return context.makeImage()
        }
        return nil
    }
}

#endif
