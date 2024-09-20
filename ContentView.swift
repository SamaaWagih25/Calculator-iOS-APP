//
//  ContentView.swift
//  Calculator
//
//  Created by Samaa Wagih on 20/09/2024.
//

import SwiftUI

//Creating an enum
//List of all different button types
//String Cases
enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case percent = "%"
    case decimal = "."
    case negative = "-/+"
    
    //Controlling the buttons colors
    //Writing a Switch Case
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .divide, .multiply:
            return .orange
        
        case .clear, .negative, .percent:
            return Color(.lightGray)
            
        default:
            return .pink

        }
    }
}

enum Operation {
    case add, subtract, divide, multiply, none
    
}

//This is on the view of the calculator
struct ContentView: View {
    
    //A state property wrapper (controlling the various states of the view as things automatically change)
    @State var value = "0"
    
    //A state for the running number
    @State var runningNumber = 0
    
    //Current operation that the user is doing
    @State var currentOperation: Operation = .none
    
    //Creating a 2D Array of the buttons
    //Adding all buttons to the UI
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
        
        
    ]
    var body: some View {
        ZStack {
            
            //setting black background color
            Color.black.edgesIgnoringSafeArea(.all)
            
            //Creating a vertical stack
            VStack{
                Spacer()
                //Text Display
                HStack{
                    //setting the text to the right
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 90))
                        .foregroundColor(.white)
                }
                //Padding added for better alignment
                .padding()
                
                //Buttons
                ForEach(buttons, id: \.self){ row in
                    
                    //Wrapping the numbers in a horizontal stack
                    HStack (spacing: 12) {
                        ForEach(row, id: \.self){ item in
                            Button(action: {self.didTap(button: item)}, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 34))
                                //Order of parameters is width and height
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight(item: item)
                                        )
                                //calling the buttonColor function created above
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                //cornerRadius() for a circular shape
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
        }
    }
    
    
    //functionalities
    //Tapping function (whether a user taps a number or taps on an operator)
    func didTap(button: CalcButton){
        //Creating a switch case function
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            //addition
            if button == .add {
                self.currentOperation = .add
                //incrementing the current number
                self.runningNumber = Int (self.value) ?? 0
            }
            //subtraction
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int (self.value) ?? 0
            }
            
            //multiplication
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int (self.value) ?? 0
            }
            
            //division
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int (self.value) ?? 0
            }
            
            //equal
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
                
            }
            
            //if button does not equal "="
            if button != .equal {
                self.value = "0"
            }
            
        //clears the current operation to 0 when (AC) is pressed
        case .clear:
            self.value = "0"
        
        case .decimal, .negative, .percent:
            break
            
        //The number's fnctionality
        default:
            let number = button.rawValue
            if self.value == "0" { //it checks if the current number is 0
                value = number //If true, it sets value to the number from the button (overwriting "0").
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    //Creating functionalities of the buttons (Hard-coding)
    //Button's width
    func buttonWidth(item: CalcButton) -> CGFloat {
        //Upsizing the zero's button width
        if item == .zero {
            return (UIScreen.main.bounds.width - (4*12))/4 * 2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    
    //Creating a function for the button's height
    func buttonHeight(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
