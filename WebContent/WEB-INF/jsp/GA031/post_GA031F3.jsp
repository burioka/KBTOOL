<%@ page contentType="text/html; charset=Windows-31J"
	import="java.sql.*, javax.naming.*, javax.sql.*  " %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
	<title>���̓t�H�[��</title>
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
			  i_end2 = i;//�z��̌����m�F
			break;
		  }
		}
		
		if (i_end2 < 1 ) {
			out.println("<h4>���͂��Ȃ����A���ڂ��s���S�ł�<br></h4>");
			out.println("<h4>���͂͂��ׂĂ̍��ڂ��L�����Ă��������B<br></h4>");
			out.println("�����ē��͂���Ƃ��͍��̃J�����_�[��<br>");
			out.println("���t���N���b�N���Ă�������<br>");
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
				//�Z�b�V�����m��
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
					out.println("���t�F" + S_date + "�̒����" + "<br>");
					out.println(I_UpCnt  + "���ǉ�����܂����B");
					out.println("�����ē��͂���Ƃ��͍��̃J�����_�[��<br>");
					out.println("���t���N���b�N���Ă�������<br>");
					out.println("</p>");
				}
				//�Z�b�V�����N���[�Y
				ps.close();
				db.close();
			}else 
			{
				out.println("<h4>���z���s���ł�<br></h4>");
				out.println("<h4>���z�͔��p�����œ��͂��Ă�������<br></h4>");
				out.println("�����ē��͂���Ƃ��͍��̃J�����_�[��<br>");
				out.println("���t���N���b�N���Ă�������<br>");
			}
		}
%>