//
//  MasterViewController.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

protocol EmailSelectionDelegate: class {
  func didSelectEmailCell(_ email: Email?)
}

class MasterViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    weak var delegate: EmailSelectionDelegate?
    private var viewModel: MasterViewModel!
    private var dataSource: MasterDataSource?
   
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewModel()
        self.setupTableView()
        self.configureDetailController()
    }
    
    
    // MARK: -  Initializations and Deallocations
    static func instantiate(_ viewModel: MasterViewModel) -> MasterViewController {
        let controller = MasterViewController.instantiateViewController()
        controller.viewModel = viewModel
        
        return controller
    }
    
    
    // MARK: - Public methods
    public func firstEmail() -> Email? {
        return viewModel.emails.first
    }
    
    
    // MARK: - Private methods
    private func setupTableView() {
        dataSource = viewModel.dataSource(with: self.tableView)
        tableView?.register(cellClass: EmailCellTo.self)
        tableView?.register(cellClass: EmailCellFrom.self)
        tableView?.register(cellHeaderClass: EmailHeaderView.self)
        tableView?.dataSource = dataSource
        tableView?.delegate = self
        tableView?.tableFooterView = UIView()
    }
    
    private func setupViewModel()  {
        let emails = ParserEmail.parse().data
        viewModel = MasterViewModel(emails: emails)
    }
    
    private func configureDetailController() {
        let detailViewController: DetailViewController? = cast(splitViewController?.viewControllers.last)
        detailViewController?.viewModel?.updateEmail(viewModel.emails.first)
        delegate?.didSelectEmailCell(viewModel.emails.first)
    }
    
    private func removeEmail(_ email: Email) {
        let indexPath = viewModel.indexPath(for: email)
        viewModel.removeEmail(email)
        tableView.reloadData()
        
        if let _ = delegate as? DetailViewController {
            delegate?.didSelectEmailCell(viewModel.nextEmail(for: indexPath))
        }
    }
    
    private func selectedCell(at: IndexPath) {
        if let detailViewController = delegate as? DetailViewController {
           splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.viewModel.email(at: at).map {
                self.delegate?.didSelectEmailCell($0)
            }
        }
    }
}

extension MasterViewController: EmailApproveDelegate {
    func approve(_ email: Email) {
        self.removeEmail(email)
    }
    
    func reject(_ email: Email) {
        self.removeEmail(email)
    }
}

extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EmailHeaderView") as? EmailHeaderView
        
        return  dataSource?.configureHeader(cell, for: section)
    }
}

