<%@ page language="java" contentType="text/html; charset=windows-31j"
    pageEncoding="windows-31j"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<h1>���[�U���O�C�����</h1>
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
	<tr><td>���O�C����:</td><td><html:text property="id"  size = "20"  errorStyle="background-color:red" /></td>
	<td><html:errors property="id" /></td></tr>
	<tr><td>�p�X���[�h:</td><td><html:text property="password" size = "20"  errorStyle="background-color:red" /></td>
	<td><html:errors property="password" /></td></tr>
</table>
<html:submit value="���O�C��" />
</html:form>

<p>
<!--<a href="./">���j���[�ɖ߂�</a>-->
</p>

<p>powered by FujiokaShinya</p>	
	
<p>
               </p>
<p>
               </p>
<p>���X�|���T�[�̃T�C�g�ł��B</P>
<form id="searchForm" method="get"
    action="http://livedoorsearch.ddo.jp/r1.php" target="_blank">
    <input type="hidden" name="k" value="search">
    <input type="hidden" name="ie" value="sjis">
    <input type="hidden" name="ddoid" value="buiriokande">
    <input type="text" name="q" value="" size=30><br>
    <input type="button" value="�E�F�u����" onclick="document.getElementById('searchForm').action='http://livedoorsearch.ddo.jp/r1.php'; document.getElementById('searchForm').submit()">
    <input type="button" value="�u���O����" onclick="document.getElementById('searchForm').action='http://livedoorsearch.ddo.jp/r2.php'; document.getElementById('searchForm').submit()">  <br>
    <img src="http://livedoorsearch.ddo.jp/img/ld_logo.gif">
</form>