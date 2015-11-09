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
    <version number="1.0" date="28/01/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="28/01/2004" author="Mike Kondratyuk">
				   Interfaces dlia objecta Corsi
			   </comment>
				 <comment date="25/02/2004" author="Pogrebnoy Yura">
				   removeLUO_FSC_COR, removeGEST_MAN_COR
			   </comment>
			   <comment date="08/03/2004" author="Roman Chumachenko">
				   <description>Views for Reports</description>
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

  public interface  ICorsi extends EJBObject
  {
  	public long getCOD_COR();

	public long getDUR_COR_GOR();
	public void setDUR_COR_GOR(long lDUR_COR_GOR);

	public String getNOM_COR();
	public void setNOM_COR(String strNOM_COR);

	public String getDES_COR();
	public void setDES_COR(String strDES_COR);

	public String getUSO_ATE_FRE_COR();
	public void setUSO_ATE_FRE_COR(String strUSO_ATE_FRE_COR);

	public String getUSO_PTG_COR();
	public void setUSO_PTG_COR(String strUSO_PTG_COR);

	public long getCOD_TPL_COR();
	public void setCOD_TPL_COR(long lCOD_TPL_COR);

	public void removeLUO_FSC_COR();
	public void removeGEST_MAN_COR();
	
	//-----------------------------------------------
	public void addCOD_TES_VRF(long newCOD_TES_VRF);
	public void removeCOD_TES_VRF(long newCOD_TES_VRF);
	public void addCOD_DOC(long newCOD_DOC);  
	public void removeCOD_DOC(long newCOD_DOC);
	/*
  <comment date="08/03/2004" author="Roman Chumachenko">
	<description>Views for Reports</description>
  </comment>*/
  public String getCorsoTipologia();
  public Collection getDocCorsoMateriali_List_View();
  public Collection getDocentiForCorso_List_View();
  public Collection getErogazioneForCorso_List_View(long lCOD_AZL);
  
  //------------------------------------------------------------------
  }

  public interface ICorsiHome extends EJBHome
  {
    public ICorsi create(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR) throws CreateException;
    public ICorsi findByPrimaryKey(Long primaryKey) throws  FinderException;
    public Collection findAll() throws FinderException;
    public void remove(Object primaryKey);
  public Collection getCorsi_All_View();		
	public Collection getTestVerifica_View(long lCOD_COR);
	public Collection getMaterialeCorso_View(long lCOD_COR);
    public Collection getCorsoNome_VIEW(long lCOD_AZL);//added by Podmasteriev

	public Collection findEx(	Long lDUR_COR_GOR,
								String strNOM_COR,
								String strDES_COR,
								int iOrderParameter /*not used for now*/
							);
	}
  
//<ejb-interfaces>
class Corsi_All_View implements java.io.Serializable
			{
			 long   COD_COR;
			 long		DUR_COR_COG;
			 String	NOM_COR;
			 String	DES_COR;
			 long   COD_TPL_COR;
			 String USO_ATE_FRE_COR;
			 String USO_PTG_COR;
			}
	
class TestVerifica_View implements java.io.Serializable{
	long	COD_TES_VRF;
	String	NOM_TES_VRF;
	long 	NUM_MIN_PTG;
	long 	NUM_MAX_PTG;
	long	TOT_DMD;
}
//--------------------------------------------------------
class MaterialeCorso_View implements java.io.Serializable{
	long	COD_DOC;
	String	TIT_DOC;
	java.sql.Date	DAT_REV_DOC;
	String	RSP_DOC;
	String	NOME_FILE;
}
class CorsoNome_VIEW implements java.io.Serializable{
	long	COD_COR;
	String	NOM_COR;
}
// --- REPORTS ---
public class DOC_CorsoMateriali_View implements java.io.Serializable{
    long COD_DOC;
	String TIT_DOC;
	java.sql.Date DAT_REV_DOC;
  }
public class DocentiForCorso_List_View implements java.io.Serializable{
    long COD_DCT_COR;
	String NOM_DCT;
	java.sql.Date DAT_INZ, DAT_FIE;
  }
public class ErogazioneForCorso_List_View implements java.io.Serializable{
	long COD_SCH_EGZ_COR;
	String STA_EGZ_COR;
	java.sql.Date DAT_PIF_EGZ_COR, DAT_EFT_EGZ_COR;
  }

  //----------------------------------------------------------------------
%>
