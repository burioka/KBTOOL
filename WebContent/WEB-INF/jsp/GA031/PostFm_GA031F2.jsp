<%@ page language="java" contentType="text/html; charset=windows-31j"
    import="java.sql.*, javax.naming.*, javax.sql.* " pageEncoding="windows-31j"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
	<title>入力フォーム</title>
</head>

<body>
<center>
<h1>入力フォーム</h1>

<%

//定義
		String  S_Uid  ;
		String S_YearPr;
		String S_MonthPr;
		String S_DayPr;
		//String S_TgtDate;
		String S_Wsql ;
		String S_Wsql2 ;
		

		
		//配列作成。
		String[]   D_Class1 = new String[10];
		String[] D_Name1 =  new String[10];
		String[]   D_Price1 = new String[10];
		String[] S_ClSelnum   = new String[99];
		String[] S_ClSelvle   = new String[99];
		Integer  I_RsCnt    = 0;
		Integer  I_RsCnt2    = 0;
		

		//out.println(request.getParameter("TmpY"));
		
		
		S_Uid = (String)session.getAttribute("S_UidSsn");
		String TmpYmd = (String)request.getAttribute("Date");
		String[] S_TgtDate =  TmpYmd.split("/");

		//S_TgtDate = S_YearPr + "-" + S_MonthPr + "-" + S_DayPr;
		out.println("<h2>" +  S_TgtDate[0] + "年" + S_TgtDate[1] + "月" + S_TgtDate[2] + "日" + "</h2>") ;
		//セッション確立
		Context context = new InitialContext();
		DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/KBtool");
		Connection db = ds.getConnection();
		
		S_Wsql = "SELECT uid,Pur_date,Pur_seq,pur_class,pur_name,price FROM t_purchase WHERE uid =" +  S_Uid + " and Pur_date = " + "'" +  TmpYmd + "'" + "order by Pur_seq";

		PreparedStatement ps = db.prepareStatement(S_Wsql);
		ResultSet rs = ps.executeQuery();
		
	while ( rs.next())
	{
		D_Class1[I_RsCnt] = rs.getString("pur_class");
		D_Name1[I_RsCnt]  = rs.getString("pur_name");
		D_Price1[I_RsCnt] = rs.getString("price");
		I_RsCnt = I_RsCnt +1;
	} 
	
	//目的テーブルの取得
	S_Wsql2  = "";
	S_Wsql2 = S_Wsql2  + "SELECT pps_class,pps_name FROM t_purpose where pps_uid  in  (" + S_Uid + "," + 999 + ")" ;
	rs.close();
	ps.close();
	ps = db.prepareStatement(S_Wsql2);
	rs = ps.executeQuery();
	while(rs.next()){
		S_ClSelnum[I_RsCnt2] = rs.getString("pps_class");
		S_ClSelvle[I_RsCnt2] = rs.getString("pps_name");
		I_RsCnt2 = I_RsCnt2 +1;
	}
	//DBセッションのクローズ
	rs.close();
	ps.close();
	db.close();

%>
<form action="post.do" method="post">
<input type = "hidden" name = "tgtdate" value = "<% out.println (TmpYmd); %>">

<table border = 1 cellspacing=1 cellpadding= 3 >

<tr>
	<th>分類</th><th>商品名</th><th>単価</th>
<% // フォーム部
	Integer  i;
	String  s_tagBuf;
	String s_compre1;
	String s_compre2;
	for ( i = 0; i <= 9; i++){
		//商品分類
		out.println( "<tr>") ;
		out.println("<td><select name=\"sclass\">" ) ;
		out.println("<option value=\""  + 0 + "\">" + "   " + "</option>" );
		for(int j = 0 ; j <= I_RsCnt2-1 ; j++){
			s_tagBuf = "" ;
			s_compre1 = "";
			s_compre2 = "";
			if (D_Class1[i] == null) {
			
			}else
			{
				s_compre1 = D_Class1[i];
			}
			s_compre2 = S_ClSelnum[j];
			if(s_compre1.equals(s_compre2)){
				s_tagBuf = "<option value=\""  + S_ClSelnum[j] + "\" selected >" + S_ClSelvle[j] + "</option>"  ;
			}else
			{
				s_tagBuf = "<option value=\""  + S_ClSelnum[j] + "\">" + S_ClSelvle[j] + "</option>"  ;
			}
			out.println(s_tagBuf);
		}
		out.println("</select>");
		out.println("</td>");
		//商品名
		out.println	("<td><textarea name=\"name\" rows=\"1.8\" cols = \"8\">");
		if ( i <= I_RsCnt-1 )
		{
			out.println (D_Name1[i]) ;
		} 
		out.println (	"</textarea></td>");
		//価格
		out.println(	"<td><textarea name=\"price\" rows=\"1.8\" cols = \"8\">");
		if ( i <= I_RsCnt-1 )
		{
			out.println (D_Price1[i]) ;
		} 
		out.println ("</textarea></td>");
		out.println ("</tr>");
	
	}
%>
<tr>
	<td colspan=2>
		<center>
			<input type="submit" value="送信">
			<input type="reset" value="キャンセル" onClick="history.back()">
		</center>
	</td>
</tr>
</table>

</form>