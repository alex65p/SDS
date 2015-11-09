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

package s2s.luna.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import javax.naming.*;

import s2s.luna.ejb.Security.Security.*;
import s2s.luna.ejb.Security.*;
import s2s.ejb.pseudoejb.*;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.Servlet.login.PrincipalWrapper;

public class SecurityWrapper {

    static long tmLastKeyCheck = 0;
    HttpServletRequest m_request;
    HttpSession m_session;
    JspWriter m_out;
    private static SecurityWrapper s_Security;

    public static SecurityWrapper getInstance() {
        return s_Security;
    }
    boolean m_IsMultimode;
    private final static String GLOBAL_AZIENDA_ID = "GLOBAL_AZIENDA";
    private final static String GLOBAL_AZIENDE_IDS = "GLOBAL_AZIENDE";
    private final static String GLOBAL_AZIENDA_NAME = "GLOBAL_AZIENDA_NAME";
    private final static String GLOBAL_AZIENDA_MODE = "GLOBAL_AZIENDA_MODE";
    private final static String GLOBAL_AZIENDA_MODALITA_CALCOLO_RISCHIO = "GLOBAL_AZIENDA_MODALITA_CALCOLO_RISCHIO";
    private final static String GLOBAL_SECURITY_CONTEXT = "GLOBAL_SECURITY_CONTEXT";
    private final static String GLOBAL_DVR_UNI_ORG = "GLOBAL_DVR_UNI_ORG";
    private final static String GLOBAL_DVR_UNI_ORG_NAME = "GLOBAL_DVR_UNI_ORG_NAME";
    public final static String REQUEST_COD_AZL = "SID";
    private Hashtable m_hashPermissions;
    private SecurityUserPermissionDetails m_details;
    private SecurityModule m_module;

    public boolean isExtendedMode() throws Exception {
        boolean bEnvExtendedMode = ((Boolean) (new InitialContext()).lookup("java:comp/env/ExtendedMode")).booleanValue();
        return bEnvExtendedMode && isConsultant();
    }
    //<for dvr>
    //<for-dvr>

    public void setCurrentDvrUniOrg(Long lCOD_UNI_ORG) {
        m_session.setAttribute(GLOBAL_DVR_UNI_ORG, lCOD_UNI_ORG);
    }

    public Long getCurrentDvrUniOrg() {
        return (Long) m_session.getAttribute(GLOBAL_DVR_UNI_ORG);
    }

    public void setCurrentDvrUniOrgName(String strNOM_UNI_ORG) {
        m_session.setAttribute(GLOBAL_DVR_UNI_ORG_NAME, strNOM_UNI_ORG);
    }

    public String getCurrentDvrUniOrgName() {
        return (String) m_session.getAttribute(GLOBAL_DVR_UNI_ORG_NAME);
    }

    //</for-dvr>
    public SecurityWrapper(HttpServletRequest request, HttpSession session, JspWriter out) {
        m_request = request;
        m_session = session;
        m_out = out;
        s_Security = this;
    }

    public long getAziendaR() {
        return Long.parseLong(m_request.getParameter(REQUEST_COD_AZL));
    }

    /*
    public java.security.Principal getUserPrincipal() {
        return m_request.getUserPrincipal();
    }
    */

    public PrincipalWrapper getUserPrincipal() {
        return (PrincipalWrapper) m_request.getSession(false).getAttribute("PRINCIPAL");
    }

    public boolean isUserInRole(java.lang.String role) {
        return m_request.isUserInRole(role);
    }

    private void throwNegativeAccessObject() throws Exception {
        m_out.clearBuffer();
        m_out.println("<html><body></html><script>alert('Accesso Negato!')</script></body><html>");
        m_out.close();
    }

    private void throwNegativeAccess() throws Exception {
        m_out.clearBuffer();
        m_out.println("<html><body></html><script>alert('Accesso Negato!')</script></body><html>");
        m_out.close();
    }

