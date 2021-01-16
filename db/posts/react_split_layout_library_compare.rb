Post.create(
  category_list: "Tech",
  tag_list: "react, javascript",
  title: " Reactのリサイズ可能なスプリットレイアウトライブラリの比較",
  summary: "RaspberryPiのWifiの設定でつまずいたときの解決方法",
  body: <<-EOS
# Reactのリサイズ可能なスプリットレイアウトライブラリの比較

- [Reactのリサイズ可能なスプリットレイアウトライブラリの比較](#reactのリサイズ可能なスプリットレイアウトライブラリの比較)
  - [react-split-pane](#react-split-pane)
    - [react-split-pane Basic](#react-split-pane-basic)
    - [react-split-pane Event](#react-split-pane-event)
    - [react-split-pane Style](#react-split-pane-style)
    - [react-split-pane 所感](#react-split-pane-所感)
  - [react-resize-layout](#react-resize-layout)
    - [react-resize-layout Basic](#react-resize-layout-basic)
    - [react-resize-layout Event](#react-resize-layout-event)
    - [react-resize-layout 所感](#react-resize-layout-所感)
  - [react-splitter-layout](#react-splitter-layout)

## react-split-pane

- [react-split-pane](https://github.com/tomkp/react-split-pane)
スターが一番多いライブラリ。

### react-split-pane Basic

`SplitPaneコンポーネント`に`split props`を与えて、レイアウトを行う。

最小、最大、デフォルト値などの設定が可能であるが、`SplitPaneコンポーネント`で囲われた最初の要素に適応されることに注意。

```jsx
<SplitPane split="horizontal" minSize={10} maxSize={100}>
  <div /> {/* <- この要素に最小サイズと最大サイズが反映される*/}
  <div />
</SplitPane>
```

### react-split-pane Event

`SplitPaneコンポーネント`で囲われた最初の要素のサイズを第一引数から受け取ることができる。
2つ目の要素のサイズを取得したい場合、[component-size](https://github.com/rehooks/component-size)を導入するとよい。

```jsx
<SplitPane split="horizontal" onChange={(pane1Size)=>{console.log(pane1Size)}}>
  <div /> {/* <- この要素のサイズがログに出力される*/}
  <div />
</SplitPane>
```

### react-split-pane Style

`SplitPaneコンポーネント`で囲まれた要素には、自動的に`Paneコンポーネント`でラップされる。

```jsx
{/* コーディング　*/}
<SplitPane split="horizontal" onChange={(pane1Size)=>{console.log(pane1Size)}}>
  <div /> 
  <div />
</SplitPane>

{/* コンパイル */}
<SplitPane split="horizontal" onChange={(pane1Size)=>{console.log(pane1Size)}}>
  <div class="Pane"><div /></div> 
  <div class="Pane"><div /></div>
</SplitPane>
```

この時のスタイルがうまくいかない場合、`pane1Style pane2Style props`を使用して、スタイルのカスタムを行う。

```jsx
<SplitPane
  pane1Style={{backgroundColor: "red"}}
  pane2Style={{backgroundColor: "green"}}
>
  <div class="Pane"><div /></div> {/* red */} 
  <div class="Pane"><div /></div> {/* green */}
</SplitPane>
```

### react-split-pane 所感

二つ目の要素のサイズが取得できないのが不満だが、おそらく一番安定したライブラリなので、とりあえずこれを導入するのがよい。

## react-resize-layout

[react-resize-layout](https://github.com/bytefunc/react-resize-layout)
個人的に使いやすいと感じたが、メンテナンスがされていないライブラリ。

[サンプル](https://codesandbox.io/s/gallant-lewin-6vuyi?file=/src/App.js)

### react-resize-layout Basic

`Resizeコンポーネント`で`ResizeHorizon ResizeVerticalコンポーネント`をラップして使用する

```jsx
<Resize handleWidth="5px" handleColor="#777">
  <ResizeHorizon width="100px">Horizon 1</ResizeHorizon>
    <ResizeHorizon width="200px" minWidth="150px">
      Horizon 2
    </ResizeHorizon>
  <ResizeHorizon minWidth="5px">Horizon 3</ResizeHorizon>
</Resize>
```

### react-resize-layout Event

`Resizeコンポーネント`にイベントを渡す。

| options        |     type | default |       description        |
| -------------- | -------- | ------- | ------------------------ |
| onResizeStart  | callback |         | Calls when resize start  |
| onResizeStop   | callback |         |  Calls when resize stop  |
| onResizeMove   | callback |         |  Calls when resize move  |
| onResizeWindow | callback |         | Calls when window resize |

resize-split-paneより多くのイベントが用意されており、`Resizeコンポーネント`でラップされた要素のサイズをすべて取得することができる。

```jsx
import React from "react";
import { Resize, ResizeVertical, ResizeHorizon } from "react-resize-layout";

export default function App() {
  return (
    <Resize>
      <ResizeHorizon width="300px">Explorer</ResizeHorizon>

      <ResizeHorizon minWidth="5px">
        <Resize>
          <ResizeVertical height="80%">
            <Resize handleWidth="3px">
              <ResizeHorizon width="100px" minWidth="10px">
                Editor
              </ResizeHorizon>

              <ResizeHorizon minWidth="5px">score</ResizeHorizon>
            </Resize>
          </ResizeVertical>

          <ResizeVertical minHeight="5px">footer</ResizeVertical>
        </Resize>
      </ResizeHorizon>
    </Resize>
  );
}
```

### react-resize-layout 所感

react-split-paneより機能が豊富で非常によいと感じた。
しかし、タイプのプルリクを２年近く無視していることや、開発環境によっては`Resizeコンポーネント`で深いネストを行うとエラーが発生する。

[react-resize-layoutを検討してみる](https://github.com/izszzz/stave/issues/22)

動作するのであれば、使用してよいと考える。

## react-splitter-layout

[react-splitter-layout](https://github.com/zesik/react-splitter-layout)

リファレンスが少ないライブラリ。react-split-paneのほうがいいかも。
EOS
)