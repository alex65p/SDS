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

<%
/*
<file>
<versions>
<version number="1.0" date="11/10/2007" author="Dario Massaroni">
<comments>
<comment date="11/10/2007" author="Dario Massaroni">
<description>AssociazioneMansioniSAP_S2SBean_Interfaces.jsp</description>
</comment>
</comments>
</version>
</versions>
</file>
*/
%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date"%>
<%!

public interface  IAssociazioneMansioniSAP_S2S extends EJBObject {
// Metodi Get e Set
}

public interface AssociazioneMansioniSAP_S2SHome extends EJBHome {
// Metodi bean (Create, FindAll, Remove, ecc.)
    
// Metodi di business
    public Collection getUO_Mansioni_S2S_View(long COD_AZL);
    public Collection getDipendenti_Mansioni_SAP_View(long COD_AZL);
    public long getDipendenti_Mansioni_SAP_Count(long COD_AZL);
    public int AggiornaAssociazioneSAP_S2S(long ID, long COD_UNI_ORG, long COD_MAN);
}

/*public*/
// view per i metodi di business
class UO_Mansioni_S2S_View implements java.io.Serializable{
    public long COD_UNI_ORG;
    public String NOM_UNI_ORG;
    public long COD_MAN;
    public String NOM_MAN;
}

class Dipendenti_Mansioni_SAP_View implements java.io.Serializable{
    public long ID;
    public long COD_AZL_S2S;
    public long COD_DPD_S2S;
    public String COG_DPD;
    public String NOM_DPD;
    public String COD_UNI_ORG_SAP;
    public String COD_MAN_SAP;
    public String COD_POS_SAP;
    public String DES_UNI_ORG_SAP;
    public String DES_MAN_SAP;
    public String DES_POS_SAP;
    public Date COD_UNI_ORG_SAP_DAT_INI;
    public Date COD_UNI_ORG_SAP_DAT_FIN;
    public Date COD_MAN_SAP_DAT_INI;
    public Date COD_MAN_SAP_DAT_FIN;
    public Date COD_POS_SAP_DAT_INI;
    public Date COD_POS_SAP_DAT_FIN;
    public String DES_LUO_FSC_S2S;
}
%>
