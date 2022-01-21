//
//  ModelData.swift
//  XRate
//
//  Created by Alicia Windsor on 22/07/2021.
//

import Foundation

extension ContentView{
    
    public func stringToDate(dateString: String) -> String?{
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let newDate = formatter.date(from: dateString) else{ return nil }
        formatter.dateStyle = .long
        
        let dateAsString = formatter.string(from: newDate)

        print("formatter: \(newDate) : \(dateAsString)")
        return dateAsString

    }

    public func getRates(currency: String, amount: Double){
        
        print(amount)
 
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=\(currency)&places=2&amount=\(amount)")
        else {
            print("URL is invalid")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "ACCEPT")

        let dataTask = URLSession.shared.dataTask(with: request){data, response, error in
            if let data = data {
                do{
                    let ratesResponse = try JSONDecoder().decode(RatesResponse.self, from: data)
                    
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.dateFormat = "yyyy-MM-dd"

                    DispatchQueue.main.async {
                        self.ratesDict = ratesResponse.rates
                        self.ratesDate = stringToDate(dateString: ratesResponse.date) ?? ""
                        
                       /* for rate in ratesDict{
                            self.ratesKeys.append(rate.key)
                        }*/
                                                
                    }
                    
                } catch {
                        print(error)
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
                    print("Error with response: \(response)")
                    return
                }
                
                if let error = error {
                    print("Error Thrown : \(error)")
                    return
                }

            }
            
        }

        dataTask.resume()
        
    }
    
}
