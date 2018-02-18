package cutomer_email_send;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

public class validation extends notification_via_email {
    
    public validation(String email_id,String msg)
    {
        super(email_id,msg);
    }
    
    public static boolean isValidEmailAddress(String email) {
        boolean result = true;
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
        } catch (AddressException ex) {
            result = false;
        }
        return result;
    }
}
