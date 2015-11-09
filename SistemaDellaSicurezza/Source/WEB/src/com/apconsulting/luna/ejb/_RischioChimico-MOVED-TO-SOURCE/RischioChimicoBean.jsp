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
<%@ page import="java.util.*"%>

<%!
public class RischioChimicoBean extends BMPEntityBean implements IRischioChimicoBean
{
  long COD_AZL=0;
  long COD_MAN=0;
  long COD_OPE_SVO=0;
  long COD_SOS_CHI=0;
  long COD_QTA=0;
  long COD_CCP=0;
  long COD_TIP=0;
  long COD_CTR=0;
  long COD_TMP_ESP=0;
  long COD_DIS=0;
  long COD_PTA_FSC=0;
  long COD_ALG=0;
  
  double IDX_RSO_CHI=0;
  double VAL_FRS_R_UNI=0;
  double VAL_FRS_R_INA=0;
  double VAL_FRS_R_CCP=0;

	String TIP_RSO="I";

	boolean isNew=false;
	
	public long getCOD_AZL(){
		return this.COD_AZL;
	}
	public long getCOD_MAN(){
		return this.COD_MAN;
	}
	public void setCOD_MAN(long lCOD_MAN){
		this.COD_MAN = lCOD_MAN;
	}
	public long getCOD_OPE_SVO(){
		return this.COD_OPE_SVO;
	}
	public void setCOD_OPE_SVO(long lCOD_OPE_SVO){
		this.COD_OPE_SVO=lCOD_OPE_SVO;
	}

	public long getCOD_SOS_CHI(){
		return this.COD_SOS_CHI;
	}
	public void setCOD_SOS_CHI(long lCOD_SOS_CHI){
		this.COD_SOS_CHI=lCOD_SOS_CHI;
	}
	public long getCOD_QTA(){
		return this.COD_QTA;
	}
	public void setCOD_QTA(long lCOD_QTA){
		this.COD_QTA=lCOD_QTA;
	}
	public long getCOD_CCP(){
		return this.COD_CCP;
	}
	public void setCOD_CCP(long lCOD_CCP){
		this.COD_CCP=lCOD_CCP;
	}
	public long getCOD_TIP(){
		return this.COD_TIP;
	}
	public void setCOD_TIP(long lCOD_TIP){
		this.COD_TIP = lCOD_TIP;
	}
	public long getCOD_CTR(){
		return this.COD_CTR;
	}
	public void setCOD_CTR(long lCOD_CTR){
		this.COD_CTR=lCOD_CTR;
	}
	public long getCOD_TMP_ESP(){
		return this.COD_TMP_ESP;
	}
	public void setCOD_TMP_ESP(long lCOD_TMP_ESP){
		this.COD_TMP_ESP=lCOD_TMP_ESP;
	}
	public long getCOD_DIS(){
		return this.COD_DIS;
	}
	public void setCOD_DIS(long lCOD_DIS){
		this.COD_DIS=lCOD_DIS;
	}
	public long getCOD_ALG(){
		return this.COD_ALG;
	}
	public void setCOD_ALG(long lCOD_ALG){
		this.COD_ALG=lCOD_ALG;
	}
	public double getIDX_RSO_CHI(){
		return this.IDX_RSO_CHI;
	}