    public SecurityUserPermissionDetails accessModule(String strModuleName) throws NamingException, Exception {
        ISecurityHome home = getSecurityHome();
        m_module = home.getSecurityModule(strModuleName);
        SecurityModule module = m_module;

        if (module == null) {
            {
                m_details = new SecurityUserPermissionDetails();
                m_details.allow();
                return m_details;
            }
        }

        if (isConsultant()) {
            m_details = getSecurityHome().getConsultantPermissionDetails(module.strPermission);
            if (m_details == null) {
                throwNegativeAccess();
            }
        } else {
            m_details = home.getUserPermissionDetails(getUserPrincipal().getName(), module.strPermission);
            if (m_details == null) {
                throwNegativeAccess();
            }
            if ((module.bRequireCreate && !m_details.bCanCreate)
                    || (module.bRequireSave && !m_details.bCanSave)
                    || (module.bRequireList && !m_details.bCanList)
                    || (module.bRequireDelete && !m_details.bCanDelete)
                    || (module.bRequireAssociateCreate && !m_details.bCanAssociateCreate)
                    || (module.bRequireAssociateDelete && !m_details.bCanAssociateDelete)
                    || (module.bRequirePrint && !m_details.bCanPrint)
                    || (module.bRequirePrint2 && !m_details.bCanPrint2)
                    || (module.bRequireDetalize && !m_details.bCanDetalize)) {
                throwNegativeAccess();
            }
        }
        return m_details;
    }

    public SecurityUserPermissionDetails accessModule() throws NamingException, Exception {
        return accessModule(m_request.getServletPath());
    }

    public void accessRequest() throws NamingException, Exception {
        int iPkRes = 0;
        if (ApplicationConfigurator.EnableHardwareSecurity) {
            iPkRes = isSystemProtected();
        }
        if (iPkRes == 1) {
            throw new Exception("Chiave di protezione hardware non trovata.");
        } else if (iPkRes == 2) {
            throw new Exception("Chiave di protezione hardware errata o non correttamente programmata.");
        }

        if (m_module == null) {
            return;
        }
        if (m_module.strRequest == null || m_module.strRequest.equals("")) {
            return;
        }
        accessRequest(m_module.strRequest);
    }

    public void accessRequest(String strParameters) throws NamingException, Exception {
        StringTokenizer st = new StringTokenizer(strParameters, ";");
        long l = 0;
        while (st.hasMoreTokens()) {
            String strName = st.nextToken();
            Iterator it = parseParameters(strName).iterator();

            while (it.hasNext()) {
                accessObject(((Long) it.next()).longValue());
                //if(it.hasNext()) throw new Exception(it.next()+"");
            }
        }
    }

    public java.util.ArrayList parseParameters(String strName) {
        String _enum[] = m_request.getParameterValues(strName);
        java.util.ArrayList array = new java.util.ArrayList();

        if (_enum == null) {
            return array;
        }

        for (int i = 0; i < _enum.length; i++) {
            try {
                long l = Long.parseLong(_enum[i]);
                array.add(new Long(l));
            } catch (Exception ex) {
            }
        }
        return array;
    }

    public void accessObject(long idObject) throws Exception {
        int i = getSecurityHome().accessObject(idObject, getUserPrincipal().getName(), isConsultant());
        //if(true)throw new Exception(idObject+"");
        if (i == ISecurityHome.ACCESS_OBJECT_NOT_FOUND || i == ISecurityHome.ACCESS_OBJECT_OK) {
            return;
        }
        throwNegativeAccessObject();
    }

    public SecurityUserPermissionDetails getUserPermission() {
        return m_details;
    }

    public boolean userHasPermission(String strFunction) throws Exception {
        //if(isConsultant() && !isMultimode()) return true;
        getPermissions();
        return m_hashPermissions.containsKey(strFunction);
        //return isUserInRole("ROLE_FUNCTION:"+strFunction);
    }

