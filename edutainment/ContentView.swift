//
//  ContentView.swift
//  edutainment
//
//  Created by Lanre ESAN on 03/04/2020.
//  Copyright © 2020 tomisinesan.com. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

   var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    let screenSize: CGRect = UIScreen.main.bounds
    @State private var val = 1
    @State private var answer = ""
    @State private var determinant = 0
    @State private var  number = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    @State private var score = 0
    @State private var range = 0
    @State private var isShowing = false
    
    var body: some View {
        NavigationView {
           Form {
                Section (header: Text("settings")){
                    
                    VStack(alignment:.center, spacing:50.0){
                      /*  GridStack(rows: 5, columns: 5) { row, col in
                            Button(action: {
                                let a = ((row)*(col))
                                print(a)
                                self.action(a)
                     
                        }){
                        Text("\((row+1)*(col+1))")}.frame(width:50.0).background(Color.purple).foregroundColor(.white).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1.0)).padding(5)
                             
                            //Text("R\((row+1)*(col+1))").padding(5)
                        }
                        */
                         VStack {
                        ForEach(0..<5, id: \.self) { row in
                               HStack {
                                    ForEach(0..<5, id: \.self) { column in
                                        Button(action: {
                                                                      let a = ((row+1)*(column+1))
                                                                      //print(a)
                                                                      self.action(a)
                                                           
                                                              }){
                                                            Text("\((row+1)*(column+1))")}.frame(width:50.0).background(Color.purple).foregroundColor(.white).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1.0)).padding(5)
                                    }
                                }
                            }
                        }
                        
                        
                        Stepper("Number of Questions : \(val)",value:$val,in: 1...5,step: 1).padding(15)
                        
                    }.frame(width: screenSize.width, height: screenSize.height/3)
                }
                
                
                Section (header: Text("settings")){
                    VStack(alignment: .leading, spacing: 40.0) {
                        HStack(alignment:.center, spacing:30.0) {
                    
                        Text("\(number[range]) x \(determinant)").foregroundColor(.black).font(.title).multilineTextAlignment(.center).padding(10.0)
                        TextField("Answer", text:$answer, onCommit:solution).padding(10.0)
                        }
                        
                        Text("score is \(score) and you have \(val-range) more trial(s) ")
                    }.frame(width: screenSize.width, height: screenSize.height/3).padding(10.0)
            }
           }.navigationBarTitle("Edutainment").alert(isPresented: $isShowing){
            Alert(title: Text("Edutainment"),message: Text("Your score is \(score)"), dismissButton: .default(Text("Restart"), action: reStart) )
            }
    }
}
    
    func action(_ numb:Int) -> Void {
        determinant = numb
    }
    
    func shuffle() {
            if(val - range > 1){
                range+=1
            }
           else{
            isShowing = true
             }
    }
    
    func solution(){
        if ((number[range] * determinant) == Int(answer) ){
            score+=1
        }
        shuffle()
    }
    
    func reStart(){
        val = 1
        answer = ""
        determinant = 0
        score = 0
        range = 0
        isShowing = false
        number.shuffle()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