	// IMPLEMENTAZIONE ALGORITMO DI CALCOLO LINEE GUIDA EMILIA ROMAGNA
	public void calcolaIDX(){
		int[][] aMatrix1={ 
			{1,1,1,2,2},
			{1,2,3,3,4},
			{1,3,3,4,4},
			{1,3,4,4,4}};
		int[][] aMatrix2={ 
			{1,1,1,2},
			{1,2,2,3},
			{1,2,3,3},
			{2,3,3,3}};
		int[][] aMatrix3={ 
			{1,1,1,2,2},
			{1,2,2,3,3},
			{1,2,3,3,3}};
		int[][] aMatrix4={ 
			{1,1,3,3,7},
			{1,3,7,7,10},
			{3,7,10,10,10}};
		int[][] aMatrixCCP={ 
			{1,1,3,7},
			{1,3,3,7},
			{1,3,7,10},
			{1,7,7,10}};
		int[][] aMatrixB1={ 
			{1,1,1,2},
			{1,2,2,3},
			{1,2,3,3}};
		int[][] aMatrixB2={ 
			{1,1,3,3,7},
			{1,3,7,7,10},
			{3,7,10,10,10}};

		BMPConnection bmp=getConnection();
		try{
			int VAL_QTA=0;
			int VAL_QTAB=0;
			int VAL_CCP=0;
			int VAL_TIP=0;
			int VAL_CTR=0;
			int VAL_CTRB=0;
			int VAL_TMP=0;
			int VAL_PTA=0;
			double VAL_DIS=0;
			double IDX_Einal=0;
			double IDX_Eccp=0;
			
			IDX_RSO_CHI=-1;
			
		  // RICERCO VALORE PROPRIETA' FISICO-CHIMICA
			PreparedStatement ps=bmp.prepareStatement("Select val_pta From vw_rso_chi_cbx Where cod_cbx='PTA' and cod_pta=?");
			ps.setLong(1, this.COD_PTA_FSC);
		  ResultSet rs=ps.executeQuery();
			if(rs.next()){
				VAL_PTA = (new Double(rs.getDouble(1))).intValue();
			}
		  rs.close();
		  ps.close();

			// RICERCA VALORI PER INALAZIONE
			if( this.COD_ALG == 1 ) // Rischio diretto per la sostanza 
			{
				String sql="";
				sql = "Select val_pta, cod_cbx From vw_rso_chi_cbx where ";
				sql+= " (cod_pta = ? and cod_cbx='QTA') or ";
				sql+= " (cod_pta = ? and cod_cbx='TIP') or ";
				sql+= " (cod_pta = ? and cod_cbx='CTR') or ";
				sql+= " (cod_pta = ? and cod_cbx='TMP') or ";
				sql+= " (cod_pta = ? and cod_cbx='DIS')";
				ps=bmp.prepareStatement(sql);
				ps.setLong(1, this.COD_QTA);
				ps.setLong(2, this.COD_TIP);
				ps.setLong(3, this.COD_CTR);
				ps.setLong(4, this.COD_TMP_ESP);
				ps.setLong(5, this.COD_DIS);
			  rs=ps.executeQuery();
			  while(rs.next())
			  {
			  	String sCbx = rs.getString("cod_cbx");
			  	if(sCbx.equalsIgnoreCase("QTA")) VAL_QTA = (new Double(rs.getDouble("val_pta"))).intValue();
			  	if(sCbx.equalsIgnoreCase("TIP")) VAL_TIP = (new Double(rs.getDouble("val_pta"))).intValue();
			  	if(sCbx.equalsIgnoreCase("CTR")) VAL_CTR = (new Double(rs.getDouble("val_pta"))).intValue();
			  	if(sCbx.equalsIgnoreCase("TMP")) VAL_TMP = (new Double(rs.getDouble("val_pta"))).intValue();
			  	if(sCbx.equalsIgnoreCase("DIS")) VAL_DIS = rs.getDouble("val_pta");
			  }
			  rs.close();
			  ps.close();
                          
				// CALCOLO Einal diretto
				if( VAL_PTA>0 && VAL_QTA>0 && VAL_TIP>0 && VAL_CTR>0 && VAL_TMP>0 )
				{
					int idxD = aMatrix1[ VAL_PTA-1 ][ VAL_QTA-1 ];
					int idxU = aMatrix2[ idxD-1 ][ VAL_TIP-1 ];
					int idxC = aMatrix3[ idxU-1 ][ VAL_CTR-1 ];
					int idxI = aMatrix4[ idxC-1 ][ VAL_TMP-1 ];
	
					// Indice finale
					IDX_Einal = VAL_DIS * idxI;
				}
			}
			else	// Rischio per gli scarti
			{
				String sql="";
				sql = "Select val_pta, cod_cbx From vw_rso_chi_cbx where ";
				sql+= " (cod_pta = ? and cod_cbx='CTRB') or ";
				sql+= " (cod_pta = ? and cod_cbx='QTAB') or ";
				sql+= " (cod_pta = ? and cod_cbx='TMP')";
				ps=bmp.prepareStatement(sql);
				ps.setLong(1, this.COD_CTR);
				ps.setLong(2, this.COD_QTA);
				ps.setLong(3, this.COD_TMP_ESP);
			  rs=ps.executeQuery();
			  while(rs.next())
			  {
			  	String sCbx = rs.getString("cod_cbx");
			  	if(sCbx.equalsIgnoreCase("CTR")) VAL_CTR = (new Double(rs.getDouble("val_pta"))).intValue();
			  	if(sCbx.equalsIgnoreCase("QTA")) VAL_QTA = (new Double(rs.getDouble("val_pta"))).intValue();
			  	if(sCbx.equalsIgnoreCase("TMP")) VAL_TMP = (new Double(rs.getDouble("val_pta"))).intValue();
			  }
			  rs.close();
			  ps.close();

				// CALCOLO Einal scarti
				if( VAL_CTR>0 && VAL_QTA>0 && VAL_TMP>0 )
				{
					int idxC = aMatrix1[ VAL_QTA-1 ][ VAL_CTR-1 ];
					int idxI = aMatrix2[ idxC-1 ][ VAL_TMP-1 ];
	
					// Indice finale
					IDX_Einal = idxI;
				}
			}

			// RICERCA VALORI PER ESPOSIZIONE CUTANEA (CCP)
			if(!this.TIP_RSO.equalsIgnoreCase("I"))
			{
				String sql="";
				sql = "Select val_pta, cod_cbx From vw_rso_chi_cbx where ";
				sql+= " (cod_pta = ? and cod_cbx='CCP') or ";
				sql+= " (cod_pta = ? and cod_cbx='TIP')";
				ps=bmp.prepareStatement(sql);
				ps.setLong(1, this.COD_CCP);
				ps.setLong(2, this.COD_TIP);
			  rs=ps.executeQuery();
			  while(rs.next())
			  {
			  	String sCbx = rs.getString("cod_cbx");
			  	if(sCbx.equalsIgnoreCase("CCP")) VAL_CCP = (new Double(rs.getDouble("val_pta"))).intValue();
			  	if(sCbx.equalsIgnoreCase("TIP")) VAL_TIP = (new Double(rs.getDouble("val_pta"))).intValue();
			  }
			  rs.close();
			  ps.close();

				// CALCOLO Eccp
			  if(VAL_CCP>0 && VAL_TIP>0)
			  {
			  	IDX_Eccp = aMatrixCCP[VAL_TIP-1][VAL_CCP-1];
			  }
		  }
			if( IDX_Einal > IDX_Eccp )
			{
				this.IDX_RSO_CHI = IDX_Einal * this.VAL_FRS_R_UNI;
			}
			else
			{
				this.IDX_RSO_CHI = IDX_Eccp * this.VAL_FRS_R_UNI;
			}
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
		return;
	}

	// Viste foreign keys
	public Collection getQTA_View(long lCOD_ALG){
	  java.util.ArrayList res=new java.util.ArrayList();
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("select * From vw_rso_chi_cbx where cod_cbx=?");
			if( lCOD_ALG == 1 )
				ps.setString(1, "QTA");
			else
				ps.setString(1, "QTAB");
		  ResultSet rs=ps.executeQuery();
			while(rs.next()){
				QTA_View itm = new QTA_View();
				itm.COD_QTA = rs.getLong("cod_pta");
				itm.DES_QTA = rs.getString("des_pta");
	    	res.add(itm);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
  	return res;
	}
	public Collection getCCP_View(){
	  java.util.ArrayList res=new java.util.ArrayList();
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("select * From vw_rso_chi_cbx where cod_cbx='CCP'");
		  ResultSet rs=ps.executeQuery();
			while(rs.next()){
				CCP_View itm = new CCP_View();
				itm.COD_CCP = rs.getLong("cod_pta");
				itm.DES_CCP = rs.getString("des_pta");
	    	res.add(itm);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
  	return res;
	}
	public Collection getTIP_View(){
	  java.util.ArrayList res=new java.util.ArrayList();
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("select * From vw_rso_chi_cbx where cod_cbx='TIP'");
		  ResultSet rs=ps.executeQuery();
			while(rs.next()){
				TIP_View itm = new TIP_View();
				itm.COD_TIP = rs.getLong("cod_pta");
				itm.DES_TIP = rs.getString("des_pta");
	    	res.add(itm);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
  	return res;
	}
	public Collection getCTR_View(long lCOD_ALG){
	  java.util.ArrayList res=new java.util.ArrayList();
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("select * From vw_rso_chi_cbx where cod_cbx=?");
			if( lCOD_ALG == 1 )
				ps.setString(1, "CTR");
			else
				ps.setString(1, "CTRB");
		  ResultSet rs=ps.executeQuery();
			while(rs.next()){
				CTR_View itm = new CTR_View();
				itm.COD_CTR = rs.getLong("cod_pta");
				itm.DES_CTR = rs.getString("des_pta");
	    	res.add(itm);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
  	return res;
	}
	public Collection getTMP_ESP_View(){
	  java.util.ArrayList res=new java.util.ArrayList();
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("select * From vw_rso_chi_cbx where cod_cbx='TMP'");
		  ResultSet rs=ps.executeQuery();
			while(rs.next()){
				TMP_ESP_View itm = new TMP_ESP_View();
				itm.COD_TMP_ESP = rs.getLong("cod_pta");
				itm.DES_TMP_ESP = rs.getString("des_pta");
	    	res.add(itm);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
  	return res;
	}

	public Collection getDIS_View(){
	  java.util.ArrayList res=new java.util.ArrayList();
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("select * From vw_rso_chi_cbx where cod_cbx='DIS'");
		  ResultSet rs=ps.executeQuery();
			while(rs.next()){
				DIS_View itm = new DIS_View();
				itm.COD_DIS = rs.getLong("cod_pta");
				itm.DES_DIS = rs.getString("des_pta");
	    	res.add(itm);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
  	return res;
	}

	public Collection getALG_View(){
	  java.util.ArrayList res=new java.util.ArrayList();
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("Select * From ana_alg_tab order by cod_alg");
		  ResultSet rs=ps.executeQuery();
			while(rs.next()){
				ALG_View itm = new ALG_View();
				itm.COD_ALG = rs.getLong("cod_alg");
				itm.DES_ALG = rs.getString("des_alg");
	    	res.add(itm);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			e.printStackTrace(System.err);
			throw new EJBException(e);
		}
		finally{
			bmp.close();
		}
  	return res;
	}

	// -------
	public void findByPrimaryKey(long lCOD_MAN, long lCOD_OPE_SVO, long lCOD_SOS_CHI)
	{
		//bean.setEntityContext(new EntityContextWrapper(primaryKey));
		this.COD_MAN=lCOD_MAN;
		this.COD_OPE_SVO=lCOD_OPE_SVO;
		this.COD_SOS_CHI=lCOD_SOS_CHI;
		//
  	this.COD_QTA=0;
  	this.COD_CCP=0;
  	this.COD_TIP=0;
  	this.COD_CTR=0;
  	this.COD_TMP_ESP=0;
  	this.COD_DIS=0;
  	this.COD_PTA_FSC=0;
  	this.COD_ALG=0;
  	this.IDX_RSO_CHI=0;
  	this.VAL_FRS_R_UNI=0;
  	this.VAL_FRS_R_INA=0;
  	this.VAL_FRS_R_CCP=0;

		ejbLoad();
	}
	public void store(){
		calcolaIDX();
		ejbStore();
		storeIdxMan(this.COD_MAN);
	}

  public void ejbStore()
  {
		BMPConnection bmp=getConnection();
		PreparedStatement ps;
		try{
			if(isNew)
			{
				ps=bmp.prepareStatement(
					"INSERT INTO rso_chi_tab ("+
					" cod_qta, "+
					" cod_ccp, "+
					" cod_tip, "+
					" cod_ctr, "+
					" cod_tmp_esp, "+
					" cod_dis, "+
					" cod_alg, "+
					" idx_rso_chi, "+
					"cod_man, cod_ope_svo, cod_sos_chi) "+
					"VALUES(?,?,?,?,?,?,?,?,?,?,?)" );
			  ps.setLong(1, this.COD_QTA);
			  ps.setLong(2, this.COD_CCP);
			  ps.setLong(3, this.COD_TIP);
			  ps.setLong(4, this.COD_CTR);
			  ps.setLong(5, this.COD_TMP_ESP);
			  ps.setLong(6, this.COD_DIS);
			  ps.setLong(7, this.COD_ALG);
			  ps.setDouble(8, this.IDX_RSO_CHI);
			  ps.setLong(9, this.COD_MAN);
			  ps.setLong(10, this.COD_OPE_SVO);
			  ps.setLong(11, this.COD_SOS_CHI);
				if(ps.executeUpdate()==0){
					throw new NoSuchEntityException("Rischio Chimico con ID="+this.COD_MAN+","+this.COD_OPE_SVO+","+this.COD_SOS_CHI+" non trovato");
				}
				ps.close();
				isNew=false;
			}
			else
			{
				ps=bmp.prepareStatement(
					"UPDATE rso_chi_tab SET "+
					" cod_qta=?, "+
					" cod_ccp=?, "+
					" cod_tip=?, "+
					" cod_ctr=?, "+
					" cod_tmp_esp=?, "+
					" cod_dis=?, "+
					" cod_alg=?, "+
					" idx_rso_chi=? "+
					"WHERE cod_man=? and cod_ope_svo=? and cod_sos_chi=?");
			  ps.setLong(1, this.COD_QTA);
			  ps.setLong(2, this.COD_CCP);
			  ps.setLong(3, this.COD_TIP);
			  ps.setLong(4, this.COD_CTR);
			  ps.setLong(5, this.COD_TMP_ESP);
			  ps.setLong(6, this.COD_DIS);
			  ps.setLong(7, this.COD_ALG);
			  ps.setDouble(8, this.IDX_RSO_CHI);
			  ps.setLong(9, this.COD_MAN);
			  ps.setLong(10, this.COD_OPE_SVO);
			  ps.setLong(11, this.COD_SOS_CHI);
				if(ps.executeUpdate()==0){
					throw new NoSuchEntityException("Rischio Chimico con ID="+this.COD_MAN+","+this.COD_OPE_SVO+","+this.COD_SOS_CHI+" non trovato");
				}
				ps.close();
			}
		}
		catch(Exception ex){
			ex.printStackTrace(System.err);
			throw new EJBException(ex);
		}
		finally{
			bmp.close();
		}
  }
	public void storeIdxMan(long lpCOD_MAN){
		BMPConnection bmp=getConnection();
		PreparedStatement ps;
		try{
			// Aggiornamento valore indice per L'Attività Lavorativa
			ps=bmp.prepareStatement(
				"UPDATE ana_man_tab SET idx_rso_chi=(select max(idx_rso_chi) From rso_chi_tab where cod_man=?) "+
					"WHERE cod_man=?");
		  ps.setLong(1, lpCOD_MAN);
		  ps.setLong(2, lpCOD_MAN);
			if(ps.executeUpdate()==0){
				throw new NoSuchEntityException("Rischio Chimico con ID="+lpCOD_MAN+" non trovato");
			}
			ps.close();
		}
		catch(Exception ex){
			ex.printStackTrace(System.err);
			throw new EJBException(ex);
		}
		finally{
			bmp.close();
		}
	}

  public void ejbLoad(){
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement(
		  	"SELECT cod_qta, cod_ccp, cod_tip, cod_ctr, "+
		  	"cod_tmp_esp, cod_dis, cod_alg, idx_rso_chi "+
		  	"FROM rso_chi_tab "+
		  	"WHERE cod_man=? and cod_ope_svo=? and cod_sos_chi=?");
		  ps.setLong(1, this.COD_MAN);
		  ps.setLong(2, this.COD_OPE_SVO);
		  ps.setLong(3, this.COD_SOS_CHI);

		  ResultSet rs=ps.executeQuery();
		  if(rs.next()){
	  		this.COD_QTA=rs.getLong(1);
	  		this.COD_CCP=rs.getLong(2);
	  		this.COD_TIP=rs.getLong(3);
	  		this.COD_CTR=rs.getLong(4);
	  		this.COD_TMP_ESP=rs.getLong(5);
	  		this.COD_DIS=rs.getLong(6);
	  		this.COD_ALG=rs.getLong(7);
				this.IDX_RSO_CHI=rs.getDouble(8);
			}
			else{
				isNew=true;
			}
		  rs.close();
		  ps.close();
		  //
			// Cerco valore Proprietà Chimico/Fisico su ANA_SOS_CHI_TAB
			ps=bmp.prepareStatement("Select cod_pta_fsc, tip_rso From ana_sos_chi_tab Where cod_sos_chi=?");
			ps.setLong(1, this.COD_SOS_CHI);
		  rs=ps.executeQuery();
			if(rs.next()){
				this.COD_PTA_FSC = rs.getLong(1);
				this.TIP_RSO = rs.getString(2);
			}
		  rs.close();
		  ps.close();
		  //
		  // 
			ps=bmp.prepareStatement("SELECT cod_azl FROM ana_man_tab WHERE cod_man=?");
		  ps.setLong(1, this.COD_MAN);
		  rs=ps.executeQuery();
		  if(rs.next())
  			this.COD_AZL=rs.getLong(1);
		  rs.close();
		  ps.close();
		  //
		  //
		  String sql="Select val_uni, val_ina, val_ccp from ana_frs_r_tab ";
		  sql+="Where cod_frs_r in (select cod_frs_r from FRS_R_SOS_CHI_TAB where COD_SOS_CHI = ?)";
			ps=bmp.prepareStatement(sql);
		  ps.setLong(1, this.COD_SOS_CHI);

		  rs=ps.executeQuery();
		  while(rs.next()){
			  double v1=rs.getDouble(1);
			  double v2=rs.getDouble(2);
			  double v3=rs.getDouble(3);

  			if(v1>this.VAL_FRS_R_UNI)
			  	this.VAL_FRS_R_UNI=v1;
  			if(v2>this.VAL_FRS_R_INA)
			  	this.VAL_FRS_R_INA=v2;
  			if(v3>this.VAL_FRS_R_CCP)
			  	this.VAL_FRS_R_CCP=v3;
  		}
		  rs.close();
		  ps.close();
		}
		catch(Exception ex){
			ex.printStackTrace(System.err);
		  throw new EJBException(ex);
		}
		finally{
			bmp.close();
		}
  	return;
	}
  public void ejbPassivate(){
		this.COD_MAN=-1;
  	this.COD_OPE_SVO=-1;
  	this.COD_SOS_CHI=-1;
  }
  public void ejbActivate(){
		this.COD_MAN=((Long)this.getEntityKey()).longValue();
  	this.COD_OPE_SVO=((Long)this.getEntityKey()).longValue();
  	this.COD_SOS_CHI=((Long)this.getEntityKey()).longValue();
  }
  public void ejbRemove(){
  	return;
  }

  public String getDescRischio(double idx){
  	String sRes="";
  	if(idx<0.1)
  		sRes="Rischio Nullo";
  	if(idx>=0.1 && idx<15)
  		sRes="Rischio Moderato";
  	if(idx>=15 && idx<21)
  		sRes="Intervallo di incertezza";
  	if(idx>=21 && idx<=40)
  		sRes="Rischio Superiore al Moderato";
  	if(idx>40 && idx<=80)
  		sRes="Zona di rischio elevato";
  	if(idx>80)
  		sRes="Zona di grave rischio";

  	return sRes;
  }
}
%>
<%
/////////////////////////////////////////////////////////////////////////
PseudoContext.bind("RischioChimicoBean", new RischioChimicoBean());//////
/////////////////////////////////////////////////////////////////////////
%>