    private void getPermissions() throws NamingException {
        if (m_hashPermissions != null) {
            return;
        }
        m_hashPermissions = new Hashtable();
        Iterator it = null;
        if (isUser()) {
            it = getSecurityHome().getUserPermissions(getUserPrincipal().getName()).iterator();
        } else {
            if (isMultimode()) {
                it = getSecurityHome().getMultiConsultantPermissions().iterator();
            } else {
                it = getSecurityHome().getConsultantPermissions().iterator();
            }
        }

        while (it.hasNext()) {
            SecurityUserPermission p = (SecurityUserPermission) it.next();
            m_hashPermissions.put(p.strName, "");
        }
    }

    public ISecurityHome getSecurityHome() throws NamingException {
        return (ISecurityHome) PseudoContext.lookup("SecurityBean");
    }

    public long getAzienda() {
        return getAziendaId().longValue();
    }

    public Long getAziendaId() {
        return (Long) m_session.getAttribute(GLOBAL_AZIENDA_ID);
    }

    public void setAziendaId(Long l) throws NamingException {
        m_session.setAttribute(GLOBAL_AZIENDA_ID, l);
        getSecurityHome().setSecurityContextData(getSecurityContextId(), l.longValue(), getUserPrincipal().getName());
    }

    public void setCurrentAzienda(long l) throws NamingException {
        setAziendaId(new Long(l));
    }

    public void setAziendaName(String strName) {
        m_session.setAttribute(GLOBAL_AZIENDA_NAME, strName);
    }

    public String getAziendaName() {
        return (String) m_session.getAttribute(GLOBAL_AZIENDA_NAME);
    }

    public void setAziendaModalitaCalcoloRischio(short mcr) {
        m_session.setAttribute(GLOBAL_AZIENDA_MODALITA_CALCOLO_RISCHIO, new Short(mcr));
    }

    public short getAziendaModalitaCalcoloRischio() {
        return ((Short) m_session.getAttribute(GLOBAL_AZIENDA_MODALITA_CALCOLO_RISCHIO)).shortValue();
    }

    public void setAziende(java.util.ArrayList arr) throws Exception {
        m_session.setAttribute(GLOBAL_AZIENDE_IDS, arr);
        if (arr.size() > 1) {
            this.isMultimode(true);
            setAziendaId(new Long(-1));
        } else {
            isMultimode(false);
            Long l = (Long) arr.get(0);
            setAziendaId(l);
        }
    }

    public java.util.ArrayList getAziende() {
        return (java.util.ArrayList) m_session.getAttribute(GLOBAL_AZIENDE_IDS);
    }

    public boolean isConsultant() {
        // return isUserInRole("CATEGORY_CONSULTANT:");
        return getUserPrincipal().isConsultant();
    }

    public boolean isUser() {
        // return isUserInRole("CATEGORY_USER:");
        return getUserPrincipal().isUser();
    }

    public void isMultimode(boolean b) {
        m_session.setAttribute(GLOBAL_AZIENDA_MODE, new Boolean(b));
    }

    public boolean isMultimode() {
        Boolean b = (Boolean) m_session.getAttribute(GLOBAL_AZIENDA_MODE);
        //if(b=null) return false;
        return b.booleanValue();
    }

    public boolean isMultimodeConsultant() {
        return isMultimode() & isConsultant();
    }

    public String getAziendaNameEx() {
        if (isMultimode()) {
            return "MULTIAZIENDA";
        }
        return getAziendaName();
    }

    public void setSecurityContextIdFromUserTocken() throws Exception {
        long ll = getCustomRoleValue("SECURITY_CONTEXT");
        if (ll == -1) {
            throw new Exception("Invalid setSecurityContextIdFromUserTocken");
        }
        m_session.setAttribute(GLOBAL_SECURITY_CONTEXT, new Long(ll));
    }

    public long getSecurityContextId() {
        return ((Long) m_session.getAttribute(GLOBAL_SECURITY_CONTEXT)).longValue();
    }

