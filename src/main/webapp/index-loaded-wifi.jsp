<%@ page import="org.search.wifi.wifisearch.jdbcController" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>와이파이 정보 구하기</title>
    <script>
        function clickBtn() {
            window.navigator.geolocation.getCurrentPosition(function (position) {
                    var lat = position.coords.latitude;
                    var lng = position.coords.longitude;

                    document.getElementById('target').innerHTML = lat + ", " + lng;
                },
                function (error) {
                    switch (error.code) {
                        case error.PERMISSION_DENIED:
                            str = "사용자 거부";
                            break;
                        case error.POSITION_UNAVAILABLE:
                            str = "지리정보 없음";
                            break;
                        case error.TIMEOUT:
                            str = "시간 초과";
                            break;
                        case error.UNKNOWN_ERROR:
                            str = "알수없는 에러";
                            break;
                    }
                    document.getElementById('target').innerHTML = str;
                });
        }

        var id;

        function clickBtn2() {
            id = navigator.geolocation.watchPosition(function (position) {
                var lat = position.coords.latitude;
                var lng = position.coords.longitude;
                document.getElementById("lat").value = lat;
                document.getElementById("lng").value = lng;
            });
        }

    </script>

    <style>
        @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);

        body {
            font-family: 'Nanum Gothic', sans-serif;
            margin: 0;
            padding: 20px;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        #navi {
            margin-bottom: 20px;
        }

        #navi span {
            margin-right: 15px;
            font-size: 14px;
            color: #333;
            cursor: pointer;
        }

        #navi span:hover {
            text-decoration: underline;
        }

        form {
            margin-bottom: 10px;
        }

        input[type="text"] {
            padding: 5px;
            margin-right: 10px;
            width: 100px;
        }

        input[type="submit"], input[type="button"] {
            background-color: #04AA6D;
            color: white;
            border: none;
            padding: 8px 16px;
            text-align: center;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #45a049;
        }

        #customers {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
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
            padding: 12px;
            background-color: #04AA6D;
            color: white;
            font-weight: bold;
        }
    </style>

    <%!
        org.search.wifi.wifisearch.jdbcController jdbcController = new jdbcController();
        List<jdbcController.WifiData> wifiList;

        {
            try {
                wifiList = jdbcController.selectWifiList();
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    %>
</head>
<body>

<h1>서울시 와이파이 정보구하기</h1>

<div id="navi">
    <span onclick="location.href='index.jsp'">홈</span>
    <span onclick="location.href='history.jsp'">위치 히스토리 목록</span>
    <span onclick="window.open('load-wifi.jsp')">Open API 와이파이 정보 가져오기</span>
</div>

<form action="history-insert.jsp" method="post" target="param" onsubmit="return clickBtn2()" style="float:left;">
    <input type='text' id='lat' name="lat" placeholder='LAT'>
    <input type='text' id='lng' name="lng" placeholder='LNG'>
    <input type='submit' onclick="clickBtn2()" value='내 위치 가져오기'>
</form>

<form style="float:left; margin-left: 20px;">
    <input type='button' onclick="location.href='index-loaded-wifi.jsp'" value='근처 WIFI 정보 보기'>
</form>

<br style="clear:both;">

<iframe id="iframe" name="param" style="display:none"></iframe>

<table id="customers">
    <tr>
        <th>거리(Km)</th>
        <th>관리번호</th>
        <th>지역구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내외구분</th>
        <th>WIFI접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>
    <% for (org.search.wifi.wifisearch.jdbcController.WifiData wifiData : wifiList) { %>
    <tr>
        <td><%=wifiData.DISTANCE%></td>
        <td><%= wifiData.getX_SWIFI_MGR_NO() %></td>
        <td><%= wifiData.getX_SWIFI_WRDOFC() %></td>
        <td><%= wifiData.getX_SWIFI_MAIN_NM() %></td>
        <td><%= wifiData.getX_SWIFI_ADRES1() %></td>
        <td><%= wifiData.getX_SWIFI_ADRES2() %></td>
        <td><%= wifiData.getX_SWIFI_INSTL_FLOOR() %></td>
        <td><%= wifiData.getX_SWIFI_INSTL_TY() %></td>
        <td><%= wifiData.getX_SWIFI_INSTL_MBY() %></td>
        <td><%= wifiData.getX_SWIFI_SVC_SE() %></td>
        <td><%= wifiData.getX_SWIFI_CMCWR() %></td>
        <td><%= wifiData.getX_SWIFI_CNSTC_YEAR() %></td>
        <td><%= wifiData.getX_SWIFI_INOUT_DOOR() %></td>
        <td><%= wifiData.getX_SWIFI_REMARS3() %></td>
        <td><%= wifiData.getLAT() %></td>
        <td><%= wifiData.getLNT() %></td>
        <td><%= wifiData.getWORK_DTTM() %></td>
    </tr>
    <% } %>
</table>

</body>
</html>
