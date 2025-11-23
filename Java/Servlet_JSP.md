# Servlet / JSP

- [Servlet / JSP](#servlet--jsp)
  - [作成時の全体的な注意点やコツ](#作成時の全体的な注意点やコツ)
  - [Init Sample](#init-sample)
  - [JSP:開始タグと用途の違い](#jsp開始タグと用途の違い)
  - [booleanでrequiredを表示する](#booleanでrequiredを表示する)
  - [JavaScriptでPOSTしてServletで受ける](#javascriptでpostしてservletで受ける)
  - [Enumで定義して、Enumで生成して、JSPで表示して、Servletで受ける](#enumで定義してenumで生成してjspで表示してservletで受ける)
    - [前提](#前提)
    - [コツ](#コツ)
  - [JSP: 共通化](#jsp-共通化)
    - [実行時（動的）](#実行時動的)
      - [受ける](#受ける)
    - [コンパイル時に生成（静的）](#コンパイル時に生成静的)
  - [プルダウンの共通化のサンプル](#プルダウンの共通化のサンプル)
    - [結論](#結論)
    - [一応整理](#一応整理)
      - [概要](#概要)
      - [一覧](#一覧)
  - [`null`と文字列の「null」を空文字に変換する](#nullと文字列のnullを空文字に変換する)
    - [参考](#参考)
  - [文字コード対応（Filter）](#文字コード対応filter)
  - [RestAPI](#restapi)

## 作成時の全体的な注意点やコツ

- キーの定数宣言は控えめにしたほうが良い。
    - 特に`public static`でキーを宣言するのは無意味・・・というよりマイナス。
    - `public static`宣言したときとしないときで、実装時に注意するポイントと、実装ミスが発覚するポイントが同じ。
        - 「文字列として同じにする必要がある」と、「画面表示のタイミングでしかミスったことが判断できない」という点で、定数宣言しても、ベタ書きしても同じ。
        - 定数宣言したほうが実装量が増えるので、むしろマイナス。
- 共通化するのであれば、Javaに書いたほうが良い？

## Init Sample

- [Servlet_JSP_Tomcat:SampleUser0001:Github](https://sampleuser0001.github.io/Servlet_JSP_Tomcat/)

## JSP:開始タグと用途の違い

- `<%`
    - スクリプト（スクリプトレット）
- `<%@`
    - import、設定
    - `<%@ page="ittimfn.sample.Hoge"%>`
- `<%=`
    - HTMLとして出力する
    - 主に`value='<%=request.getAttribute("hogeKey")/>'`などで使う。
- `<%!`
    - 宣言

## booleanでrequiredを表示する

``` jsp
<%
    boolean isRequired = true;
    request.setAttribute("isRequired", isRequired);
%>
<input type="text" name="username" ${isRequired ? "required" : ""}>
```

## JavaScriptでPOSTしてServletで受ける

- POST
    - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/webapp/form.jsp](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/webapp/form.jsp)
- Servlet
    - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/java/com/example/helloworld/HelloServlet.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/java/com/example/helloworld/HelloServlet.java)

## Enumで定義して、Enumで生成して、JSPで表示して、Servletで受ける

- Enum
    - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/java/ittimfn/sample/tomcat/pulldown/OptionsEnum.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/java/ittimfn/sample/tomcat/pulldown/OptionsEnum.java)
- JSP
    - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/webapp/WEB-INF/index.jsp](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/webapp/WEB-INF/index.jsp)
        - 80行目近辺
- Servlet
    - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/java/ittimfn/sample/tomcat/pulldown/IndexServlet.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/java/ittimfn/sample/tomcat/pulldown/IndexServlet.java)

### 前提

もちろん、これが妥当かは不明。

### コツ

1. 値が`int`の場合は、`String`でも特定できるようにしたほうが良い。`request.getAttribute`の戻り値は`Object`なので、そのままだと`Integer`にキャストしづらい。
2. `getOptionsHTML`メソッドの引数は`Object`にしたほうがいい。理由は上と同じ。
3. `getOptionsHTML`メソッドを作らない場合は、`select`を書く処理をJavaScriptに必要。
    - `hidden`を書いて、それを参照するのが一般的か？
4. `select`の`id`と`name`は同じ値にする。（必須）
5. Javaに渡される値は`null`になる可能性があるので、`null`が渡されたら空文字に変換する処理がほしい。

## JSP: 共通化

### 実行時（動的）

``` jsp
<!-- jsp:paramがないとき -->
<jsp:include page="ファイルパス" />

<!-- jsp:paramがある時 -->
<jsp:include page="ファイルパス">
    <!-- 渡せるのはStringのみ -->
    <jsp:param key="key" value="value" />
</jsp:include>

<!-- この実装はNG。 -->
<jsp:include page="ファイルパス">
</jsp:include>
```

#### 受ける

``` jsp
<%
    // Servletから渡されるときと同じ
    String value = request.getAttribute("key");
%>

```

### コンパイル時に生成（静的）

``` jsp
<%@include file="ファイルパス" %>
```

## プルダウンの共通化のサンプル

- [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/tree/main/jsp_include_param](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/tree/main/jsp_include_param)

### 結論

もう一回やってみたが、[Enumで定義して、Enumで生成して、JSPで表示して、Servletで受ける](#Enumで定義して、Enumで生成して、JSPで表示して、Servletで受ける)で良くない？

- [Enumで定義して、Enumで生成して、JSPで表示して、Servletで受ける](#Enumで定義して、Enumで生成して、JSPで表示して、Servletで受ける)
- [jsp_include_param_rendered_02](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/tree/main/jsp_include_param/variants/jsp_include_param_rendered_02)
    - JSP(呼ぶ側)
        - [index.jsp](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/variants/jsp_include_param_rendered_02/src/main/webapp/WEB-INF/index.jsp)
    - Enum(Optionを生成する)
        - [OptionsEnum01.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/variants/jsp_include_param_rendered_02/src/main/java/ittimfn/sample/includejsp/enums/OptionsEnum01.java)
        - [OptionsEnum02.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/variants/jsp_include_param_rendered_02/src/main/java/ittimfn/sample/includejsp/enums/OptionsEnum02.java)
    - Servlet
        - [IndexServlet.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/variants/jsp_include_param_rendered_02/src/main/java/ittimfn/sample/includejsp/IndexServlet.java)


### 一応整理

#### 概要

- `select`(プルダウン)を生成するための値を`Model`に詰めて渡す。  
- `Model`に詰める値は`enum`で定義。  
- `pulldown.jsp`を呼び出す際のキーとして下記を設定。
    - `pulldown.key`
        - `pulldown.jsp`がServletから渡された値（`Model`）を受けるためのキー。
        - **重要 : jsp:paramで渡せるのはStringだけ。Modelは渡せない。**
    - `onchange`
        - プルダウンメニューが変更されたときに実行されるJavaScriptの関数。
        - 中身は`POST`用 JavaScript。

**ちょっと複雑すぎる気がする。**

#### 一覧

- 呼ばれる側
    - pulldown本体
        - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/webapp/WEB-INF/common/pulldown.jsp](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/webapp/WEB-INF/common/pulldown.jsp)
    - POST用 JavaScript
        - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/webapp/WEB-INF/common/submit.js](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/webapp/WEB-INF/common/submit.js)
- 呼ぶ側
    - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/webapp/WEB-INF/index.jsp](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/webapp/WEB-INF/index.jsp)
- Java
    - JSPが参照するためのModel
        - `select`用
            - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/models/PulldownModel.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/models/PulldownModel.java)
        - `option`(つまり要素)用
            - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/models/PulldownOptionModel.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/models/PulldownOptionModel.java)
    - Modelに詰めるための値
        - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/enums/OptionsEnum01.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/enums/OptionsEnum01.java)
        - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/enums/OptionsEnum02.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/enums/OptionsEnum02.java)
    - Servlet
        - [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/IndexServlet.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/jsp_include_param/src/main/java/ittimfn/sample/includejsp/IndexServlet.java)



## `null`と文字列の「null」を空文字に変換する

``` java
public static final String nullToEmpty(String str) {
    return str == null || str.equals("null") ? "" : str;
}
```

### 参考

- [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/java/ittimfn/sample/tomcat/pulldown/Util.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/pulldown/src/main/java/ittimfn/sample/tomcat/pulldown/Util.java)



## 文字コード対応（Filter）

- [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/java/com/example/helloworld/CharacterEncodingFilter.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/java/com/example/helloworld/CharacterEncodingFilter.java)

## RestAPI

- [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/rest_api/src/main/java/ittimfn/sample/restapi/IndexServlet.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/rest_api/src/main/java/ittimfn/sample/restapi/IndexServlet.java)