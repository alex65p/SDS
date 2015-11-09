<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Vector"%>
<%@ page import="s2s.mail.MailSender" %>
<%@ page import="javax.ejb.EJBException" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%
/*
<file>
  <versions>
      <version number="1.0" date="21/01/2004" author="Treskina Maria">		
      <comments>
		<comment date="21/01/2004" author="Treskina Maria">
		   <description>ANA_MAN_View.jsp</description>
		</comment>
		<comment date="03/02/2004" author="Roman Chumachenko">
			<description>UpMaking to new requirements</description>
		</comment>
				 <comment date="27/03/2004" author="Khomenko Juli">
				   <description>Transform View</description>
				 </comment>		
	  </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache");     //HTTP 1.1
response.setHeader("Pragma","no-cache");            //HTTP 1.0
response.setDateHeader ("Expires", 0);              //prevents caching at the proxy server
%>
<%! 
// UTILIZZATO NELLA MASCHERA DEI RISCHI PER GESTIRE L'ASSEGNAZIONE DI NUOVI DPI AL RISCHIO STESSO???
String SendMail4AddedDPI_ANA_RSO(Object strCOD_MAN, Collection DPI_Associati_Originale){
    String ReturnMessage ="";
    if (ApplicationConfigurator.isModuleEnabled(MODULES.EMAIL_ASS_DPI)){
        ReturnMessage = SendMail4AddedDPI_ANA_MAN(strCOD_MAN, DPI_Associati_Originale);
    }
    return ReturnMessage;
}

// UTILIZZATO NELLA DIALOG AGGIUNGI ATTIVITA LAVORATIVE DOPO AGGIUNTA RISCHIO(con dpi) AD OPERAZIONE SVOLTA.
String SendMail4AddedRSO_ANA_OPE_SVO(ArrayList listAttivita,long codiceRischio){
    String ReturnMessage ="";
    String ReturnMessage_OK = "";
    String ReturnMessage_Error = "";
    if (ApplicationConfigurator.isModuleEnabled(MODULES.EMAIL_ASS_DPI)){
        try{
            IRischioHome home=(IRischioHome)PseudoContext.lookup("RischioBean");
            IRischio bean = home.findByPrimaryKey(new RischioPK( Security.getAzienda(), codiceRischio));
            Collection dpiAssociati = bean.getDpiView();
            Iterator itAttivita = listAttivita.iterator();
            while (itAttivita.hasNext()){
                long idAttivita =((Long)(itAttivita.next())).longValue(); 
                IDipendenteHome homeDPD=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                Collection UOListToSendEmail = homeDPD.findUOListToSendMail(Security.getAzienda(),idAttivita);
                Collection ListEmailToSend = new Vector();
                // 3
                IUnitaOrganizzativaHome homeUO = (IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
                Iterator it_UOListToSendEmail = UOListToSendEmail.iterator();
                while (it_UOListToSendEmail.hasNext()){
                    Dipendenti_Lavoratori_View UOToSendEmail = (Dipendenti_Lavoratori_View)it_UOListToSendEmail.next();
                    Collection EMail = homeUO.getFirstUOWithEmail(UOToSendEmail.COD_UNI_ORG);
                    if (EMail != null){
                        String EmailUO = ((UOEmail_View)EMail.iterator().next()).strEMAIL;
                        Iterator it_ListEmailToSend = ListEmailToSend.iterator();
                        EmailToSendView preparedMail = null;
                        boolean mailArleadyExists = false;
                        while(it_ListEmailToSend.hasNext()){

                            preparedMail = (EmailToSendView)it_ListEmailToSend.next();
                            if (preparedMail.strTO.equals(EmailUO)){
                                mailArleadyExists = true;
                                break;
                            }
                        }
                        if (!mailArleadyExists){
                            preparedMail = new EmailToSendView();
                            preparedMail.strTO = EmailUO;
                            preparedMail.strListDPD = "";
                            preparedMail.strListDPI = "";                            
                        }
                        Collection DipendentiList = homeDPD.findDipendentiAttivitaLavorativeByCOD_UNI_ORG
                                                                (Security.getAzienda(), idAttivita, UOToSendEmail.COD_UNI_ORG);
                        // 5
                        Iterator it_DipendentiList = DipendentiList.iterator();
                        while (it_DipendentiList.hasNext()){
                            Dipendenti_Lavoratori_View dipendente = (Dipendenti_Lavoratori_View)it_DipendentiList.next();
                            preparedMail.strListDPD += " - " + dipendente.MTR_DPD + " " + dipendente.COG_DPD + " " + dipendente.NOM_DPD + "\n";
                        }
                        if (!mailArleadyExists){
                            Iterator itDPIAssociati = dpiAssociati.iterator();
                            while (itDPIAssociati.hasNext()){
                                RischioDpi_Tipologia_Sostuzione_Manutenzione_View DPIAggiunto = (RischioDpi_Tipologia_Sostuzione_Manutenzione_View) itDPIAssociati.next();
                                preparedMail.strListDPI += " - " + DPIAggiunto.strNOM_TPL_DPI + "\n";
                            }
                            ListEmailToSend.add(preparedMail);
                        }
                    }
                }
                Iterator it_ListEmailToSend = ListEmailToSend.iterator();
                while(it_ListEmailToSend.hasNext()){
                    EmailToSendView preparedMail = (EmailToSendView)it_ListEmailToSend.next();
                    String mailBody = "Sono stati assegnati i seguenti D.P.I.\n\n";
                    mailBody += preparedMail.strListDPI;
                    mailBody += "\nai dipendenti:\n\n";
                    mailBody += preparedMail.strListDPD + "\n";

                    String[] Destinatari = {preparedMail.strTO};
                    MailSender mailSender = new MailSender();
                    try {
                        mailSender.sendMail(Destinatari, mailBody);
                        ReturnMessage_OK += preparedMail.strTO + "\\n";
                    } catch (Exception e) {
                        ReturnMessage_Error += preparedMail.strTO + " - " + e.getMessage() + "\\n";
                    }
                }
                if (!ReturnMessage_OK.equals("")){
                    ReturnMessage += "E stata inviata una e-mail di avvenuta assegnazione D.P.I. ai seguenti indirizzi:\\n\\n" + ReturnMessage_OK + "\\n";
                }
                if (!ReturnMessage_Error.equals("")){
                    ReturnMessage += "Non è stato possibile inviare la e-mail di avvenuta assegnazione D.P.I. ai seguenti indirizzi:\\n\\n" + ReturnMessage_Error + "\\n";
                }
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }finally {
           //
        }
    }
    return ReturnMessage;
}

String SendMail4AddedOPE_SVO_ANA_MAN(Object strCOD_MAN, Collection DPI_Associati_Originale){
    String ReturnMessage = "";
    if (ApplicationConfigurator.isModuleEnabled(MODULES.EMAIL_ASS_DPI)){
        Iterator iterAssOrig = DPI_Associati_Originale.iterator();
        Vector dpiOriginali = new Vector();

        while (iterAssOrig.hasNext()){
          AttLav_DPI_View dpi_attuale = (AttLav_DPI_View)iterAssOrig.next();
          dpiOriginali.add(new Long(dpi_attuale.COD_TPL_DPI));
        }
        ReturnMessage = SendMail4AddedDPI_ANA_MAN(strCOD_MAN, dpiOriginali);
    }
    return ReturnMessage;
}


// UTILIZZATO NELLA MASCHERA DI ANAGRAFICA DELLE ATTIVITA' LAVORATIVE, PER GESTIRE L'ASSEGNAZIONE DI NUOVI DPI.
String SendMail4AddedDPI_ANA_MAN(Object strCOD_MAN, Collection DPI_Associati_Originale){
    String ReturnMessage = "";
    String ReturnMessage_OK = "";
    String ReturnMessage_Error = "";
    if (ApplicationConfigurator.isModuleEnabled(MODULES.EMAIL_ASS_DPI)){
        try {
            /*
            1 - Verifico che all'attività lavorativa siano stati aggiunti dei DPI
                (diversi da quelli che aveva in partenza).
            2 - Estraggo univocamente tutte le unità organizzative che hanno associata 
                l'attività lavorativa.
            3 - Per ogni unità organizzativa estratta individuo l'indirizzo email di 
                riferimentro che può essere quello della stessa unità o se assente uno
                delle unità padre.
            4 - Se trovo un indirizzo, estraggo tutti i dipendenti a cui è associata
                l'attività lavorativa e l'unità organizzativa.
            5 - Preparo il corpo della mail.
            6 - Invio la mail.
            */
            if (strCOD_MAN != null && !strCOD_MAN.toString().trim().equals("")){

                // 1
                long lCOD_MAN = Long.parseLong(strCOD_MAN.toString());    

                IAttivitaLavorative beanAL = null;
                IAttivitaLavorativeHome homeAL = (IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
                AttivitaLavorativePK ALPK = new AttivitaLavorativePK(Security.getAzienda(),lCOD_MAN);
                beanAL = homeAL.findByPrimaryKey(ALPK);
                Collection DPI_Associati_Attuale = beanAL.getDPI_View();

                boolean uguali = false;
                Vector DPIAggiunti = new Vector();

                Iterator it_dpi_attuale = DPI_Associati_Attuale.iterator();
                while (it_dpi_attuale.hasNext()){
                    AttLav_DPI_View dpi_attuale = (AttLav_DPI_View)it_dpi_attuale.next();

                    Iterator it_dpi_originale = DPI_Associati_Originale.iterator();
                    uguali = false;
                    while (it_dpi_originale.hasNext()){
                        long dpi_originale = ((Long)it_dpi_originale.next()).longValue();
                        if (dpi_attuale.COD_TPL_DPI == dpi_originale){
                            uguali = true;
                            break;
                        }
                    }
                    if (uguali == false){
                       DPIAggiunti.add(dpi_attuale);
                    }
                }

                if (DPIAggiunti.size() > 0){
                    // 2
                    IDipendenteHome homeDPD=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                    Collection UOListToSendEmail = homeDPD.findUOListToSendMail(Security.getAzienda(), lCOD_MAN);
                    Vector ListEmailToSend = new Vector();

                    // 3
                    IUnitaOrganizzativaHome homeUO = (IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
                    Iterator it_UOListToSendEmail = UOListToSendEmail.iterator();
                    while (it_UOListToSendEmail.hasNext()){
                        Dipendenti_Lavoratori_View UOToSendEmail = (Dipendenti_Lavoratori_View)it_UOListToSendEmail.next();

                        Collection EMail = homeUO.getFirstUOWithEmail(UOToSendEmail.COD_UNI_ORG);
                        if (EMail != null){
                            // 4
                            String EmailUO = ((UOEmail_View)EMail.iterator().next()).strEMAIL;
                            Iterator it_ListEmailToSend = ListEmailToSend.iterator();
                            EmailToSendView preparedMail = null;
                            boolean mailArleadyExists = false;
                            while(it_ListEmailToSend.hasNext()){
                                preparedMail = (EmailToSendView)it_ListEmailToSend.next();
                                if (preparedMail.strTO.equals(EmailUO)){
                                    mailArleadyExists = true;
                                    break;
                                }
                            }
                            if (!mailArleadyExists){
                                preparedMail = new EmailToSendView();
                                preparedMail.strTO = EmailUO;
                                preparedMail.strListDPD = "";
                                preparedMail.strListDPI = "";                            
                            }
                            Collection DipendentiList = homeDPD.findDipendentiAttivitaLavorativeByCOD_UNI_ORG
                                                                    (Security.getAzienda(), lCOD_MAN, UOToSendEmail.COD_UNI_ORG);
                            // 5
                            Iterator it_DipendentiList = DipendentiList.iterator();
                            while (it_DipendentiList.hasNext()){
                                Dipendenti_Lavoratori_View dipendente = (Dipendenti_Lavoratori_View)it_DipendentiList.next();
                                preparedMail.strListDPD += " - " + dipendente.MTR_DPD + " " + dipendente.COG_DPD + " " + dipendente.NOM_DPD + "\n";
                            }
                            if (!mailArleadyExists){
                                Iterator it_DPIAggiunti = DPIAggiunti.iterator();
                                while (it_DPIAggiunti.hasNext()){
                                    AttLav_DPI_View DPIAggiunto = (AttLav_DPI_View)it_DPIAggiunti.next();
                                    preparedMail.strListDPI += " - " + DPIAggiunto.NOM_TPL_DPI + "\n";
                                }
                                ListEmailToSend.add(preparedMail);
                            }
                        }
                    }
                    Iterator it_ListEmailToSend = ListEmailToSend.iterator();
                    while(it_ListEmailToSend.hasNext()){
                        EmailToSendView preparedMail = (EmailToSendView)it_ListEmailToSend.next();
                        String mailBody = "Sono stati assegnati i seguenti D.P.I.\n\n";
                        mailBody += preparedMail.strListDPI;
                        mailBody += "\nai dipendenti:\n\n";
                        mailBody += preparedMail.strListDPD + "\n";

                        String[] Destinatari = {preparedMail.strTO};
                        MailSender mailSender = new MailSender();
                        try {
                            mailSender.sendMail(Destinatari, mailBody);
                            ReturnMessage_OK += preparedMail.strTO + "\\n";
                        } catch (Exception e) {
                            ReturnMessage_Error += preparedMail.strTO + " - " + e.getMessage() + "\\n";
                        }
                    }
                    if (!ReturnMessage_OK.equals("")){
                        ReturnMessage += "E stata inviata una e-mail di avvenuta assegnazione D.P.I. ai seguenti indirizzi:\\n\\n" + ReturnMessage_OK + "\\n";
                    }
                    if (!ReturnMessage_Error.equals("")){
                        ReturnMessage += "Non è stato possibile inviare la e-mail di avvenuta assegnazione D.P.I. ai seguenti indirizzi:\\n\\n" + ReturnMessage_Error + "\\n";
                    }
                }
            }
        }
        catch (Exception E)
        {
            E.printStackTrace();
            throw new EJBException(E);
        }
        finally {
            //
        }
    }
    return ReturnMessage;
}

