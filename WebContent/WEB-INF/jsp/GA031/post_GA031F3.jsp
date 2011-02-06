<%@ page contentType="text/html; charset=Windows-31J"
	import="java.sql.*, javax.naming.*, javax.sql.*  " %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
	<title>入力フォーム</title>
</head>

<body>
<%
		request.setCharacterEncoding("Windows-31J");
		String[]   S_Class1 = request.getParameterValues("CLASS2");
		String[]   S_Name1 =  request.getParameterValues("NAME2");
		String[]   S_Price1 = request.getParameterValues("PRICE2");
		String     S_date   = request.getParameter("tgtdate");
		String     i_uid =    (String)session.getAttribute("S_UidSsn");
		String     S_Wsql;   
		Integer    i_end = S_Name1.length-1;
		Integer    i_end2 = 0;
		Integer I_UpCnt = 0;
		String     S_Delql; 
		Integer I_DlCnt = 0;
		Integer I_NumChk = 0;
		
		for(int i = 0;i<i_end;i++){
		  if( (S_Name1[i] == null ||  S_Name1[i].length() == 0)
			|| (S_Class1[i] == null ||  S_Class1[i].length() == 0)
			|| (S_Price1[i] == null ||  S_Price1[i].length() == 0)
		  ){
			  i_end2 = i;//配列の個数を確認
			break;
		  }
		}
		
		if (i_end2 < 1 ) {
			out.println("<h4>入力がないか、項目が不完全です<br></h4>");
			out.println("<h4>入力はすべての項目を記入してください。<br></h4>");
			out.println("続けて入力するときは左のカレンダーの<br>");
			out.println("日付をクリックしてください<br>");
		}else
		{	
			for(int i = 0;i<i_end2;i++){
				try {
		            Double.parseDouble(S_Price1[i]);
	
		        } catch(NumberFormatException e) {
		        	I_NumChk = 1; 
		        }
			}
			if (I_NumChk == 0){
				//セッション確立
				Context context = new InitialContext();
				DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/KBtool");
				Connection db = ds.getConnection();
						S_Delql = "DELETE FROM t_purchase WHERE uid = ";
				S_Delql = S_Delql + i_uid;
				S_Delql = S_Delql +  " AND   pur_date = '" + S_date + "'";
		
				PreparedStatement ps = db.prepareStatement(S_Delql);
				I_DlCnt = ps.executeUpdate();
				ps.close();
				for(int i = 0;i<i_end2 ;i++){
					S_Wsql = "";
					S_Wsql = "INSERT INTO t_purchase VALUES(" ;
					S_Wsql = S_Wsql + i_uid  + "," ;
					S_Wsql = S_Wsql + "'" + S_date  +"'" + "," ;
					S_Wsql = S_Wsql + i + "," ;
					S_Wsql = S_Wsql + S_Class1[i] + "," ;
					S_Wsql = S_Wsql + "'" + S_Name1[i] + "'" + ","  ;
					S_Wsql = S_Wsql + S_Price1[i] + ",";
					S_Wsql = S_Wsql + 0 + ",";
					S_Wsql = S_Wsql + "''" + ",";
					S_Wsql = S_Wsql + "''" + ",";
					S_Wsql = S_Wsql + 0 ;
					S_Wsql = S_Wsql + ")";
					ps = db.prepareStatement(S_Wsql);
					I_UpCnt = I_UpCnt + ps.executeUpdate();
					ps.close();
				}
				if (I_UpCnt> 0){
					out.println("<p>");
					out.println("日付：" + S_date + "の帳簿に" + "<br>");
					out.println(I_UpCnt  + "件追加されました。");
					out.println("続けて入力するときは左のカレンダーの<br>");
					out.println("日付をクリックしてください<br>");
					out.println("</p>");
				}
				//セッションクローズ
				ps.close();
				db.close();
			}else 
			{
				out.println("<h4>金額が不正です<br></h4>");
				out.println("<h4>金額は半角数字で入力してください<br></h4>");
				out.println("続けて入力するときは左のカレンダーの<br>");
				out.println("日付をクリックしてください<br>");
			}
		}
%>