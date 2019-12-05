//
//  APIRequest.swift
//  Conviva
//
//  Created by Luma Gabino Vasconcelos on 17/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation

//Tipos de erros possíveis gerados pela API - Resposta HTTP
enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
    case noDataAvailable
    case canNotProcessData
}

struct APIRequest {
    let resourceURL: URL
    
    // Inicializador tem como parametro o endpoint da url
    init(endpoint: String){
        let resourceString = "https://vast-brushlands-94838.herokuapp.com/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    //Método para salvar evento, conexão com método POST da API
    func saveEvent(_ eventToBeSave: Event, completion: @escaping(Result<Event, APIError>) -> Void){
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(eventToBeSave)
            
            // Verifica se houve resposta válida do servidor
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                //Método de decode da classe evento para JSON
                do {
                    let eventData = try JSONDecoder().decode(Event.self, from: jsonData)
                    completion(.success(eventData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    //Método para pegar todos os eventos do server, conexão com método GET da API
    func getAllEvents(completion: @escaping(Result<[Event], APIError>) -> Void){
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "GET"
        
        // Verifica se houve resposata válida do servidor
        let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            //Método de decode da classe evento para JSON
            do {
                let decoder = JSONDecoder()
                let eventsData = try decoder.decode([Event].self, from: jsonData)
                completion(.success(eventsData))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    
    //Metodo POST cadastro de perfil
    func saveProfile(_ profileToBeSave: Profile, completion: @escaping(Result<Profile, APIError>) -> Void){
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(profileToBeSave)
            
            // Verifica se houve resposta válida do servidor
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        let strData = String(data: jsonData, encoding: .utf8)
                        print(strData ?? "Erro de resposta")
                        completion(.failure(.responseProblem))
                        return
                    }
                }
                
                //Método de decode da classe evento para JSON
                do {
                    let profileData = try JSONDecoder().decode(Profile.self, from: jsonData)
                    completion(.success(profileData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    
    //Metodo para login, conexão com metodo GET da API
    func getProfileResponse(completion: @escaping(Result<Profile, APIError>) -> Void){
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "GET"
        
        // Verifica se houve resposata válida do servidor
        let dataTask = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    let strData = String(data: jsonData, encoding: .utf8)
                    print(strData ?? "Erro de resposta")
                    completion(.failure(.responseProblem))
                    return
                }
            }

            //Método de decode da classe evento para JSON
            do {
                let decoder = JSONDecoder()
                let profileData = try decoder.decode(Profile.self, from: jsonData)
                completion(.success(profileData))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }

    

}
