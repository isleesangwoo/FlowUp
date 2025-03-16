<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%
   String ctxPath = request.getContextPath();
%>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>에러 발생</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f4f4f4;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        h1 {
            color: #ff6b6b;
            font-size: 48px;
        }
        p {
            color: #333;
            font-size: 18px;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>😢 Oops!</h1>
        <p>요청하신 페이지를 찾을 수 없습니다.</p>
        <%-- <p><b>에러 코드:</b> <%= request.getAttribute("statusCode") %></p>
        <p><b>메시지:</b> <%= request.getAttribute("errorMessage") %></p> --%>
        <a href="<%= ctxPath%>">메인 페이지로 이동</a>
    </div>
</body>
</html>