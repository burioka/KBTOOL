package GA031;

import org.apache.struts.action.ActionForm;

public class SignForm extends ActionForm {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String pstDate = null;

	public String getPstDate(){
        return pstDate;
    }

    public void setPstDate(String pstDate){
        this.pstDate = pstDate;
    }

}
