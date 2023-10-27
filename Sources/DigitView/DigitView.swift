//
//  DigitView.swift
//
//  Created by Kristian Kiraly on 8/8/23.
//

import SwiftUI

public struct DigitView: View {
    public var digit:Character
    public var color:Color
    public var offColor:Color
    
    public var gapPercentage:Double = 0.1
    public var thicknessPercentage:Double = 0.2
    
    public init(digit: Character, color: Color, offColor: Color, gapPercentage: Double = 0.1, thicknessPercentage: Double = 0.2) {
        self.digit = digit
        self.color = color
        self.offColor = offColor
        self.gapPercentage = gapPercentage
        self.thicknessPercentage = thicknessPercentage
    }
    
    public var body: some View {
        GeometryReader { geo in
            DigitBar() //top
                .frame(width: horizontalBarWidth(size: geo.size), height: barThickness(size: geo.size))
                .position(
                    x: geo.size.width * 0.5,
                    y: 0 + barThickness(size: geo.size) * 0.5
                )
                .foregroundColor(topColor)
            DigitBar() //top left
                .frame(width: barThickness(size: geo.size), height: verticalBarHeight(size: geo.size))
                .position(
                    x: barThickness(size: geo.size) * 0.5,
                    y: (geo.size.height * 0.25) + centerpointVerticalOffsetForTopVerticalBars(size: geo.size)
                )
                .foregroundColor(topLeftColor)
            DigitBar() //top right
                .frame(width: barThickness(size: geo.size), height: verticalBarHeight(size: geo.size))
                .position(
                    x: geo.size.width - (barThickness(size: geo.size) * 0.5),
                    y: (geo.size.height * 0.25) + centerpointVerticalOffsetForTopVerticalBars(size: geo.size)
                )
                .foregroundColor(topRightColor)
            DigitBar() //middle
                .frame(width: horizontalBarWidth(size: geo.size), height: barThickness(size: geo.size))
                .position(
                    x:geo.size.width * 0.5,
                    y:geo.size.height * 0.5
                )
                .foregroundColor(middleColor)
            DigitBar() //bottom left
                .frame(width: barThickness(size: geo.size), height: verticalBarHeight(size: geo.size))
                .position(
                    x: barThickness(size: geo.size) * 0.5,
                    y: (geo.size.height * 0.75) + centerpointVerticalOffsetForBottomVerticalBars(size: geo.size)
                )
                .foregroundColor(bottomLeftColor)
            DigitBar() //bottom right
                .frame(width: barThickness(size: geo.size), height: verticalBarHeight(size: geo.size))
                .position(
                    x: geo.size.width - (barThickness(size: geo.size) * 0.5),
                    y: (geo.size.height * 0.75) + centerpointVerticalOffsetForBottomVerticalBars(size: geo.size)
                )
                .foregroundColor(bottomRightColor)
            DigitBar() //bottom
                .frame(width: horizontalBarWidth(size: geo.size), height: barThickness(size: geo.size))
                .position(
                    x: geo.size.width * 0.5,
                    y: geo.size.height - barThickness(size: geo.size) * 0.5
                )
                .foregroundColor(bottomColor)
        }
    }
    
    private func colorForSet(possibleDigits:[Character]) -> Color {
        if possibleDigits.contains(digit) {
            return color
        }
        return offColor
    }
    
    private var topColor:Color {
        colorForSet(possibleDigits: ["2", "3", "5", "6", "7", "8", "9", "0"])
    }
    
    private var topLeftColor:Color {
        colorForSet(possibleDigits: ["4", "5", "6", "8", "9", "0"])
    }
    
    private var topRightColor:Color {
        colorForSet(possibleDigits: ["1", "2", "3", "4", "7", "8", "9", "0"])
    }
    
    private var middleColor:Color {
        colorForSet(possibleDigits: ["2", "3", "4", "5", "6", "8", "9", "-"])
    }
    
    private var bottomLeftColor:Color {
        colorForSet(possibleDigits: ["2", "6", "8", "0"])
    }
    
    private var bottomRightColor:Color {
        colorForSet(possibleDigits: ["1", "3", "4", "5", "6", "7", "8", "9", "0"])
    }
    
    private var bottomColor:Color {
        colorForSet(possibleDigits: ["2", "3", "5", "6", "8", "9", "0"])
    }
    
    private func horizontalBarWidth(size:CGSize) -> CGFloat {
        //we want the width minus 1/2 barThickness on each side, so subtract slightly more than one full barThickness to have some small gap between corners of bars (in this case, 10% of the thickness)
        (size.width - barThickness(size: size)) - (barThickness(size: size) * gapPercentage)
    }
    
    private func verticalBarHeight(size:CGSize) -> CGFloat {
        //we want 1/2 the view height (for vertical bars, since there are two) minus slightly more than 1/2 the barThickenss on each vertical axis (in this case, 10% of the thickness to match the horizontal bars)
        ((size.height - barThickness(size: size)) * 0.5) - (barThickness(size: size) * gapPercentage)
    }
    
    private func barThickness(size:CGSize) -> CGFloat {
        let smallerDimension = min(size.width, size.height)
        return smallerDimension * thicknessPercentage
    }
    
    private func centerpointVerticalOffsetForTopVerticalBars(size:CGSize) -> CGFloat {
        //barThickness * 0.5 * 0.5 -> we want to offset the bar from the top of the screen by half its thickness, but since we're using position rather than offset we need to cut that in half again so we don't overshoot the target
        barThickness(size: size) * 0.5 * 0.5
    }
    
    private func centerpointVerticalOffsetForBottomVerticalBars(size:CGSize) -> CGFloat {
        //Just invert the offset since we're offsetting from the bottom now
        centerpointVerticalOffsetForTopVerticalBars(size: size) * -1.0
    }
}


fileprivate struct DigitBar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let taller = rect.size.height > rect.size.width
        let smallerDimension = min(rect.size.width, rect.size.height)
        let amountToOffset = smallerDimension * 0.5
        
        if taller {
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - amountToOffset))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + amountToOffset))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + amountToOffset))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - amountToOffset))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        } else {
            path.move(to: CGPoint(x: rect.minX + amountToOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - amountToOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX - amountToOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + amountToOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX + amountToOffset, y: rect.minY))
        }
        

        return path
    }
}
