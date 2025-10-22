# Servlet / JSP

- [Servlet / JSP](#servlet--jsp)
  - [Init Sample](#init-sample)

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

