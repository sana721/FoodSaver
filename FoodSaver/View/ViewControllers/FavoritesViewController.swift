//
//  FavoritesViewController.swift
//  FoodSaver
//
//  Created on 17/11/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var viewModel = FoodViewModel() {
        didSet {
            viewModel.favoriteFoods.bind { (food) in
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NSLocalizedString("Favorites", comment: "Favorites")
        navigationController?.navigationBar.sizeToFit()
        
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: .main), forCellReuseIdentifier: "FoodTableViewCell")
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "Screen Title") as Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadAllFavoriteFoodItems()
        tableView.reloadData()
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBAction func onTapfilter(_ sender: UIBarButtonItem) {
        showFilter()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.favoriteFoods.value.count
        if count > 0 {
            tableView.backgroundView = nil
            return count
        } else {
            tableView.backgroundView = Utilities.noRecordLabel()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell") as? FoodTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.dataSource = self
        let food = viewModel.favoriteFoods.value[indexPath.row]
        cell.food = food
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = viewModel.favoriteFoods.value[indexPath.row]
        if let vc = storyboard?.instantiateViewController(identifier: "FoodDetailsViewController") as? FoodDetailsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.food = food
        }
    }
}

extension FavoritesViewController: FoodTableViewCellDelegate, FoodTableViewCellDataSource {
    func didSelectedFavorite(cell:FoodTableViewCell, favorite: Bool, food: Food) {
        viewModel.addToFavorites(add: favorite, food: food)
        viewModel.loadAllFavoriteFoodItems()
        tableView.reloadData()
    }
    
    func didLikeFood(cell:FoodTableViewCell, food: Food) {
        viewModel.addLike(food: food)
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didUnlikeFood(cell:FoodTableViewCell, food: Food) {
        viewModel.addUnlike(food: food)
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func isFoodFavorate(food: Food) -> Bool {
        return viewModel.isFoodFavorite(food: food)
    }
}

fileprivate extension FavoritesViewController {
    func showFilter() {
        let alert = UIAlertController(title: NSLocalizedString("Filter", comment: "Filter"), message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("All", comment: "All"), style: .default , handler:{ (UIAlertAction)in
            self.viewModel.applyFilter(filter: .all)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Veg", comment: "Veg"), style: .default , handler:{ (UIAlertAction)in
            self.viewModel.applyFilter(filter: .veg)
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("Non-Veg", comment: "Non-Veg"), style: .default , handler:{ (UIAlertAction)in
            self.viewModel.applyFilter(filter: .nonveg)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler:{ (UIAlertAction)in
            
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}
