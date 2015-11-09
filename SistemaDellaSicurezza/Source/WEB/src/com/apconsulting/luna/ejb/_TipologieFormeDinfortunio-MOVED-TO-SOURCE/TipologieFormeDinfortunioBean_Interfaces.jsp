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

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!

//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>
/*
<file>
  <versions>
    <version number="1.0" date="24/01/2004" author="Podmasteriev Alexandr">
	      <comments>
			<comment date="25/01/2004" author="Podmasteriev Alexandr">
				<description>Bean dla tablici tpl_frm_ino_tab</description>
			</comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
//     Remote Intrface EJB obiekta 
public interface ITipologieFormeDinfortunio extends EJBObject 
{
	public long getCOD_TPL_FRM_INO();
  	public String getNOM_TPL_FRM_INO();
  	public void setNOM_TPL_FRM_INO(String newNOM_TPL_FRM_INO);
	public String getTIP_TPL_FRM_INO();
  	public void setTIP_TPL_FRM_INO(String newTIP_TPL_FRM_INO);
}

//     Home Intrface EJB obiekta 
public interface ITipologieFormeDinfortunioHome extends  ITipologieFormeDinfortunio
{
   public ITipologieFormeDinfortunio create(String TIP_TPL_FRM_INO, String NOM_TPL_FRM_INO) throws RemoteException, CreateException;
   public void remove(Object primaryKey);
   public ITipologieFormeDinfortunio findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;
   public Collection findAll() throws RemoteException, FinderException;
   // opredelenie view metodov
   public Collection getTipologieFormeDinfortunio_UserID_View();
   public Collection findEx(String NOM, String DES, long iOrderBy);
}

/*public*/
// view metodi   
class TipologieFormeDinfortunio_UserID_View implements java.io.Serializable{
	public long COD_TPL_FRM_INO;
	public String TIP_TPL_FRM_INO;
	public String NOM_TPL_FRM_INO;
}
class findEx_tpl_ino implements java.io.Serializable{
	public long COD_TPL_FRM_INO;
	public String TIP_TPL_FRM_INO;
	public String NOM_TPL_FRM_INO;
}
//---------------------------------------------------------------------------
%>
