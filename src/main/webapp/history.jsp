<%@ page import="java.util.List" %>
<%@ page import="org.search.wifi.wifisearch.jdbcController" %>
<%@ page import="org.search.wifi.wifisearch.jdbcController.UserHistory" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <script>
    function sendData() {
      location.reload(true);
    }
  </script>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>문서</title>
  <style>
    #customers {
      font-family: Arial, Helvetica, sans-serif;
      border-collapse: collapse;
      width: 100%;
    }

    #customers td, #customers th {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: center;
    }

    #customers tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    #customers tr:hover {
      background-color: #ddd;
    }

    #customers th {
      padding-top: 12px;
      padding-bottom: 12px;
      text-align: center;
      background-color: #4CAF50;
      color: white;
    }
  </style>
  <%!
    jdbcController jdbcController = new jdbcController();
    List<org.search.wifi.wifisearch.jdbcController.UserHistory> historyList;

    {
      try {
        historyList = jdbcController.selectUserHistory();
      } catch (ClassNotFoundException e) {
        throw new RuntimeException(e);
      }
    }
  %>
</head>
<body>
<h1>위치 히스토리 목록</h1>

<table id="customers">
  <thead>
  <tr>
    <th>ID</th>
    <th>X좌표</th>
    <th>Y좌표</th>
    <th>조회일시</th>
    <th>비고</th>
  </tr>
  </thead>
  <tbody>
  <% for (UserHistory uh : historyList) { %>
  <tr>
    <td><%= uh.getId() %></td>
    <td><%= uh.getHistX() %></td>
    <td><%= uh.getHistY() %></td>
    <td><%= uh.getCol() %></td>
    <td>
      <form action="history-delete.jsp" name='delForm' method="post" target="param2" onsubmit="sendData()">
        <input type='text' id='delID' name="delID" style="display: none" value='<%=uh.getId() %>'/>
        <input type='submit' id='del' onclick="window.location.reload()" name="deleteButton" value='삭제'/>
      </form>
    </td>
  </tr>
  <% } %>
  </tbody>
</table>
<iframe id="iframe" src="history-delete.jsp" name="param2" style="display:none"></iframe>

</body>
</html>
