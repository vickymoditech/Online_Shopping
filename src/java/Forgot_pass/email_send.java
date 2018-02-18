package Forgot_pass;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

class Validation extends email_send {
    
    public Validation(String email_id,int code)
    {
        super(email_id,code);
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

public class email_send {

    String from, frompwd, d_host = "smtp.gmail.com", d_port = "465", to, subject, body;

    public email_send(String email_id,int code) {
        //System.out.println("From(Mail): ");
        from = "vicky123modi@gmail.com";
        boolean fromAns = Validation.isValidEmailAddress(from);

        /**
         * while(fromAns==false) { System.out.println("Plz enter valid email
         * address.."); System.out.println(" Re-enter From(Mail): ");
         * from=s.nextLine(); fromAns=Validation.isValidEmailAddress(from);
            }*
         */
        //System.out.println("From(pwd): ");
        
        
        frompwd = "9898293848";

        //System.out.println("To: ");
        to = email_id;
        boolean toAns = Validation.isValidEmailAddress(to);

        /**
         * while(toAns==false) { System.out.println("Plz enter valid email
         * address.."); System.out.println("Re-enter To: "); to=s.nextLine();
         * toAns=Validation.isValidEmailAddress(to);
            }*
         */
        //System.out.println("Subject: ");
        subject = "Java_email_check";

        //System.out.println("Body: ");
        body = "Your Saikiran Verification Code is "+code;

        if (fromAns == true && toAns == true) {
            Properties props = new Properties();
            props.put("mail.smtp.user", from);
            props.put("mail.smtp.host", d_host);
            props.put("mail.smtp.port", d_port);
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.auth", "true");
            //props.put("mail.smtp.debug", "true");
            props.put("mail.smtp.socketFactory.port", d_port);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");

            SecurityManager security = System.getSecurityManager();

            try {
                Authenticator auth = new SMTPAuthenticator();
                Session session = Session.getInstance(props, auth);
                //session.setDebug(true);

                MimeMessage msg = new MimeMessage(session);
                msg.setText(this.body);
                msg.setSubject(this.subject);
                msg.setFrom(new InternetAddress(from));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                Transport.send(msg);
            } catch (Exception mex) {
                mex.printStackTrace();
            }
        }
    }

    private class SMTPAuthenticator extends javax.mail.Authenticator {

        @Override
        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(from, frompwd);
        }
    }
}