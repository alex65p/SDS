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
  
 //<alex date="14/04/2004">
 //public String addRischioToMacchinaLuogo(long lCOD_AZL,  long lCOD_MAC,  long lCOD_RSO,  String strTPL_CLF_RSO,  java.util.ArrayList AZIENDA_ID,  java.util.ArrayList col_lCOD_LUO_FSC);
 //</alex>

  
  //-------------------------------------------------------------------
  //------- * add rischio to macchina ---------------------------------
   private String addRischioToMacchina( long lCOD_MAC, long lCOD_RSO, long lNEW_COD_AZL,  String strTPL_CLF_RSO, BMPConnection bmp){
  	String res = "";
	try{
		BMPConnection bmpConn= bmp;
		PreparedStatement ps;
		ps=bmpConn.prepareStatement(
		  "select * from rso_mac_tab where cod_mac=? and cod_rso=? and cod_azl=?"
	  	);
		 ps.setLong(1, lCOD_MAC);
		 ps.setLong(2, lCOD_RSO);
		 ps.setLong(3, lNEW_COD_AZL);
   	     ResultSet rs_test=ps.executeQuery();
		 if (rs_test.next()) return res+"record exists";
	
		ps=bmpConn.prepareStatement(
		  "insert into rso_mac_tab (cod_mac, cod_rso, cod_azl, tpl_clf_rso) values (?, ?, ?, ?)"
	  );
	  res+="&nbsp;&nbsp;statement prepared";
	  ps.setLong(1, lCOD_MAC);
	  res+="<br>&nbsp;&nbsp;set cod_sos_chi - "+lCOD_MAC;
	  ps.setLong(2, lCOD_RSO);
	  res+="<br>&nbsp;&nbsp;set cod_rso - "+lCOD_RSO;
	  ps.setLong(3, lNEW_COD_AZL);
	  res+="<br>&nbsp;&nbsp;set newCodAzl - "+lNEW_COD_AZL;
	  ps.setString(4, strTPL_CLF_RSO);
	  res+="<br>&nbsp;&nbsp;set tpl_clf_rso - "+strTPL_CLF_RSO;
	  ps.executeUpdate();
	  res+="<br>&nbsp;&nbsp;&nbsp;...added rischio to sostanza";
	}catch(Exception ex){
		StackTraceElement[] trace = ex.getStackTrace();
		for (int i=0; i<trace.length; i++){
			res+="<br>"+trace[i].toString();
		}
		
		res +="<br>"+ ex.toString()+"..FAILED";
    }
	return res+="...OK<br>";
  }
  
  //-------------------------------------------------------------------
  //-------- * add associations for luoghi fisici list -----------------
 
 private String addRiscToLuoghiList(long lCOD_RSO, long lCOD_AZL, java.util.ArrayList col_lCOD_LUO_FSC, BMPConnection bmp){
	String result="";
	try{
		Iterator it = col_lCOD_LUO_FSC.iterator();
		while( it.hasNext() ){
	  		long cod_luo=((Long)it.next()).longValue();
			result=addLuogoFisiciAssociations(cod_luo, lCOD_AZL, lCOD_RSO, bmp);
			result+="&nbsp;&nbsp;&nbsp;...add rischio to azl- "+ lCOD_AZL +";  cod_luo_fsc - "+cod_luo;
      	}
	}catch(Exception ex){
		result +="<br>&nbsp;&nbsp;&nbsp;..."+ex.toString()+"FAILED";
    }
 	return result + "<br>&nbsp;&nbsp;&nbsp;...OK";
  }
  

  //------- * add associations for luoghi fisici ----------------------
  private String addLuogoFisiciAssociations(long lID_PARENT, long lCOD_AZL, long lCOD_RSO, BMPConnection bmp){
	  ResultSet REC_DPI, REC_COR, REC_PRO_SAN;
	  long CODICE = NEW_ID();
	  //---
	  String NOM_RIL_RSO = "";
	  long PRB_EVE_LES = 0;
	  long ENT_DAN = 0;
	  long STM_NUM_RSO = 0;
	  java.sql.Date DAT_RIL = null;
	  int RFC_VLU_RSO_MES = 0;
	  String res="";
	  long CODICE_DELTA=1;
	  //---
		java.util.Date dt=new java.util.Date();
		java.sql.Date DATE=new java.sql.Date( dt.getTime() );
		long lCUR_DATE=DATE.getTime();
		java.sql.Date SUM_DAT=new java.sql.Date(0L);
	  //---
	  try{
	  	  //---------------REC_DPI-----------------
		  PreparedStatement ps = bmp.prepareStatement(
		  "SELECT a.cod_tpl_dpi FROM dpi_rso_tab a "+
		  "WHERE a.cod_azl = ? AND a.cod_rso = ? ");
	      ps.setLong(1, lCOD_AZL);
		  ps.setLong(2, lCOD_RSO);
		  
	      REC_DPI = ps.executeQuery();
	      ps.clearParameters();
		  
		  //---------------REC_COR------------------
	      ps = bmp.prepareStatement(
		  "SELECT a.cod_cor FROM cor_rso_tab a "+
		  "WHERE a.cod_rso =  ? and  a.cod_azl=? ");
	      ps.setLong(1, lCOD_RSO);
		  ps.setLong(2, lCOD_AZL);
	      REC_COR = ps.executeQuery();
	   	  ps.clearParameters();
		  
		  //---------------REC_PRO_SAN------------------
	      ps = bmp.prepareStatement(
		  "SELECT a.cod_pro_san FROM pro_san_rso_tab a "+
		  "WHERE a.cod_rso = ? and a.cod_azl = ? ");
	      ps.setLong(1, lCOD_RSO);
		  ps.setLong(2, lCOD_AZL);
		  REC_PRO_SAN = ps.executeQuery();
	   	  ps.clearParameters();
		  
		  //----------------RS (rischi)--------------
		  ps=bmp.prepareStatement(
		  "SELECT a.nom_ril_rso, a.prb_eve_les, a.ent_dan, "+
		  "a.stm_num_rso, a.dat_ril, a.rfc_vlu_rso_mes, a.cod_rso "+
	      "FROM ana_rso_tab a "+
	      "WHERE (a.cod_rso =  ? and a.cod_azl=?) ");
	      ps.setLong(1, lCOD_RSO);
		  ps.setLong(2, lCOD_AZL);
	      
		  ResultSet rs=ps.executeQuery();
	   	  ps.clearParameters();
		//----------------------------------
		long DT;
		while (rs.next())
		{
		 	//----------------------------
			ps=bmp.prepareStatement("select * from rso_luo_fsc_tab where cod_rso=? and cod_luo_fsc=? and cod_azl=?");
			ps.setLong(1, lCOD_RSO );
			ps.setLong(2, lID_PARENT );
			ps.setLong(3, lCOD_AZL);
			
			ResultSet rs_test = ps.executeQuery();
			ps.clearParameters();
			if (rs_test.next()) continue;
		 	//------------------------------
	       NOM_RIL_RSO     = rs.getString(1);
	       PRB_EVE_LES     = rs.getLong(2);
	       ENT_DAN         = rs.getLong(3);
	       STM_NUM_RSO     = rs.getLong(4);
	       DAT_RIL         = rs.getDate(5);
	       RFC_VLU_RSO_MES = rs.getInt(6);
	       lCOD_RSO        = rs.getLong(7);
		   //---------------------------------------------
		   ps = bmp.prepareStatement(
		   "INSERT INTO rso_luo_fsc_tab "+
		   "(cod_rso_luo_fsc, "+
		   "cod_luo_fsc, "+
		   "cod_rso, "+
		   "cod_azl, "+
		   "prs_rso, "+
		   "dat_inz, "+
		   "dat_fie, "+
		   "nom_ril_rso, "+
		   "clf_rso, "+
		   "prb_eve_les, "+
		   "ent_dan, "+
		   "stm_num_rso, "+ 
		   "dat_rfc_vlu_rso, "+
		   "sta_rso) "+
		   "VALUES( ?, ?, ?, ?, 'S', ?, NULL, ?, 'PER TUTTI', ?, ?, ?, ?, 'V')"
		   );
		      ps.setLong(1, CODICE+CODICE_DELTA);
		      ps.setLong(2, lID_PARENT);
		      ps.setLong(3, lCOD_RSO);
		      ps.setLong(4, lCOD_AZL);
		      ps.setDate(5, DATE);
		      ps.setString(6, NOM_RIL_RSO);
		      ps.setLong(7, PRB_EVE_LES);
		      ps.setLong(8, ENT_DAN);
		      ps.setLong(9, STM_NUM_RSO);
			  //
			  java.sql.Date S_DAT=new java.sql.Date(lCUR_DATE);
		  	  S_DAT.setMonth( DATE.getMonth() + RFC_VLU_RSO_MES);
		      ps.setDate(10, S_DAT);
		      //
			  ps.executeUpdate();
			  ps.clearParameters();
		  //---
		  while ( REC_DPI.next() )
		  {
	        //-----------------------------------------------
			ps=bmp.prepareStatement("select * from dpi_luo_fsc_tab where cod_tpl_dpi=? and cod_luo_fsc=?");
			ps.setLong(1, REC_DPI.getLong(1));
			ps.setLong(2, lID_PARENT);
			ResultSet rs_test2 = ps.executeQuery();
			ps.clearParameters();
			if (rs_test2.next()) continue;
			//------------------------------------------------
			ps = bmp.prepareStatement(
			"INSERT INTO dpi_luo_fsc_tab (cod_luo_fsc, cod_tpl_dpi, prs_dpi, dat_inz, "+
			"dat_fie) VALUES( ?, ?, 'S', ?, NULL) ");
		    ps.setLong(1, lID_PARENT);
		    ps.setLong(2, REC_DPI.getLong(1) );
		    ps.setDate(3, DATE);
		    ps.executeUpdate();
			ps.clearParameters();
	      }
		  //---
	      while ( REC_COR.next() )
		  {
	      	//-----------------------------------------------
			ps=bmp.prepareStatement("select * from cor_luo_fsc_tab where cod_cor=? and cod_luo_fsc=?");
			ps.setLong(1, REC_COR.getLong(1));
			ps.setLong(2, lID_PARENT);
			ResultSet rs_test2 = ps.executeQuery();
			ps.clearParameters();
			if (rs_test2.next()) continue;
			//------------------------------------------------
		    ps = bmp.prepareStatement(
		    "INSERT INTO cor_luo_fsc_tab "+
	        "(cod_luo_fsc, cod_cor, prs_cor, dat_inz, dat_fie) "+
		    "VALUES( ?, ?, 'S', ?, NULL) ");
	        ps.setLong(1, lID_PARENT);
	        ps.setLong(2, REC_COR.getLong(1) );
	        ps.setDate(3, DATE);
	        ps.executeUpdate();
			ps.clearParameters();
	      }
		  //---
	      while ( REC_PRO_SAN.next() )
		  {
	      	//-----------------------------------------------
			ps=bmp.prepareStatement("select * from pro_san_luo_fsc_tab where cod_pro_san=? and cod_luo_fsc=?");
			ps.setLong(1, REC_PRO_SAN.getLong(1));
			ps.setLong(2, lID_PARENT);
			ResultSet rs_test2 = ps.executeQuery();
			ps.clearParameters();
			if (rs_test2.next()) continue;
			//------------------------------------------------
		    ps = bmp.prepareStatement(
		    "INSERT INTO pro_san_luo_fsc_tab "+
	        "(cod_luo_fsc, cod_pro_san, prs_pro_san, dat_inz, dat_fie) "+
		    "VALUES( ?, ?, 'S', ?, NULL) ");
	        ps.setLong(1, lID_PARENT);
	        ps.setLong(2, REC_PRO_SAN.getLong(1) );
	        ps.setDate(3, DATE);
	        ps.executeUpdate();
			ps.clearParameters();
	      }
		  CODICE_DELTA++;
		}
		//---------------------------------
		rs.close();
		}catch(Exception ex){
			res = ex.toString()+"...FAILED";
	    }
		return res+"OK";
 }
%>
