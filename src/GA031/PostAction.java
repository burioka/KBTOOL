package GA031;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;


public class PostAction extends Action {
    public ActionForward execute(
        ActionMapping mapping,
        ActionForm form,
        HttpServletRequest request,
        HttpServletResponse response)
    throws Exception {
    	String   Tgtdate = null;
    	String[] name;
    	String[] sclass;
    	String[] price;
    	int      i_len = 0;
    	long I_UpCnt=0;
        //セッション情報を取得
    	HttpSession  session = request.getSession(false);
    	if(session==null){
    	}else{
    		String   i_uid =    (String)session.getAttribute("S_UidSsn");
	    	// ActionをFormにキャスト
	    	PostForm PostForm = (PostForm) form;
	    	
	    	Tgtdate = PostForm.getTgtdate();
	    	name = PostForm.getName();
	    	sclass = PostForm.getSclass();
	    	price = PostForm.getPrice();
	    	i_len = PostForm.getlen();
	    	
	    	if(i_len >= 1 ){
				//セッション確立
				Context context = new InitialContext();
				DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/KBtool");
				Connection db = ds.getConnection();
				
	    		//対象年月のデータの初期化
				String S_Delql ="";
	    		S_Delql = "DELETE FROM t_purchase WHERE uid = ";
				S_Delql = S_Delql + i_uid;
				S_Delql = S_Delql +  " AND   pur_date = '" + Tgtdate + "'";
		
				PreparedStatement ps = db.prepareStatement(S_Delql);
				int I_DlCnt = ps.executeUpdate();
				//セッションクローズ
				ps.close();
	    		
				for(int i=0;i<=i_len-1;i++){
	    			
					String S_Wsql = "";
					S_Wsql = "INSERT INTO t_purchase VALUES(?,?,?,?,?,?,0,'','',0)";
						//S_Wsql = "INSERT INTO t_purchase VALUES(" ;
						//S_Wsql = S_Wsql + i_uid  + "," ;
						//S_Wsql = S_Wsql + "'" + S_date  +"'" + "," ;
						//S_Wsql = S_Wsql + i + "," ;
						//S_Wsql = S_Wsql + S_Class1[i] + "," ;
						//S_Wsql = S_Wsql + "'" + S_Name1[i] + "'" + ","  ;
						//S_Wsql = S_Wsql + S_Price1[i] + ",";
						//S_Wsql = S_Wsql + 0 + ",";
						//S_Wsql = S_Wsql + "''" + ",";
						//S_Wsql = S_Wsql + "''" + ",";
						//S_Wsql = S_Wsql + 0 ;
						//S_Wsql = S_Wsql + ")";taihi
					ps = db.prepareStatement(S_Wsql);
					//値のセット
					ps.setString(1,i_uid);
					ps.setString(2,Tgtdate);
					ps.setInt(3,i);
					ps.setString(4,sclass[i]);
					ps.setString(5,name[i]);
					ps.setString(6,price[i]);				
					
					
					I_UpCnt = I_UpCnt + ps.executeUpdate();
					ps.close();
	    		}
				//セッションクローズ
				db.close();
			}
	    	request.setAttribute("msg", "登録完了");
		}
	    // ActionForwordの返却
    	return mapping.findForward("success");
    }
}
