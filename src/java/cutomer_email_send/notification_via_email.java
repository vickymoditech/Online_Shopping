package cutomer_email_send;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

public class notification_via_email {

    String from, frompwd, d_host = "smtp.gmail.com", d_port = "465", to, subject, body;

    public notification_via_email(String email_id, String msg1) {
        from = "vicky123modi@gmail.com";
        boolean fromAns = validation.isValidEmailAddress(from);

        frompwd = "9898293848";

        to = email_id;
        boolean toAns = validation.isValidEmailAddress(to);
        subject = "SaiKiran BookStore";






        body = "<html>"
                + "<head>"
                + "<center>"
                + "  <label style=\"color: green;font-size: 35px;font-family: sans-serif\"><b>SaiKiran</b></label><br/>"
                + "  <label style=\"color: black;font-size: 12px;font-family: sans-serif\">Safe and Secure Shopping</label>"
                + "<hr/>"
                + "</center>"
                + "</head>"
                + "<body style=\"padding-left:70px;padding-right:70px;padding-top:20px;padding-bottom: 20px;\">"
                + "<strong>" + msg1 + "</strong><br><br>"
                + "<div style=\"padding-left:70px;\">"
                + "<h2>Contact us</h2>\n"
                + "								<p>You can contact or visit us during working time.</p>\n"
                + "								<p><span>Address : </span> B-1004 Siddhi Residency Behind Suriyam Residency Pal,Surat </p>\n"
                + "								<p><span>Tel: </span> 840-10-60120 </p>\n"
                + "								<p><span>Email: </span> vicky123modi@gmail.com</p>\n"
                + "								<p><span>Working Hours: </span> Mon-Sun 9:00 a.m  9:00 p.m</p>"
                + "</div>"
                + "</body>"
                + "<footer >"
                + "<hr/>"
                + "</footer>"
                + "</html>";



        if (fromAns == true && toAns == true) {
            Properties props = new Properties();
            props.put("mail.smtp.user", from);
            props.put("mail.smtp.host", d_host);
            props.put("mail.smtp.port", d_port);
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.socketFactory.port", d_port);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");

            SecurityManager security = System.getSecurityManager();

            try {
                Authenticator auth = new SMTPAuthenticator();
                Session session = Session.getInstance(props, auth);
                //session.setDebug(true);

                MimeMessage msg = new MimeMessage(session);
                //msg.setText(this.body);
                msg.setContent(this.body, "text/html");
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