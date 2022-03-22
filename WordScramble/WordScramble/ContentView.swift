//
//  ContentView.swift
//  WordScramble
//
//  Created by 范三球 on 2022/3/18.
//

import SwiftUI

struct ContentView: View {
    // 输入内容
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    // 分数
    @State private var score = 0
    
    // 弹窗报错内容
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                                .autocapitalization(.none)
                                // 禁用文本字段的大写
                        }
                    }
                }
                Section {
                    Text("\(score)")
                }
            }
            .navigationTitle(rootWord)
            // 当按下输入框的回车时调用`addNewWord`函数
            .onSubmit(addNewWord)
            // 当视图显示时，调用`startGame`函数
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Restart game") {
                        startGame()
                    }
                }
            }
        }
    }
    
    
    
    func addNewWord(){
        // 将输入的内容转换为小写内容，删除空格和换行，以确保不会添加有大小写差异的重复单词
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // 如果输入内容为空
        guard answer.count > 0 else { return }
        // 如果输入内容小于3个字符
        guard answer.utf16.count > 2 else {
            wordError(title: "Word can not shorter than three letters", message: "Be longer than three letters!")
            return
        }
        // 如果输入内容和原内容一样
        guard answer != rootWord else {
            wordError(title: "Word can not same as the rootWrod", message: "Try something new!")
            return
        }
        // 如果单词已经被使用过
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        // 如果单词拼写不正确
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        // 如果单词不是真实存在的
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        // 使用动画在`usedWords`最前面插入`answer`
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += 1
        }
        // 重置输入的内容`newWord`
        newWord = ""
    }
    
    func startGame() {
        // 重置游戏分数
        score = 0
        
        // 1. 找到程序包中名字为`start`，后缀为`txt`的文件
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. 将`start.txt`加载到`String(contentsOf:)`中
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. 将字符串基于换行符`\n`分割成一个字符串数组
                let allWords = startWords.components(separatedBy: "\n")
                // 4. 随机选择一个单词，或者使用“silkworm”作为默认值
                rootWord = allWords.randomElement() ?? "silkworm"
                // 如果成功运行到这里，代表一切都正常
                return
            }
        }

        // 如果运行到这一步，意味着没有找到文件，则程序直接崩溃关闭，使用`fatalError()`函数，不判断任何内容，程序崩溃关闭
        fatalError("Could not load start.txt from bundle.")
    }
    
    // 如果单词已经被使用过
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    // 如果单词拼写不正确
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    // 如果单词不是真实存在的
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    // 调整报错弹窗的文案
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
