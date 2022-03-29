//
//  CarlculatorBrain.swift
//  Calculator
//
//  Created by Eunsoo KIM on 2022/03/28.
//

import Foundation

class CarlculatorBrain {
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOpertion((Double, Double) -> Double)
        case Equals
    }
    private struct pendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    private var accumulator = 0.0
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(Double.pi), // Double.pi,
        "e": Operation.Constant(M_E), // M_E,
        "√": Operation.UnaryOperation(sqrt), // sqrt,
        "cos": Operation.UnaryOperation(cos), // cos
        "±": Operation.UnaryOperation({ -$0 }),
        "×": Operation.BinaryOpertion({ $0 * $1}),
        "+": Operation.BinaryOpertion({ $0 + $1}),
        "−": Operation.BinaryOpertion({ $0 - $1}),
        "÷": Operation.BinaryOpertion({ $0 / $1}),
        "=": Operation.Equals
    ]
    private var pending: pendingBinaryOperationInfo?
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    func performOperation(symbol: String) {
        if let operation  = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOpertion(let function):
                excutePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                excutePendingBinaryOperation()
            }
        }
    }
    private func excutePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
}
