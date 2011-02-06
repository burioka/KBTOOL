package GA011;

import org.apache.struts.validator.ValidatorForm;

public class LoginForm2 extends ValidatorForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id = null;
    private String password = null;

    public void setId(String id) {
        this.id = id;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String getId() {
        return id;
    }

    public String getPassword() {
        return password;
    }


}
