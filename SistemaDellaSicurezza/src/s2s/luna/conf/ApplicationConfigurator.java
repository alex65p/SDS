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
 * ApplicationConfigurator.java
 *
 * Created on 5 marzo 2007, 16.42
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package s2s.luna.conf;
import java.io.File;
import java.io.FileInputStream;
import java.util.Collection;
import java.util.Locale;
import java.util.Properties;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import javax.ejb.EJBException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import org.apache.log4j.PropertyConfigurator;
import s2s.luna.conf.ModuleManager.PROFILES;
import s2s.luna.conf.ModuleManager.MODULES;
import s2s.luna.conf.ModuleManager.LANGUAGES;
import s2s.ejb.pseudoejb.PseudoContextContainer;
import s2s.luna.util.EnvironmentInfo;

/**
 *
 * @author dario.massaroni
 */
public class ApplicationConfigurator{
    
    // -------------------------------------------------------------------------
    // VARIABILI GLOBALI DELL'APPLICAZIONE
    // -------------------------------------------------------------------------
    
    // -------------------------------------------
    // IMPOSTATE DA CODICE
    // -------------------------------------------
    
    public static final int MAX_AZL_NUMS=0;                         // Imposta il limite di aziende inseribili e gestibili dal sistema.
                                                                    // 0 = Nessun limite.
    
    public static final int MAX_CLIENT_CONNECTION_NUMS=0;           // Imposta il limite di aziende inseribili e gestibili dal sistema.
                                                                    // 0 = Nessun limite.
    
    public static final boolean EnableHardwareSecurity = false;     // Indica se abilitare il meccanismo di protezione hardware.
                                                                    // Se abilitato per accedere all'applicazione sarà necessaria
                                                                    // una chiave hardware.
    
    public static ResourceBundle LanguageManager = null;            // Gestore del linguaggio.

    private static LANGUAGES LANGUAGE = LANGUAGES.ITALIANO;         // Linguaggio di visualizzazione.

    private static PROFILES PROFILO = PROFILES.DEMO;            // Profilo con il quale verrà compilata l'applicazione
                                                                    // A seconda del profilo impostato, l'applicazione avrà delle funzionalità
                                                                    // piuttosto che altre.
                                                                    // Questo consente di mantenere centralizzato lo sviluppo ed allo stesso
                                                                    // tempo di compilare versioni differenti in base al profilo impostato.
    
    private static String DATABASE = "DEMO";                       // Database utilizzato con il "Sistema della Sicurezza"
    
    private static String CONTEXT_PATH ="";                         // Nome del contesto WEB
    private static String APP_URI ="";                              // URI
    private static String APP_PATH ="";                             // Path
    private static String TEMP_WORKING_PATH = "temp";               // Area di appoggio temporanea
    private static final boolean SPECIAL_EDITION = false;           // Indica se il "Sistema della Sicurezza" è in quelche edizione speciale,
                                                                    // tipo ad esempio il 150° della repubblica italiana.

    public static boolean FORM_BASED_LOGIN = false;                 // Utilizza il meccanismo di autenticazione e sicurezza J2EE
                                                                    // FORM_BASED_LOGIN

    public static final boolean PROFILE_CHANGE = true;              // Permette di scegliere dinamicamente, in fase di login,
                                                                    // il profilo con il quale eseguire il "Sistema della Sicurezza"
    
    public static final boolean DATABASE_CHANGE = true;             // Permette di scegliere dinamicamente, in fase di login,
                                                                    // il database da utilizzare con il "Sistema della Sicurezza"
    
    public static final boolean LANGUAGE_CHANGE = true;             // Permette di scegliere dinamicamente, in fase di login,
                                                                    // la lingua con la quale utilizzare con il "Sistema della Sicurezza"
    
    // -------------------------------------------
    // IMPOSTATE DALL'UTENTE SU FILE DI PROPRIETA'
    // -------------------------------------------
    
    // VARIE
    public static String CUSTOMER_NAME;                             // Indica il nome del cliente presso cui è installato il software.
    public static String document_link;                             // Indica il percorso di rete nel quale sono presenti i documenti di revisione delle sezione del PSC.
    public static boolean VIEW_CERT_IMAGE;                          // Indica se visualizzare o meno, sul login, il logo della società certificatrice del "Sistema della Sicurezza".
    public static boolean FILTER_TRACE;                             // Indica se abilitare o meno il trace su log4j per tutte le classi di tipo filter del "Sistema della Sicurezza".
    public static String REQUEST_CHARACTER_ENCODING;                // Indica il set di caratteri con il quale il "Sistema della Sicurezza" interpreta i caratteri che viaggiano negli oggetti request del browser.

    // REPORTISTICA
    public static boolean VIEW_REPORT_IMAGE;                        // Indica se visualizzare o meno il logo sui report.
    public static String BI_SERVER_ADDRESS;                         // Indirizzo http del server di reportistica.
            
