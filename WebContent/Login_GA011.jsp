<%@ page language="java" contentType="text/html; charset=windows-31j"
    pageEncoding="windows-31j"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<h1>ユーザログイン画面</h1>
<%
String Msg=(String)request.getAttribute("message") ;
if ( Msg==null || (Msg.length() == 0)){
}else
{
	out.println(Msg);
}
%>
<html:form action="GA011/login2.do" method="post">
<table border="1">
	<tr><td>ログイン名:</td><td><html:text property="id"  size = "20"  errorStyle="background-color:red" /></td>
	<td><html:errors property="id" /></td></tr>
	<tr><td>パスワード:</td><td><html:text property="password" size = "20"  errorStyle="background-color:red" /></td>
	<td><html:errors property="password" /></td></tr>
</table>
<html:submit value="ログイン" />
</html:form>

<p>
<!--<a href="./">メニューに戻る</a>-->
</p>

<p>powered by FujiokaShinya</p>	
	
<p>
               </p>
<p>
               </p>
<p>↓スポンサーのサイトです。</P>
<form id="searchForm" method="get"
    action="http://livedoorsearch.ddo.jp/r1.php" target="_blank">
    <input type="hidden" name="k" value="search">
    <input type="hidden" name="ie" value="sjis">
    <input type="hidden" name="ddoid" value="buiriokande">
    <input type="text" name="q" value="" size=30><br>
    <input type="button" value="ウェブ検索" onclick="document.getElementById('searchForm').action='http://livedoorsearch.ddo.jp/r1.php'; document.getElementById('searchForm').submit()">
    <input type="button" value="ブログ検索" onclick="document.getElementById('searchForm').action='http://livedoorsearch.ddo.jp/r2.php'; document.getElementById('searchForm').submit()">  <br>
    <img src="http://livedoorsearch.ddo.jp/img/ld_logo.gif">
</form>