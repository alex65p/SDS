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
    <version number="1.0" date="29/01/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="29/01/2004" author="Mike Kondratyuk">
				   Interfaces dlia objecta DocentiCorso
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

  public interface  IDocentiCorso extends EJBObject
  {
  	public long getCOD_DCT_COR();

	public long getCOD_COR();
	public void setCOD_COR(long lCOD_COR);

	public long getCOD_DPD();
	public void setCOD_DPD__COD_AZL__NOM_DCT__DAT_INZ(long lCOD_DPD, long lCOD_AZL, String strNOM_DCT, java.sql.Date dtDAT_INZ);

	public long getCOD_AZL();

	public String getNOM_DCT();

	public java.sql.Date getDAT_INZ();

	public java.sql.Date getDAT_FIE();
	public void setDAT_FIE(java.sql.Date dtDAT_FIE);

	public String getDES_DCT();
	public void setDES_DCT(String strDES_DCT);
  }

  public interface IDocentiCorsoHome extends EJBHome
  {
    public IDocentiCorso create(long lCOD_COR, long lCOD_DPD, long lCOD_AZL, String strNOM_DCT, java.sql.Date dtDAT_INZ) throws CreateException;
    public IDocentiCorso findByPrimaryKey(Long primaryKey) throws  FinderException;
    public Collection findAll() throws FinderException;
    public void remove(Object primaryKey);
	public Collection getDocentiCorso_View(long lCOD_COR);
   	public Collection getCorsoDocenti_VIEW(long lCOD_AZL);//added by Podmasteriev
  }
  
//<ejb-interfaces>



class DocentiCorso_View implements java.io.Serializable 
{
	long			COD_DCT_COR;
	String			NOM_DCT;
	java.sql.Date	DAT_FIE;
	java.sql.Date	DAT_INZ;
}
class CorsoDocenti_VIEW implements java.io.Serializable{
	long			COD_DCT_COR;
	String		NOM_DCT;
}

%>

