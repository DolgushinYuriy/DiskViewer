
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${pageContext.request.contextPath}/js/jquery-1.9.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css">
    <title>Просмотр диска</title>
  </head>
  <body>
    <input type="hidden" id="startPath" value="${path}">
    <div class="container">
      <div class="row">
        <br/>
        <div id="viewDisk">
        </div>
      </div>
    </div>
  </body>
</html>

<script>
  $(document).ready(function() {
    try {
      $.ajax({
        url: "viewfolder.htm",
        data: {path: $("#startPath").val()},
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
</script>