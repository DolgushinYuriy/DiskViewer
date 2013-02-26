
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css">
    <title>Просмотр диска</title>
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="span6 offset3">
          <form action="${pageContext.request.contextPath}/pathviewer.htm" method="post" class="form-search well" style="position: absolute; top: 30%;">
            <h1>Просмотр диска</h1>
            <c:if test="${message != null}">
              <div class="alert alert-error">
                <h4>Ошибка!</h4>
                <p>${message}</p>
              </div>
            </c:if>
            <label for="path">Введите начальный путь: </label><input name="path" type="text" placeholder="например c:/" value="" class="input-large search-query">
            <button type="submit" class="btn">Найти</button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