    // GESTIONE MAIL
    public static  String MAIL_SMTP_HOST="";                        // Host per la posta in uscita.
    public static  String MAIL_SMTP_PORT="";                        // Porta dell'host per la posta in uscita.
    public static  String MAIL_FROM="";                             // Mittente.
    public static  String MAIL_SUBJECT="";                          // Oggetto.
    
    // GESTIONE LDAP
    public static String HOST="";
    public static String PORT="";
    public static String PORT_SSL="";
    public static String SEARCH_PATH="";
    public static String USER_DN_ATTRIBUTE_NAME="";
    public static String LOGINMODE="";                              // Puo assumere i seguenti 2 valori:
                                                                    // - LDAP,  effettua il login al sistema in automatico, valutanto le credenziali su LDAP
                                                                    // - NO,    effettua il login al sistema nella maniera standard 
                                                                    //          (inserimento da parte dell'utente di user e pasword)
    public static boolean ESCAPE_BACKSLASH;                         // Indica quando, in presenza di credenziali di accesso contenenti il carattere
                                                                    // di backslash "\", il sistema LDAP vuole l'escape di tale valore, con l'aggiunta
                                                                    // di un ulteriore identico carattere "\\".
    
    // ------------------------------------------------
    // IMPOSTATE COME VARIABILI DI AMBIENTE NEL WEB.XML
    // ------------------------------------------------

    public static boolean EXTERNAL_FILES_PROPERTIES;                // Valore booleano che indica se i file di configurazione del "Sistema della Sicurezza", files ".properties"
                                                                    // si trovano su un path esterno a scelta dell'utente.
    public static String EXTERNAL_FILES_PATH;                       // Percorso esterno dei file di configurazione ".properties".


    private static boolean Inizialized = false;
    
    private ApplicationConfigurator(){
        //
    }
            
    private static String getPropertiesPath() {
        if (EXTERNAL_FILES_PROPERTIES) {
            return EXTERNAL_FILES_PATH;
        } else {
            return  APP_PATH +
                    "WEB-INF" + File.separator +
                    "classes" + File.separator +
                    "s2s" + File.separator +
                    "luna" + File.separator +
                    "properties" + File.separator;
        }
    }

    private static String getLanguagePath() {
        return "s2s" + File.separator +
                "luna" + File.separator +
                "properties" + File.separator +
                "localization" + File.separator +
                "MessageBundle";
    }

    /** Creates a new instance of ApplicationConfigurator */
    public static void inizializeApplicationEnvironment(HttpServletRequest request) {
        if (!isInizialized()){

            CONTEXT_PATH = request.getContextPath(); 

            APP_URI = request.getRequestURL().toString().substring
                    (0,request.getRequestURL().toString().indexOf(CONTEXT_PATH)+CONTEXT_PATH.length()+1);
         
            APP_PATH = request.getSession(false).getServletContext().getRealPath("") + File.separator;
       
       //     System.out.println("APP_URI  ="+APP_URI );
       //     System.out.println("APP_PATH  ="+APP_PATH );
            
            try {
                // Carica le proprietà di ambiente impostate nel file "web.xml"
                setContextProperties();

                String PropertiesPath = getPropertiesPath();

                // Carica le proprietà relative all'applicazione
                setApplicationConstants(PropertiesPath);
                
                // Carica le proprietà relative alla gestione mail
                setMailConstants(PropertiesPath);

                // Carica le proprietà relative alla gestione di LDAP
                setLdapConstants(PropertiesPath);

                // Carica il gestore del linguaggio con quale è visualizzato
                // il "Sistema della Sicurezza"
                setLanguageManager();
                
                // Inserisco una sola volta nel contesto tutti i bean che poi utilizzerò
                // in tutte le funzionalità dell'applicazione.
                PseudoContextContainer.getInstance().AddAllBean();

                // Inizializza Log4j
                InitializeLog4j(PropertiesPath);
                
                setInizialized(true);
            } catch (Exception E){
                E.printStackTrace();
                throw new EJBException(E);
            }
        }
    }
    
    public static void reloadApplicationProperties(HttpServletRequest request) {
        setInizialized(false);
        inizializeApplicationEnvironment(request);
    }
    
    private static void setInizialized(boolean _inizialized){
        Inizialized = _inizialized;
    }

    public static boolean isInizialized() {
        return Inizialized;
    }

    private static void setContextProperties(){
        try {
            InitialContext EnvironmentContext = new InitialContext();
            EXTERNAL_FILES_PROPERTIES = (Boolean)EnvironmentContext.lookup("java:comp/env/ExternalFilesProperties");
            EXTERNAL_FILES_PATH = (String)EnvironmentContext.lookup("java:comp/env/ExternalFilesPath");
        } catch (NamingException NE) {
            NE.printStackTrace();
            throw new EJBException(NE);
        }
    }

