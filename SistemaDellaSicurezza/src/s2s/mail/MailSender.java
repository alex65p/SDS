/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

/*
 * MailSender.java
 *
 * Created on 9 ottobre 2007, 15.24
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package s2s.mail;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.utils.text.StringManager;

/**
 *
 * @author dario.massaroni
 */
public class MailSender {

    /**
     * Creates a new instance of MailSender
     */
    public MailSender() {
    }

    public boolean sendMail(String[] Destinatari, String CorpoMessaggio) throws MessagingException {
        boolean Return = false;
        try {
            // Fill the message properties
            Properties properties = new Properties();
            properties.put("mail.smtp.host", ApplicationConfigurator.MAIL_SMTP_HOST);
            properties.put("mail.smtp.port", ApplicationConfigurator.MAIL_SMTP_PORT);
            Session session = Session.getInstance(properties, null);
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(ApplicationConfigurator.MAIL_FROM));
            if (Destinatari != null && Destinatari.length > 0) {
                InternetAddress[] ListaDestinatari = new InternetAddress[Destinatari.length];
                for (int i = 0; i < Destinatari.length; i++) {
                    ListaDestinatari[i] = new InternetAddress(Destinatari[i]);
                }
                message.setRecipients(Message.RecipientType.TO, ListaDestinatari);
            }
            message.setSubject(ApplicationConfigurator.MAIL_SUBJECT);

            // Fill the message Body
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText(CorpoMessaggio);
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);
            message.setContent(multipart);
            message.setSentDate(new java.util.Date());

            // Send message
            Transport.send(message);
            Return = true;
        } finally {
            return Return;
        }
    }

    public void saveMailToFile(String to, String from, String subject, String body, List<File> attachments, boolean asDraft, String filePath) {
        try {
            Message message = new MimeMessage(Session.getInstance(System.getProperties()));
            if (StringManager.isNotEmpty(from)){
                message.setFrom(new InternetAddress(from));
            }
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            // create the message part 
            MimeBodyPart content = new MimeBodyPart();
            // fill message
            content.setText(body);
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(content);
            
            if (attachments != null){
                // add attachments
                for (File file : attachments) {
                    MimeBodyPart attachment = new MimeBodyPart();
                    DataSource source = new FileDataSource(file);
                    attachment.setDataHandler(new DataHandler(source));
                    attachment.setFileName(file.getName());
                    multipart.addBodyPart(attachment);
                }
            }
            // integration
            message.setContent(multipart);
            // save as 'draft'
            message.setFlag(Flags.Flag.DRAFT, asDraft);
            // store file
            message.writeTo(new FileOutputStream(new File(filePath)));
        } catch (MessagingException ex) {
            Logger.getLogger(MailSender.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(MailSender.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
