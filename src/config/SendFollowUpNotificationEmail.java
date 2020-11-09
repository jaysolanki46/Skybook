package config;

import java.util.Properties;
import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.util.ByteArrayDataSource;

public class SendFollowUpNotificationEmail {

	public SendFollowUpNotificationEmail(String fromEmail, String toEmail, String toName, String followUpId, String followUpName, String followUpDate, String followUpTime, String followUpNote) {
		
		try {
            final String username = "skyzertms@gmail.com";
            final String password = "Skynet123";
            
            String id = followUpId;
            String from = fromEmail;
            String to = toEmail;
            String attendee = toName;
            String subject = followUpName;
            String startDate = followUpDate; // Date Formate: YYYYMMDD
            String startTime = followUpTime; // Time Formate: HHMM
            String emailBody = followUpNote; 
            
            Properties prop = new Properties();
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "25");

            Session session = Session.getDefaultInstance(prop,  new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
              });
            
            MimeMessage message = new MimeMessage(session);
            message.addHeaderLine("method=REQUEST");
            message.addHeaderLine("charset=UTF-8");
            message.addHeaderLine("component=VEVENT");

            message.setFrom(new InternetAddress(from, "New Outlook Event"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);

            StringBuffer sb = new StringBuffer();

            
            StringBuffer buffer = sb.append("BEGIN:VCALENDAR\n" + 
            		"PRODID:-//Microsoft Corporation//Outlook 16.0 MIMEDIR//EN\n" + 
            		"VERSION:2.0\n" + 
            		"METHOD:REQUEST\n" + 
            		"X-MS-OLK-FORCEINSPECTOROPEN:TRUE\n" + 
            		"BEGIN:VTIMEZONE\n" + 
            		"TZID:New Zealand Standard Time\n" + 
            		"BEGIN:STANDARD\n" + 
            		"DTSTART:"+ startDate  +"T"+ startTime  +"00\n" + 
            		"RRULE:FREQ=YEARLY;BYDAY=1SU;BYMONTH=4\n" + 
            		"TZOFFSETFROM:+1300\n" + 
            		"TZOFFSETTO:+1200\n" + 
            		"END:STANDARD\n" + 
            		"BEGIN:DAYLIGHT\n" + 
            		"DTSTART:"+ startDate  +"T"+ startTime  +"00\n" + 
            		"RRULE:FREQ=YEARLY;BYDAY=-1SU;BYMONTH=9\n" + 
            		"TZOFFSETFROM:+1200\n" + 
            		"TZOFFSETTO:+1300\n" + 
            		"END:DAYLIGHT\n" + 
            		"END:VTIMEZONE\n" + 
            		"BEGIN:VEVENT\n" + 
            		"ATTENDEE;CN=\""+ attendee +"\";RSVP=TRUE:mailto:"+ to +"\n" + 
            		"CLASS:PUBLIC\n" + 
            		"CREATED:"+ startDate  +"T"+ startTime  +"00Z\n" + 
            		"DESCRIPTION: \\n\\n\n" + 
            		"DTEND;TZID=\"New Zealand Standard Time\":"+ startDate  +"T"+ startTime  +"00\n" + 
            		"DTSTAMP:"+ startDate  +"T"+ startTime  +"00Z\n" + 
            		"DTSTART;TZID=\"New Zealand Standard Time\":"+ startDate  +"T"+ startTime  +"00\n" + 
            		"LAST-MODIFIED:"+ startDate  +"T"+ startTime  +"00Z\n" + 
            		"LOCATION:Skyzer Support\n" + 
            		"ORGANIZER;CN=\""+ attendee +"\":mailto:"+ to +"\n" + 
            		"PRIORITY:5\n" + 
            		"SEQUENCE:0\n" + 
            		"SUMMARY;LANGUAGE=en-nz:"+ subject +"\n" + 
            		"TRANSP:OPAQUE\n" + 
            		"UID:"+ id +"\n" + 
            		"X-ALT-DESC;FMTTYPE=text/html:"+ emailBody +"\n" + 
            		"X-MICROSOFT-CDO-BUSYSTATUS:BUSY\n" + 
            		"X-MICROSOFT-CDO-IMPORTANCE:1\n" + 
            		"X-MICROSOFT-DISALLOW-COUNTER:FALSE\n" + 
            		"X-MS-OLK-APPTSEQTIME:"+ startDate  +"T"+ startTime  +"00Z\n" + 
            		"X-MS-OLK-AUTOFILLLOCATION:FALSE\n" + 
            		"X-MS-OLK-CONFTYPE:0\n" + 
            		"BEGIN:VALARM\n" + 
            		"TRIGGER:-PT15M\n" + 
            		"ACTION:DISPLAY\n" + 
            		"DESCRIPTION:Reminder\n" + 
            		"END:VALARM\n" + 
            		"END:VEVENT\n" + 
            		"END:VCALENDAR\n" + 
            		"");
            
            // Create the message part
            BodyPart messageBodyPart = new MimeBodyPart();

            // Fill the message
            messageBodyPart.setHeader("Content-Class", "urn:content-  classes:calendarmessage");
            messageBodyPart.setHeader("Content-ID", "calendar_message");
            messageBodyPart.setDataHandler(new DataHandler(
                    new ByteArrayDataSource(buffer.toString(), "text/calendar")));// very important

            // Create a Multipart
            Multipart multipart = new MimeMultipart();

            // Add part one
            multipart.addBodyPart(messageBodyPart);

            // Put parts in message
            message.setContent(multipart);

            // send message
            Transport.send(message);
            //java.util.UUID.randomUUID().toString()
            System.out.println("Email sent!");
        } catch (MessagingException me) {
            me.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
	}
}