    private static void setApplicationConstants(String PropertiesPath) throws Exception {
        Properties p = new Properties();
        FileInputStream f = new FileInputStream(new File(PropertiesPath + "Application.properties"));
        p.load(f);

        CUSTOMER_NAME           =   p.getProperty("customer_name");
        document_link           =   p.getProperty("document_link");
        VIEW_REPORT_IMAGE       =   Boolean.parseBoolean(p.getProperty("view_report_image"));
        BI_SERVER_ADDRESS       =   p.getProperty("bi_server_address");
        VIEW_CERT_IMAGE         =   Boolean.parseBoolean(p.getProperty("view_cert_image"));
        FILTER_TRACE            =   Boolean.parseBoolean(p.getProperty("filter_trace"));
        REQUEST_CHARACTER_ENCODING  =   p.getProperty("request_character_encoding");
    } 

    private static void setMailConstants(String PropertiesPath) throws Exception {
        Properties p = new Properties();
        FileInputStream f = new FileInputStream(new File(PropertiesPath + "Mail.properties"));
        p.load(f);

        MAIL_SMTP_HOST          =   p.getProperty("mail.smtp.host");
        MAIL_SMTP_PORT          =   p.getProperty("mail.smtp.port");
        MAIL_FROM               =   p.getProperty("mail.from");
        MAIL_SUBJECT            =   p.getProperty("mail.subject");
    } 
    
    private static void setLdapConstants(String PropertiesPath) throws Exception {
        Properties p = new Properties();
        FileInputStream f = new FileInputStream(new File(PropertiesPath + "Ldap.properties"));
        p.load(f);

        HOST                    =   p.getProperty("HOST");
        PORT                    =   p.getProperty("PORT");
        PORT_SSL                =   p.getProperty("PORT_SSL");
        SEARCH_PATH             =   p.getProperty("SEARCH_PATH");
        USER_DN_ATTRIBUTE_NAME  =   p.getProperty("USER_DN_ATTRIBUTE_NAME");
        LOGINMODE               =   p.getProperty("LOGINMODE");
        ESCAPE_BACKSLASH        =   Boolean.parseBoolean(p.getProperty("ESCAPE_BACKSLASH"));
    }
    
    public static void setLanguageManager(){
        // Imposto il gestore del linguaggio corretto a seconda del valore
        // della variabile privata LINGUAGGIO
        String LanguagePath = getLanguagePath();

        switch (LANGUAGE){
            case ITALIANO:
                LanguageManager = ResourceBundle.getBundle(
                        LanguagePath, 
                        new Locale(Locale.ITALIAN.getLanguage(),Locale.ITALY.getCountry()));
                break;
            case FRANCESE:
                LanguageManager = ResourceBundle.getBundle(
                        LanguagePath, 
                        new Locale(Locale.FRENCH.getLanguage(),Locale.FRANCE.getCountry()));
                break;
        }
    }
    
    private static void InitializeLog4j(String PropertiesPath){
        PropertyConfigurator.configure(PropertiesPath + "log4j.properties");
    }

    public static String getContextPath(){
        return CONTEXT_PATH;
    }

    public static String getApplicationPath(){
        return APP_PATH;
    }

    public static String getApplicationURI(){
        return APP_URI;
    }

    public static String getTempWorkingPath(){
        return APP_PATH + "WEB" + File.separator + TEMP_WORKING_PATH + File.separator;
    }
    
    public static String getTempWorkingURI(){
        return APP_URI + "WEB" + File.separator + TEMP_WORKING_PATH + File.separator;
    }

    public static boolean isSpecialEdition(){
        return SPECIAL_EDITION;
    }
    
    public static boolean isModuleEnabled(MODULES moduleToCheck){
        return ModuleManager.isModuleEnable(PROFILO, moduleToCheck);
    }

    public static Collection getProfileModules(){
        return ModuleManager.getProfileModules(PROFILO);
    }
    
    public static Collection getProfiles(){
        return ModuleManager.getProfiles();
    }
    
    public static PROFILES getProfile(){
        return PROFILO;
    }

    public static void setProfileByName(String profileName){
        Collection<ModuleManager> ProfilesList = getProfiles();
        for (ModuleManager Profile: ProfilesList){
            if (Profile.getProfile().getName().equals(profileName)){
                PROFILO = Profile.getProfile();
            }
        }
    }
    
    public static Collection getDefinedDB () throws Exception{
        EnvironmentInfo envInfo = new EnvironmentInfo();
        return envInfo.getEnvProperties("jdbc/", true);
    }
    
    public static String getDatabase(){
        return DATABASE;
    }
    
    public static void setDatabase(String newDATABASE){
        DATABASE = newDATABASE;
    }
    
    public static LANGUAGES getLanguage(){
        return LANGUAGE;
    }
    
    public static void setLanguage(String newLanguage){
        for (LANGUAGES language: LANGUAGES.values()){
            if (language.getName().equals(newLanguage)){
                LANGUAGE = language;
            }
        }
    }
    
}
