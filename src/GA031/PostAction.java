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
        //�Z�b�V���������擾
    	HttpSession  session = request.getSession(false);
    	if(session==null){
    	}else{
    		String   i_uid =    (String)session.getAttribute("S_UidSsn");
	    	// Action��Form�ɃL���X�g
	    	PostForm PostForm = (PostForm) form;
	    	
	    	Tgtdate = PostForm.getTgtdate();
	    	name = PostForm.getName();
	    	sclass = PostForm.getSclass();
	    	price = PostForm.getPrice();
	    	i_len = PostForm.getlen();
	    	
	    	if(i_len >= 1 ){
				//�Z�b�V�����m��
				Context context = new InitialContext();
				DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/KBtool");
				Connection db = ds.getConnection();
				
	    		//�Ώ۔N���̃f�[�^�̏���
				String S_Delql ="";
	    		S_Delql = "DELETE FROM t_purchase WHERE uid = ";
				S_Delql = S_Delql + i_uid;
				S_Delql = S_Delql +  " AND   pur_date = '" + Tgtdate + "'";
		
				PreparedStatement ps = db.prepareStatement(S_Delql);
				int I_DlCnt = ps.executeUpdate();
				//�Z�b�V�����N���[�Y
				ps.close();
	    		
				for(int i=0;i<=i_len-1;i++){
	    			
					String S_Wsql = "";
					S_Wsql = "INSERT INTO t_purchase VALUES(?,?,?,?,?,?,0,'','',0)";

					ps = db.prepareStatement(S_Wsql);
					//�l�̃Z�b�g
					ps.setString(1,i_uid);
					ps.setString(2,Tgtdate);
					ps.setInt(3,i);
					ps.setString(4,sclass[i]);
					ps.setString(5,name[i]);
					ps.setString(6,price[i]);				
					
					
					I_UpCnt = I_UpCnt + ps.executeUpdate();
					ps.close();
	    		}
				//�Z�b�V�����N���[�Y
				db.close();
			}
	    	request.setAttribute("msg", "�o�^����");
		}
	    // ActionForword�̕ԋp
    	return mapping.findForward("success");
    }
}
