/*:
 # Parserの練習問題の解答例
 
 `elseBody`と`elseRange`を`let`から`var`に書き換えてelseの部分を以下のように解答例となります。:
 
 - 次のトークンが`else`であることを確認する。 (`nextToken == .else`)
 - もしあっていれば`else`のトークンの範囲を保存しておく。 (`elseRange = nextToken.sourceRange`)
 - `else`のトークンの次のトークンに進む。 (`try consumeToken()`)
 - 本体の部分を変換して保存する。 (`elseBody = try parseBraceStatement()`)
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

        // ================================== //

        var elseBody: BraceStatement? = nil
        var elseRange: SourceRange? = nil

        // 次のトークンが`else`であることを確認する
        if nextToken == .else {
            // elseのトークンの位置を保存する。
            elseRange = nextToken.sourceRange
            // 次のトークンに進む。
            try consumeToken()
            // else文の本体を変換する。
            elseBody = try parseBraceStatement()
        }

        // ================================== //

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
 [❮ Parserに戻る](Parser)

 */
