# Servlet / JSP

- [Servlet / JSP](#servlet--jsp)
  - [Init Sample](#init-sample)
  - [booleanでrequiredを表示する](#booleanでrequiredを表示する)
  - [JavaScriptでPOSTしてServletで受ける](#javascriptでpostしてservletで受ける)
  - [Enumで定義して、Enumで生成して、JSPで表示して、Servletで受ける](#enumで定義してenumで生成してjspで表示してservletで受ける)
    - [前提](#前提)
    - [コツ](#コツ)
  - [`null`と文字列の「null」を空文字に変換する](#nullと文字列のnullを空文字に変換する)
    - [参考](#参考)
  - [文字コード対応（Filter）](#文字コード対応filter)

## Init Sample

- [Servlet_JSP_Tomcat:SampleUser0001:Github](https://sampleuser0001.github.io/Servlet_JSP_Tomcat/)

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
4. `select`の`id`と`name`は同じ値にする。（必須）
5. Javaに渡される値は`null`になる可能性があるので、`null`が渡されたら空文字に変換する処理がほしい。

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