<%@ page contentType="text/html; charset=Windows-31J"
	 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">

<html>
<head>
	<title>�ƌv��-RC�Ł@���j���[</title>
</head>

<body>
<center>
<h1>�ƌv��-RC��  ���j���[</h1>

<p>
<%
	request.setCharacterEncoding("Shift_JIS");
	out.println( (String)session.getAttribute("S_NameSsn") + "����悤�����B");
%>
<!--<form action=../GA031/sign.do method="get" >-->
<form action=../GA031/layoutest.do method="get" >
	<input type="submit" value="�ƌv�����" >
</form><br>
<form action=BB.jsp method="get" >
	<input type="submit" value="���r���[" disabled>
</form><br>
<form action=TtleEntry_GA033.jsp method="get" >
	<input type="submit" value="���ޓo�^" >
</form><br>
<form action=CC.jsp method="get" >
	<input type="submit" value="�ݒ�" disabled>
</form><br>
<form action=CC.jsp method="get" >
	<input type="submit" value="�Ǘ�" disabled>
</form><br>
<a href="Logout_GA101.jsp">���O�A�E�g</a>
</center>
</body>
</html>