    public void setAziendaIdFromUserTocken() throws Exception {
        long ll = getCustomRoleValue("USER_AZIENDA");
        if (ll == -1) {
            throw new Exception("Invalid setAziendaIdFromUserTocken");
        }
        Long l = new Long(ll);
        setAziendaId(l);
        java.util.ArrayList ls = new java.util.ArrayList();
        ls.add(l);
        setAziende(ls);
    }

    public long getCustomRoleValue(String strKey) throws Exception {

        //<reflection>
        Class c = getUserPrincipal().getClass();

        String str[] = new String[0];

        java.lang.reflect.Method method = c.getMethod("getRoles", new Class[]{});
        str = (String[]) method.invoke(getUserPrincipal(), new Object[]{});

        strKey += ":";
        //</reflection>

        for (int i = 0; i < str.length; i++) {
            if (str[i].indexOf(strKey) == -1) {
                continue;
            }
            String strr = Replace(str[i], strKey, "");
            return Long.parseLong(strr);
        }
        return -1;
    }

    public String Replace(String psWord, String psReplace, String psNewSeg) {
        StringBuffer lsNewStr = new StringBuffer();
        int liFound = 0;
        int liLastPointer = 0;
        do {
            liFound = psWord.indexOf(psReplace, liLastPointer);
            if (liFound < 0) {
                lsNewStr.append(psWord.substring(liLastPointer, psWord.length()));
            } else {
                if (liFound > liLastPointer) {
                    lsNewStr.append(psWord.substring(liLastPointer, liFound));
                }

                lsNewStr.append(psNewSeg);
                liLastPointer = liFound + psReplace.length();
            }
        } while (liFound > -1);
        return lsNewStr.toString();
    }

    private int isSystemProtected() {
        SentinelSuperproHelper sentinel = new SentinelSuperproHelper();
        boolean isInit = false;
        byte[] apiPacket = new byte[1028];
        int status;
        int devID = 51884; // = CAAC
        int[] numLic = new int[1];
        numLic[0] = 0;
        //
        int iRet = 1;
        boolean checkKey = true;
        long CheckEverySecs = 180;
        long tm = System.currentTimeMillis();

        if (checkKey) {
            if ((tm - tmLastKeyCheck) < (CheckEverySecs * 1000)) {
                checkKey = false;
                iRet = 0;
            }
        } else {
            iRet = 0;
        }

        if (checkKey) {
            // Initialize
            try {
                status = sentinel.RNBOsproFormatPacket(apiPacket, apiPacket.length);
                if (status != 0) {
                    System.err.println("KEYPRO: Driver initialization error occurred:" + status);
                }

                sentinel.RNBOsproReleaseLicense(apiPacket, 0, numLic);
                status = sentinel.RNBOsproInitialize(apiPacket);
                if (status != 0) {
                    System.err.println("KEYPRO: Driver initialization error occurred: " + status);
                } else {
                    isInit = true;
                }

                status = sentinel.RNBOsproFindFirstUnit(apiPacket, devID);

                if (status != 0) {
                    System.err.println("KEYPRO: Could not find key with specified Developer ID. (" + status + ")");
                    iRet = 1;
                } else {
                    // Lettura chiave privata
                    String sRes = "";
                    String pk = "GRUPPOMEDITSNS";
                    int address = 10;
                    char[] btPk = pk.toCharArray();
                    int[] data = new int[1];
                    for (int i = 0; i < btPk.length; i++) {
                        status = sentinel.RNBOsproRead(apiPacket, address + i, data);
                        sRes += (char) data[0];
                    }
                    if (sRes.equals(pk)) {
                        iRet = 0;
                        tmLastKeyCheck = System.currentTimeMillis();
                    } else {
                        iRet = 2;
                    }
                }
            } catch (UnsatisfiedLinkError e) {
                System.err.println("KEYPRO: UnsatisfiedLinkError - Error loading DLL.");
            } catch (Exception ex) {
                System.err.println("KEYPRO: Errore " + ex.getMessage());
            } finally {
                if (isInit) {
                    sentinel.RNBOsproReleaseLicense(apiPacket, 0, numLic);
                }
            }
        }
        return iRet;
    }
}
