/*:
 - callout(Xcode issue):
 もし以下のようなエラーが出てきた場合は、30秒間ほどこのページを実行するために必要なファイルが全てコンパイルされるまで待ってください。 \
`Playground execution failed: error: Introduction.xcplaygroundpage:11:17: error: use of undeclared type 'SwiftFile'` \
I have filed this bug as [rdar://30999038](rdar://30999038)

 
 # コンパイラの仕組みとは？
 Macはそれ自身ではSwiftのコードは理解できず、とても低級な`add`や`shift`、`branch`といった*アセンブリ*命令のみ実行することができます。すなわちクラスや`if`文ですらMacは知らないのです。

 そのためSwiftのプログラムをMacで実行するにはSwiftをアセンブリのコードに翻訳しなくてはなりません。これを行うプログラムを*コンパイラ*と呼びます。コンパイラはXcodeでプログラムをビルドする際や、Playgroundで`Compiling`とステータスバーに出ている際に毎回実行されています。

 このページではコンパイラがどう動き、どんな過程を経て現代のコンパイラがプログラムのコンパイルをしているのかをインタラクティブに見ていきましょう。

 たとえばこんなSwiftのコードを書いたとします:
 */
let sourceFile: SwiftFile = #fileLiteral(resourceName: "Simple program.swift")
/*: 
 このSwiftのコードをSwiftのコンパイラが*コンパイル*してアセンブリコードにしたものがこのようになります:
 */
do {
    try Compiler.compile(swiftFile: sourceFile)
} catch let error as CompilationError {
    error
}
/*:
 
 * callout(Discover):
 違うSwiftのプログラムに変えてアセンブリがどのように変わるか見てみましょう。

 
 * note:
 コンパイルするファイルを変えるにはsourceFileのところを書き換えましょう。（ダブルクリックで変えられるらしいです）

 [❯ Lexerから始めよう](Lexer)
 
 ---
 */
