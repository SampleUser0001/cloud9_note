# Servlet / JSP

- [Servlet / JSP](#servlet--jsp)
  - [Init Sample](#init-sample)
  - [booleanでrequiredを表示する](#booleanでrequiredを表示する)
  - [JavaScriptでPOSTしてServletで受ける](#javascriptでpostしてservletで受ける)
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

## 文字コード対応（Filter）

- [https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/java/com/example/helloworld/CharacterEncodingFilter.java](https://github.com/SampleUser0001/Servlet_JSP_Tomcat/blob/main/use_el/tomcat-helloworld/src/main/java/com/example/helloworld/CharacterEncodingFilter.java)