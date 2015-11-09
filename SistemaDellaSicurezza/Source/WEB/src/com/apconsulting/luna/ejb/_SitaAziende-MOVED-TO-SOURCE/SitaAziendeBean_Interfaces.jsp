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
<version number="1.0" date="14/01/2004" author="Roman Chumachenko">
<comments>
<comment date="14/01/2004" author="Roman Chumachenko">
<description>SitaAziendeBean_Interfaces.jsp</description>
</comment>
<comment date="29/01/2004" author="Mike Kondratyuk">
<description>Peredelal na FindEX()</description>
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
<%!
// BASE TABLE: ANA_SIT_AZL_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta
public interface  ISitaAziende extends EJBObject {
//   *Require Fields*
//1 COD_SIT_AZL (SitaAziende ID)
    public long getCOD_SIT_AZL();
//2 COD_AZL (reference to Azienda)
    public long getCOD_AZL();
    public void setCOD_AZL_NOM_SIT_AZL(long newCOD_AZL, String newNOM_SIT_AZL);
//3 NOM_SIT_AZL (name)
    public String getNOM_SIT_AZL();
//public  void setNOM_SIT_AZL (String newNOM_SIT_AZL);
//4 IDZ_SIT_AZL (address)
    public String getIDZ_SIT_AZL();
    public void setIDZ_SIT_AZL(String newIDZ_SIT_AZL);
//5 CIT_SIT_AZL ()
    public String getCIT_SIT_AZL();
    public void setCIT_SIT_AZL(String newCIT_SIT_AZL);
    
//   *Not require Fields*
//6 NUM_CIC_SIT_AZL ()
    public String getNUM_CIC_SIT_AZL();
    public void setNUM_CIC_SIT_AZL(String newNUM_CIC_SIT_AZL);
//7 PRV_SIT_AZL (province)
    public String getPRV_SIT_AZL();
    public void setPRV_SIT_AZL(String newPRV_SIT_AZL);
//8 CAP_SIT_AZL (cap cod)
    public String getCAP_SIT_AZL();
    public void setCAP_SIT_AZL(String newCAP_SIT_AZL);
}

//     Home Intrface EJB obiekta
public interface ISitaAziendeHome extends EJBHome {
    public ISitaAziende create(
            long lCOD_AZL,
            String strNOM_SIT_AZL,
            String strIDZ_SIT_AZL,
            String strCIT_SIT_AZL
            ) throws CreateException;
    public ISitaAziende create(
            long lCOD_SIT_AZL,
            long lCOD_AZL,
            String strNOM_SIT_AZL,
            String strIDZ_SIT_AZL,
            String strCIT_SIT_AZL
            ) throws CreateException;
    public  void remove(Object primaryKey);
    public  ISitaAziende findByPrimaryKey(Long primaryKey) throws FinderException;
    public  Collection findAll() throws FinderException;
// opredelenie view metodov
    
    public  Collection getSiteAziendaleByAZLID_View(long AZL_ID);
    
//<report>
    public  Collection getNonEmptySiteAziendaleByAZLID_View(long AZL_ID);
//</report>
    
    public  Collection findEx(long	AZL_ID,
            String NOM_SIT_AZL,
            String IDZ_SIT_AZL,
            String NUM_CIC_SIT_AZL,
            String CIT_SIT_AZL,
            String PRV_SIT_AZL,
            String CAP_SIT_AZL,
            int	iOrderParameter);
}

/*public*/
// view metodi
class SiteAziendaleByAZLID_View implements java.io.Serializable{
    public long COD_SIT_AZL;
    public String NOM_SIT_AZL,IDZ_SIT_AZL,NUM_CIC_SIT_AZL,CAP_SIT_AZL,CIT_SIT_AZL,PRV_SIT_AZL;
}

%>
