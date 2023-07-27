//
//  protocol.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 20/06/2023.
//

protocol ConfigurableCell {
    associatedtype DataType
    func configure(with data: DataType)
}
