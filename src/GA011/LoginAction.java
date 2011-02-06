package GA011;

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



public class LoginAction extends Action {
    public ActionForward execute(
        ActionMapping mapping,
        ActionForm form,
        HttpServletRequest request,
        HttpServletResponse response)
        throws Exception {
    	Integer I_NinshoFlg = 0;
    	String S_Wsql = "";
        // ActionFormをLoginFormにキャスト
        LoginForm2 loginForm = (LoginForm2) form;
        // フォームに入力されたIDを取得
        String id = loginForm.getId();
        // フォームに入力されたパスワードを取得
        String password = loginForm.getPassword();
    	//セッション確立
    	Context context = new InitialContext();
    	DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/KBtool");
    	Connection db = ds.getConnection();
    	S_Wsql = "SELECT uid,name , password,login,userclass FROM t_members WHERE login = " +  "'" + id + "'" ;
    	PreparedStatement ps = db.prepareStatement(S_Wsql);
    	ResultSet rs = ps.executeQuery(S_Wsql);
    	//認証開始
    	I_NinshoFlg = 0;
    	if(!(rs.isLast())){
    		while (rs.next()){
    			if(password.equals(rs.getString("password"))){

    				HttpSession  session = request.getSession(true);
    				session.setAttribute("S_UidSsn", rs.getString("uid"));
    				session.setAttribute("S_LginSsn", id);
    				session.setAttribute("S_PassSsn", rs.getString("password"));
    				session.setAttribute("S_NameSsn", rs.getString("name"));
    				session.setAttribute("S_UClsSsn", rs.getString("userclass"));

    				// messageの作成
			        String message = "Your ID is " + id + ". Password is " + password + ".りこんぱいる";
			        // messageをrequestスコープに登録
			        request.setAttribute("message", message);
			        I_NinshoFlg = 2;
    			}
    			else 
    			{
    				String message = "パスワードが違います";
    			    I_NinshoFlg = 1;
    			    // messageをrequestスコープに登録
			        request.setAttribute("message", message);
    			}
    		}
    	}
    	if(I_NinshoFlg == 0){
			String message = "IDが違います";
		    I_NinshoFlg = 1;
		    // messageをrequestスコープに登録
	        request.setAttribute("message", message);

    	}
    	//DBセッションのクローズ
    	rs.close();
    	ps.close();
    	db.close();
        // ActionForwordの返却
    	if(I_NinshoFlg == 2){
    		return mapping.findForward("success");
    	}
    	else
    	{
    		return mapping.findForward("err");
    	}
    }
}
