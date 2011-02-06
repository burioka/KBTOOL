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
import java.util.Calendar;


public class SignAction extends Action {
    public ActionForward execute(
        ActionMapping mapping,
        ActionForm form,
        HttpServletRequest request,
        HttpServletResponse response)
        throws Exception {
    	String STmpYM = null;
      	String yyyymmdd = null;
       
    	// ActionをFormにキャスト
    	SignForm SignForm = (SignForm) form;
    	
    	STmpYM = SignForm.getPstDate();

        if ((STmpYM == null || STmpYM.length() == 0 )){
         	Calendar cal = Calendar.getInstance();
            String SysY = String.valueOf(cal.get(Calendar.YEAR)); //システムの年
        	String SysM = String.valueOf(cal.get(Calendar.MONTH) + 1) ; //システムの月
        	String SysD = String.valueOf(cal.get(Calendar.DATE)); //システムの日
        	yyyymmdd = SysY + "/" + SysM + "/" + SysD;      	
        }else
        {
           	yyyymmdd =  STmpYM;
        }
        request.setAttribute("Date", yyyymmdd);
        // ActionForwordの返却
    	return mapping.findForward("success");
    }
}
