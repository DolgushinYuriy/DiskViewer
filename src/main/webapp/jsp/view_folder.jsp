
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<style>
  .mainFolder, .folder {
    cursor: pointer;
  }
</style>

<a class="btn" href="${pageContext.request.contextPath}/home.htm" title="Вернуться на стартовую страницу">На стартовую страницу</a>
<div id="tableView" style="overflow: auto;">
  <table class="table table-bordered table-condensed table-striped">
    <thead>
    <th class="span1">#</th>
    <th>Имя</th>
    <th class="span2">Размер</th>
    <th class="span3">Последняя модификация файла</th>
    </thead>
    <tbody>
      <tr class="error pathFolder">
        <td><i class="icon-folder-open" rel="tooltip" data-placement="right" title="Текущая папка"></i></td>
        <td class="tdPathFolder">${path}</td>
        <td></td>
        <td></td>
      </tr>
      <c:if test="${parent != null}">
        <tr class="success mainFolder">
          <td><i class="icon-arrow-right" rel="tooltip" data-placement="right" title="Вернуться на уровень выше"></i></td>
          <td>...</td>
          <td></td>
          <td></td>
        </tr>
      </c:if> 
      <c:forEach items="${folders}" var="folder">
        <tr class="info folder">
          <td><i class="icon-folder-close" rel="tooltip" data-placement="right" title="Папку можно открыть"></i></td>
          <td class="tdFolder">${folder}</td>
          <td></td>
          <td></td>
        </tr>
      </c:forEach>
      <c:forEach items="${files}" var="file">
        <tr class="warning file">
          <td><i class="icon-file"></i></td>
          <td>${file['name']}</td>
          <td>${file['size']} Bytes</td>
          <td>${file['date']}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<script>
  $(document).ready(function() {
    $("#tableView").css("height", $(window).height() - 80);

    $(".icon-folder-close").tooltip();
    $(".icon-arrow-right").tooltip();
    $(".icon-folder-open").tooltip();
    
    $(".folder").click(function() {
      var pathAll = $("td.tdPathFolder").html() + $("td.tdFolder", this).html();

      try {
        $.ajax({
          url: "viewfolder.htm",
          data: {path: pathAll},
          type: "POST",
          cache: false,
          global: false,
          dataType: "html",
          timeout: 60000,
          success: function(answer){
            $("#viewDisk").html(answer);
          }
        });
      } catch(ex) {
        alert("Error: " + ex)
      }
    })

    $(".mainFolder").click(function() {
      try {
        $.ajax({
          url: "viewfolderup.htm",
          data: {path: $("td.tdPathFolder").html()},
          type: "POST",
          cache: false,
          global: false,
          dataType: "html",
          timeout: 60000,
          success: function(answer){
            if(null != answer && answer != "") {
              $("#viewDisk").html(answer);
            }
          }
        });
      } catch(ex) {
        alert("Error: " + ex)
      }
    })
  }) 
</script>