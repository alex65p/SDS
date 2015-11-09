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
    <version number="1.0" date="23/02/2004" author="Treskina Mary">		
      <comments>
			   <comment date="23/02/2004" author="Treskina Mary">
				   Interfaces dlia objecta MansioneDittePrecedente
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="java.util.*"%>

<%!
//<ejb-interfaces description="EJB Interfaces">

public interface IMansioneDittePrecedente extends EJBObject
{
  public long getCOD_MAN_DIT_PRC();

	public String getNOM_MAN_DIT_PRC();
	//public void setNOM_MAN_DIT_PRC(String strNOM_MAN_DIT_PRC);

	public long getCOD_DIT_PRC_DPD();
	//public void setCOD_DIT_PRC_DPD(long lCOD_DIT_PRC_DPD);

	public long getCOD_DPD();
	//public void setCOD_DPD(long lCOD_DPD);
	
	public void setNOM_MAN_DIT_PRC__COD_DIT_PRC_DPD__COD_DPD(String strNOM_MAN_DIT_PRC, long lCOD_DIT_PRC_DPD, long lCOD_DPD);

	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);

	public String getDES_MAN_DIT_PRC();
	public void setDES_MAN_DIT_PRC(String strDES_MAN_DIT_PRC);
  }

  public interface IMansioneDittePrecedenteHome extends EJBHome
  {
     public IMansioneDittePrecedente create(String strNOM_MAN_DIT_PRC, long lCOD_DIT_PRC_DPD, long lCOD_DPD, long lCOD_AZL) throws CreateException;
     public IMansioneDittePrecedente findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
		 
		 // opredelenie view metodov
   public Collection getMansioneDittePrecedenteByDIT_PRC_DPDID_View(long DIT_PRC_DPD_ID);
  }
  
//<ejb-interfaces>

/*public*/

// view metodi  
class MansioneDittePrecedenteByDIT_PRC_DPDID_View implements java.io.Serializable{
	public long COD_MAN_DIT_PRC;
	public String NOM_MAN_DIT_PRC,DESC_MAN_DIT_PRC;
}
%>

