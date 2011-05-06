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
    	String  cmessage = "IDとパスワードが一致しません";
        // ActionForm��LoginForm�ɃL���X�g
        LoginForm2 loginForm = (LoginForm2) form;
        // �t�H�[���ɓ�͂��ꂽID���擾
        String id = loginForm.getId();
        // �t�H�[���ɓ�͂��ꂽ�p�X���[�h���擾
        String password = loginForm.getPassword();
    	//�Z�b�V�����m��
    	Context context = new InitialContext();
    	DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/KBtool");
    	Connection db = ds.getConnection();
    	S_Wsql = "SELECT uid,name , password,login,userclass FROM t_members WHERE login = " +  "'" + id + "'" ;
    	PreparedStatement ps = db.prepareStatement(S_Wsql);
    	ResultSet rs = ps.executeQuery(S_Wsql);
    	//�F�؊J�n
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

			        I_NinshoFlg = 2;
    			}
    			else 
    			{
    				
    			    I_NinshoFlg = 1;
    			    // message��request�X�R�[�v�ɓo�^
			        request.setAttribute("message", cmessage);
    			}
    		}
    	}
    	if(I_NinshoFlg == 0){
			String message = "mismatch2";
		    I_NinshoFlg = 1;
		    // message��request�X�R�[�v�ɓo�^
	        request.setAttribute("message", cmessage);

    	}
    	//DB�Z�b�V�����̃N���[�Y
    	rs.close();
    	ps.close();
    	db.close();
        // ActionForword�̕ԋp
    	if(I_NinshoFlg == 2){
    		return mapping.findForward("success");
    	}
    	else
    	{
    		return mapping.findForward("err");
    	}
    }
}
