<%@ page contentType="text/html; charset=Windows-31J" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<html>
<head><title><tiles:getAsString name ="title"/></title>
<!-- <style type="text/css">
td{ border:3px dotted gray;}
</style> -->

</head>
<body>
<table border="0" width="100%" cellspacing="5">
<tr>
	<td width="140" valign="top">
		<tiles:insert attribute="menu"/>
	</td>
	<td valign="top" align="left">
		<tiles:insert attribute="body" flush="true"/>
	</td>
</tr>
<tr>
	<td colspan="2">]
		<tiles:insert attribute="footer"/>
	</td>
</tr>
</table>
</body>
</html>

