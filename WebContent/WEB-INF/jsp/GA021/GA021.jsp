<%@ page contentType="text/html; charset=Windows-31J"
	 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">

<html>
<head>
	<title>家計簿-RC版　メニュー</title>
</head>

<body>
<center>
<h1>家計簿-RC版  メニュー</h1>

<p>
<%
	request.setCharacterEncoding("Shift_JIS");
	out.println( (String)session.getAttribute("S_NameSsn") + "さんようこそ。");
%>
<!--<form action=../GA031/sign.do method="get" >-->
<form action=../GA031/layoutest.do method="get" >
	<input type="submit" value="家計簿入力" >
</form><br>
<form action=BB.jsp method="get" >
	<input type="submit" value="レビュー" disabled>
</form><br>
<form action=TtleEntry_GA033.jsp method="get" >
	<input type="submit" value="分類登録" >
</form><br>
<form action=CC.jsp method="get" >
	<input type="submit" value="設定" disabled>
</form><br>
<form action=CC.jsp method="get" >
	<input type="submit" value="管理" disabled>
</form><br>
<a href="Logout_GA101.jsp">ログアウト</a>
</center>
</body>
</html>