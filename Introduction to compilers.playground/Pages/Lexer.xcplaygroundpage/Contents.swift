/*:
 # Lexer

 コンピュータにとって、ソースコードは文字の羅列でしかありません。

 コードの構造を理解するために、まずは*Lexer*というものをつかって文字列をトークンに変えてあげます。トークンというのは`if`というキーワードや`"hello world"`といった文字のリテラルのことを指します。これらのトークンはブラケットや識別子、演算子などのようなカテゴリーに分類されます。

 * callout(Discover):
 ライブビューのソースコードにマウスをホバーしてそれぞれがどのようなトークンになっているか見てみましょう。 \
違うファイルも選択して様々なトークンをみてください。

 
 * note:
 ライブビューが有効になっていることを確認しましょう。

 */
let sourceFile: SwiftFile = #fileLiteral(resourceName: "Simple program.swift")
/*:
 [❮ イントロダクションに戻る](Introduction)

 [❯ Parserに進む](Parser)
 
 ---
 */
// Setup for the live view
import PlaygroundSupport
PlaygroundPage.current.liveView = TokensExplorer(forSourceFile: sourceFile)
