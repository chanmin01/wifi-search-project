<%@ page import="java.util.ArrayList" %>
<%@ page import="org.search.wifi.wifisearch.jdbcController" %>
<%@ page import="org.search.wifi.wifisearch.WifiApiFetch" %>
<%@ page import="static org.search.wifi.wifisearch.WifiApiFetch.loadWifiObjectList" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <title>WIFI LOAD</title>
    <%!
        ArrayList<WifiApiFetch.WifiData> data;

        {
            try {
                data = loadWifiObjectList();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String num; %>

    <%
        try {
            num = Integer.toString(jdbcController.createRawTables(data));
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    %>
</head>
<body>
<h1> <%=num %>개의 와이파이를 불러왔습니다.</h1>

</body>
</html>