// UTILIZZATO NELLA MASCHERA DI ANAGRAFICA LAVORATORI. PER GESTIRE L'ASSEGNAZIONE DI UNA ATTIVITA' LAVORATIVA
// E DI CONSEGUENZA DEI DPI
String SendMail4AddedDPI_ANA_DPD(long lCOD_UNI_ORG, long lCOD_MAN, long lCOD_DPD){
    String ReturnMessage = "";
    if (ApplicationConfigurator.isModuleEnabled(MODULES.EMAIL_ASS_DPI)){    
        try {
            // Risale la gerarchia delle Unità Organizzative fino a trovarne una che ha impostato un indirizzo Email.
            IUnitaOrganizzativaHome homeUO = (IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");

            Collection EMail = homeUO.getFirstUOWithEmail(lCOD_UNI_ORG);
            if (EMail != null){
                String strEmail = ((UOEmail_View)EMail.iterator().next()).strEMAIL;

                // Torna le informazioni Anagrafiche del Dipendente
                IDipendente beanDIP = null;
                IDipendenteHome homeDIP =(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                beanDIP = homeDIP.findByPrimaryKey(new Long(lCOD_DPD));

                // Trova i D.P.I associati all'attività lavorativa assegnata al dipendente.
                IAttivitaLavorative beanAL = null;
                IAttivitaLavorativeHome homeAL = (IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
                AttivitaLavorativePK ALPK = new AttivitaLavorativePK(Security.getAzienda(),lCOD_MAN);
                beanAL = homeAL.findByPrimaryKey(ALPK);
                Collection al = beanAL.getDPI_View();
                if (al != null && al.size() > 0){
                    java.util.Iterator it = al.iterator();
                    AttLav_DPI_View _temp = null;

                    // Preparo il testo della mail.
                    String mailBody = "Sono stati assegnati i seguenti D.P.I.\n\n";
                    while (it.hasNext()){
                        _temp = (AttLav_DPI_View)it.next();
                        mailBody += " - " + _temp.NOM_TPL_DPI + "\n";
                    }
                    mailBody += "\nal dipendente:\n\n";
                    mailBody += " - " + beanDIP.getMTR_DPD() + " " + beanDIP.getCOG_DPD() + " " + beanDIP.getNOM_DPD() + "\n";

                    String[] Destinatari = {strEmail};
                    MailSender mailSender = new MailSender();
                    try {
                        mailSender.sendMail(Destinatari, mailBody);
                        ReturnMessage = "E stata inviata una e-mail di avvenuta assegnazione D.P.I. al seguente indirizzo:\\n\\n" + 
                                        strEmail;
                    } catch (Exception e) {
                        ReturnMessage = "Non è stato possibile inviare la e-mail di avvenuta assegnazione D.P.I. al seguente indirizzo:\\n\\n" + 
                                        strEmail + "\\n\\n" + 
                                        "per il seguente motivo:\\n\\n" + 
                                        e.getMessage();
                    }
                }
            }
        }
        catch (Exception E)
        {
            E.printStackTrace();
            throw new EJBException(E);
        }
        finally {
            //
        }
    }
    return ReturnMessage;
}
%>
