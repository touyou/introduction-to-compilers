/*:
 # Parser
 
 ソースコードをトークン列に変換した後は、これを*Parser*が*抽象構文木（AST）*というものに変換します。これは木構造でソースコードを表したものになっており、ライブビューに表示されているような構造になっています。
 */
let sourceFile: SwiftFile = #fileLiteral(resourceName: "Simple program.swift")
/*:
 * callout(Discover):
 ASTを見るためにはライブビューを有効にしてください。
 

 * note:
 以下では`else`が実装されていないため、"Program with else"はコンパイルできません。

 以下でシンプルにしたSwiftコンパイラの中で`if`がどのように変換されるか見てみましょう:
 */
class MyParser: Parser {
    override func parseIfStatement() throws -> Statement {
        // 次のトークンが`if`であるかどうかチェックし、違うならエラーを吐きます。
        guard nextToken == .if else {
            throw CompilationError(sourceRange: nextToken.sourceRange,
                                   errorMessage: "Expected 'if' but saw \(nextToken)")
        }
        // `if`のキーワードが出て来るソースコードの位置を保存します。
        // これはこの後エラーメッセージに利用します。
        let ifRange = nextToken.sourceRange
        // 見るトークンの位置をずらして次のトークンが見られるようにします。
        try consumeToken()
        // if文の条件文を変換します。
        let condition = try parseExpression()
        // if文の本体を変換します。
        let body = try parseBraceStatement()

        let elseBody: BraceStatement? = nil
        let elseRange: SourceRange? = nil

        // #-----------------------------------#
        // # ここにelse文の変換処理が入ります。      #
        // #-----------------------------------#

        // 最後にif文の構造を返します。
        return IfStatement(condition: condition,
                           body: body,
                           elseBody: elseBody,
                           ifRange: ifRange,
                           elseRange: elseRange,
                           sourceRange: range(startingAt: ifRange.start))
    }
}
/*:
 このコードでは`else`の部分が無いままになっていることに注意してください。

 * callout(Experiment):
 `else`の部分を`if`と同じように書いてみましょう。 \
"Program with else"をコンパイルして正しく動作することを確かめてください。

 [解答例を見る](ParserSolution)

 ソースコードがASTに変換された後、ASTには*型検査*が行われます。これによって整数に文字を足そうとする`5 + "abc"`やメソッドを間違った型の引数で呼び出そうとするようなコードをはじくことが出来ます。型検査をクリアした場合、コンパイラは次の段階に移ります

 [❮ Lexerに戻る](Lexer)

 [❯ IR Generationに進む](IRGeneration)
 
 ---
 */
// Setup for the live view
import PlaygroundSupport
PlaygroundPage.current.liveView = ASTExplorer(forSourceFile: sourceFile, withParser: MyParser())
