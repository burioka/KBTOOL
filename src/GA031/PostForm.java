package GA031;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class PostForm extends ActionForm {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String tgtdate = null;
	private String[] name = null;
	private String[] sclass = null;
	private String[] price = null;
	private int i_len = 0;
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		super.reset(mapping, request);
        try {
                request.setCharacterEncoding("Shift_JIS");
        }
        catch(java.io.IOException ex) {}
    }
    public void setTgtdate(String tgtdate){
        this.tgtdate = tgtdate;
    }
    public void setName(String[] name){
        this.name = name;
    }
    public void setSclass(String[] sclass){
        this.sclass = sclass;
    }
    public void setPrice(String[] price){
        this.price = price;
    }
	public String getTgtdate(){
        return tgtdate;
    }
	public String[] getName(){
        return name;
    }
	public String[] getSclass(){
        return sclass;
    }
	public String[] getPrice(){
        return price;
    }
	public int getlen(){
		int i = 0;
		for (i = 1 ;i <= 10;i++){
			if(!((name[i-1] == null ||  name[i-1].length() == 0)
			|| (sclass[i-1] == null ||  sclass[i-1].length() == 0)
			|| (price[i-1] == null ||  price[i-1].length() == 0))){
				i_len = i;
			}else
			{
				break;
			}
		}
		
		return i_len;
	}


}
