//
//  SearchViewSetupUtility.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 19/06/2023.
//

import UIKit

class SearchViewSetupUtility {
    static func setupUI(for searchBarView: UIView, textFieldSearch: UITextField, searchButton: UIButton) {
        setupSearchBarView(searchBarView)
        setupTextField(textFieldSearch)
        setupSearchButton(searchButton)
    }

    private static func setupSearchBarView(_ searchBarView: UIView) {
        searchBarView.layer.cornerRadius = searchBarView.bounds.height / 2
    }

    private static func setupTextField(_ textFieldSearch: UITextField) {
        textFieldSearch.layer.cornerRadius = textFieldSearch.bounds.height / 2
        textFieldSearch.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldSearch.bounds.height))
        textFieldSearch.leftViewMode = .always
        textFieldSearch.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldSearch.bounds.height))
        textFieldSearch.rightViewMode = .always
    }

    private static func setupSearchButton(_ searchButton: UIButton) {
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2
        searchButton.clipsToBounds = true
    }
}
