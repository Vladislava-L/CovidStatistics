//
//  statisticsViewController.swift
//  CovidStatistics
//
//  Created by l.vladislava on 14/02/2021.
//

import UIKit
import Gloss

class  statisticsViewController: UIViewController {
    
    var items: [Item] = []

    @IBOutlet weak var statisticsTextLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Countries statistics "
    }

    @IBAction func getDataTapped(_ sender: Any) {
        handleGetData()
    }
    
    func handleGetData(){
        
        let jsonUrl = "https://covid-193.p.rapidapi.com/statistics"
        
        guard let url = URL(string: jsonUrl) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.setValue("59b3812235mshb07d4cda3265843p14ec7ejsnf037aaf8629e", forHTTPHeaderField: "x-rapidapi-key")
        urlRequest.setValue("covid-193.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//        urlRequest.setValue( true , forHTTPHeaderField: "useQueryString")
        
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) {(data, response, error) in
            
            if let err = error {
                print("error: \(err.localizedDescription)")
            }
            
            guard let data = data else {
                print("Data error!")
                return
            }
            
            do{
                if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("dictData", dictData)
                    self.populateData(dictData)
                }
                
            }catch{
                print("err when converting JSON")
            }
            
        }
        task.resume()
        
    }
    
    func populateData(_ dict: [String: Any]){
        guard let responseDict = dict["response"] as? [Gloss.JSON] else {
            return
            
        }
        
        items = [Item].from(jsonArray: responseDict) ?? []
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension statisticsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "covidCell", for: indexPath)
    
        
        cell.textLabel?.text = items[indexPath.row].country
        cell.detailTextLabel?.text = "0"
        
        return cell
    }
    
     
}

