//
//  PickGenreViewController.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 19/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class GenrePickerViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var genrePickerView: UIPickerView!
    
    var delegate: GenrePickerViewControllerDelegate?
    
    var genres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GenrePickerViewController.handleTapGesture(sender:))))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showTranslucentBackground(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideTranslucentBackground()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        didSelectedAGenre()
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        let touch = sender.location(ofTouch: 0, in: contentView)
        if touch.y < 0 {
            didSelectedAGenre()
        }
    }

    private func didSelectedAGenre() {
        let selectedIndex = genrePickerView.selectedRow(inComponent: 0)
        let selectedGenre = genres[selectedIndex]
        delegate?.didSelect(genre: selectedGenre)
        backToInitialView()
    }
    
    private func backToInitialView() {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension GenrePickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row].name
    }
    
}


// MARK: - Setup functions
extension GenrePickerViewController {
    
    private func setupPickerView() {
        genrePickerView.delegate = self
        genrePickerView.dataSource = self
        
        TmdbService().listGenres { (allGenres) in
            if let allGenres = allGenres {
                self.genres = allGenres
                self.genres.append(Genre.myList)
                self.genrePickerView.reloadComponent(0)
                if let selected = self.delegate?.didAlreadySelected() {
                    let row: Int = allGenres.firstIndex(of: selected) ?? 0
                    self.genrePickerView.selectRow(row, inComponent: 0, animated: false)
                }
            }
        }
    }
    
}


// MARK: - Animating functions
extension GenrePickerViewController {
    
    private func showTranslucentBackground(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.view.backgroundColor = ColorPalette.dark.color.withAlphaComponent(0.5)
            }
        }
        else {
            self.view.backgroundColor = ColorPalette.dark.color.withAlphaComponent(0.5)
        }
    }
    
    private func hideTranslucentBackground() {
        self.view.backgroundColor = ColorPalette.dark.color.withAlphaComponent(0.0)
    }
    
}
