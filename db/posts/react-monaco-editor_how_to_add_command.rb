Post.create(
  category_list: "Tech",
  tag_list: "react, javascript",
  title: "react-monaco-editorでaddCommandを使う",
  summary: "react-monaco-editorでaddCommandを使うときの注意点",
  body: <<-EOS
# react-monaco-editorでaddCommandを使う

[react-monaco-editor(github)][1]

- [react-monaco-editorでaddCommandを使う](#react-monaco-editorでaddcommandを使う)
  - [はじめに](#はじめに)
  - [editorDidMountの問題](#editordidmountの問題)
  - [解決策](#解決策)

## はじめに

react-monaco-editorをFunctional Componentで使用した際に起きた問題と解決方法を記載する。

## editorDidMountの問題

今回の問題は、monaco-editorに`Ctrl+S`コマンドを追加してセーブ機能を追加する際に起きた。

```js
const [editorText, setEditorText] = useState("")

const editorDidMount = (editor)=> {
  editor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.Key_S, ()=>{
    console.log(editorText)　//ファイルにエディターのテキストの内容を保存
  })
}
return(
  <MonacoEditor
    onChange={setEditorText} //エディターが更新されるたびにeditorTextを更新する
    editorDidMount={editorDidMount} //　マウントされた時、addCommandをする。
  />
)
```

これで、MonacoEditorにテキストを入力し`Ctrl+S`を押すと空文字が返される。
原因は、editorDidMountがstateやpropsの変更を検知せず、更新しないからである。
`Ctrl+S`を押す度、ステートの初期値が返されている。
命名規則からも、クラスコンポーネントをもとに作られた関数なので更新されない。

## 解決策

Hooksでは以下のように行う。

```js
const editorRef = useRef(null)
const [editorText, setEditorText] = useState("")

useEffect(() => {
  const editor = editorRef.current?.editor;
  editor.addCommand(
    monaco.KeyMod.CtrlCmd | monaco.KeyCode.KEY_S,
    console.log(editoText)
  );
}, [editorText]);// editorTextが更新されるたびにアップデート

return(
  <MonacoEditor
    ref={editorRef}
    onChange={setEditorText} 
  />
)
```

これで、editoTextが更新されるたびにuseEffectが発火し、editorTextが最新の状態でaddCommandに渡されるようになる

[1]:https://github.com/react-monaco-editor/react-monaco-editor
EOS
)