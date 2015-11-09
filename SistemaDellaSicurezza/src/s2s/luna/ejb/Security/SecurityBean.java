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

package s2s.luna.ejb.Security;

import s2s.ejb.pseudoejb.*;
import s2s.ejb.pseudoejb.BMPEntityBean.*;

import java.sql.*;
import javax.ejb.*;
import java.util.*;

import s2s.luna.ejb.Security.Security.*;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */


public class SecurityBean extends BMPEntityBean implements ISecurity, ISecurityHome
{
  public static final String BEAN_NAME="SecurityBean";

          public static final String LICENSE_PERMISSIONS=
                  "1,2,3,4,5,6,7,8,9,12,13,14,15,16,18,19,20,21,22,23,24,25,26,"
                  + "27,28,29,31,32,34,38,39,40,41,42,43,44,45,46,47,48,49,50,"
                  + "51,52,53,54,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,"
                  + "71,72,73,74,75,76,78,79,80,81,82,83,84,85,86,87,88,89,90,"
                  + "91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,"
                  + "107,108,109,110,111,112,113,114,115,116,117,118,119,120,"
                  + "121,124,125,126,127,128,129,130,131,132,133,134,135,136,"
                  + "137,138,139,140,141,142,143,144,145,146,147,148,149,150,"
                  + "151,152,152,153,154";

          public SecurityBean(){}

          public void ejbRemove(){}
          public void ejbLoad(){}
          public void ejbStore(){}

          public void ejbActivate(){}
          public void ejbPassivate(){}

          //-----------------------------------------------------------------------------------------------------------------
          public Collection getUserPermissions(String strUser){
                  return this.ejbGetUserPermissions(strUser);
          }

          public SecurityUserPermissionDetails getUserPermissionDetails(String strUser, String strPermission){
                  return this.ejbGetUserPermissionDetails(strUser, strPermission);
          }

          public SecurityUserPermissionDetails getConsultantPermissionDetails(String strPermission){
                  return this.ejbGetConsultantPermissionDetails(strPermission);
          }

          public Collection getConsultantPermissions(){
                  return this.ejbGetConsultantPermissions();
          }

          public Collection getMultiConsultantPermissions(){
                  return this.ejbGetMultiConsultantPermissions();
          }

          public void setSecurityModule(SecurityModule module){
                  this.ejbSetSecurityModule(module);
          }

          public SecurityModule getSecurityModule(String strName){
                  return this.ejbGetSecurityModule(strName);
          }

          public SecurityUserPermissionDetails  accessModule(String strModule, String strUser){
                  return this.ejbAccessModule(strModule, strUser);
          }
          public Collection getAllPermissions(){
                  return this.ejbGetAllPermissions();
          }

          public void setSecurityContextData(long lContextId, long lCurrentAzienda, String strUser){
                  this.ejbSetSecurityContextData(lContextId, lCurrentAzienda, strUser);
          }

          public int accessObject(long lObjectId, String strUser,  boolean isConsultant){
                  return this.ejbAccessObject(lObjectId, strUser, isConsultant);
          }

          //-----------------------------------------------------------------------------------------------------------------
          public Collection ejbGetAllPermissions(){
            BMPConnection bmp=getConnection();
            try{
              PreparedStatement ps=bmp.prepareStatement(
                      " SELECT DISTINCT "+
                      " 		ana_fuz_tab.cod_fuz, "+
                      " 		ana_fuz_tab.NOM_MSC"+
                      " FROM ana_fuz_tab "+
                      " WHERE not NOM_MSC is null"+
                      " ORDER BY 2"
              );
              ResultSet rs=ps.executeQuery();
             	java.util.ArrayList al=new java.util.ArrayList();
              while(rs.next())
              {
                SecurityUserPermission w= new SecurityUserPermission();
                w.lID=rs.getLong(1);
                w.strName=rs.getString(2);
                al.add(w);
             	}
              return al;
            }
            catch(Exception ex){
            	ex.printStackTrace();
              throw new EJBException(ex);
            }
            finally{bmp.close();}
          }

          protected Hashtable FillPermissions(java.sql.ResultSet rs) throws SQLException{
                  java.util.Hashtable al=new java.util.Hashtable();
                  java.util.Hashtable permitted = new java.util.Hashtable();
                   while(rs.next()){
                                  SecurityUserPermission w= new SecurityUserPermission();
                                  w.lID=rs.getLong(1);
                                  w.strName=rs.getString(2);
                                  w.lID_ASC=rs.getLong(3);
                                  al.put(new Long(w.lID), w);
                  }
                  //all that has a parent;
               for (Enumeration e = al.elements() ; e.hasMoreElements() ;) {
                  SecurityUserPermission w=(SecurityUserPermission)e.nextElement();
                  if(w.lID_ASC==0)
                  {
                  	permitted.put(new Long(w.lID), w);
                  }
                  else
                  {
                    SecurityUserPermission parent = (SecurityUserPermission)al.get(new Long(w.lID_ASC));
                    if(parent!=null)
                    {
                    	permitted.put(new Long(w.lID), w);
                    }
                  }
                }
                return permitted;
          }

		protected Hashtable GetUserPermissions(String strUser){
			BMPConnection bmp=getConnection();
			try{
		    PreparedStatement ps=bmp.prepareStatement(
	        "SELECT aft.cod_fuz, aft.nom_fuz, aft.cod_fuz_asc "+
	        " FROM ANA_FUZ_TAB aft "+
	        " WHERE  "+
	                " (  "+
	                "  aft.COD_FUZ IN ( 10, 11 )  "+
	                "  OR COD_FUZ IN ( "+
	                " 				SELECT fr.COD_FUZ "+
	                " 				FROM RUO_UTN_TAB r, ANA_UTN_TAB u, FUZ_RUO_TAB fr "+
	                " 				WHERE  "+
	                " 					r.COD_UTN=u.COD_UTN AND "+
	                " 					fr.COD_RUO=r.COD_RUO AND "+
	                " 					(not fr.TIP_ACE is null) AND "+
	                " 					fr.TIP_ACE<>' ' AND "+
	                " 					u.USD_UTN=?  "+
	                " 		) "+
	            "  )  "+
	            "      AND COD_FUZ IN ("+LICENSE_PERMISSIONS+")  "+
	        " ORDER BY 3"
			  );
			  ps.setString(1, strUser);
			  long l=System.currentTimeMillis();
				
				return FillPermissions(ps.executeQuery());
			}
			catch(Exception ex){
				ex.printStackTrace();
			  throw new EJBException(ex);
			}
			finally{
				bmp.close();
			}
		}

          public Collection ejbGetUserPermissions(String strUser){
                          Hashtable permitted = GetUserPermissions(strUser);
                          java.util.ArrayList arr= new java.util.ArrayList();
                          for (Enumeration e = permitted.elements() ; e.hasMoreElements() ;) {
                                  SecurityUserPermission w=(SecurityUserPermission)e.nextElement();
                                  arr.add(w);
                          }
                          return arr;
          }
          //-----------------------------------------------------------------------------------------------------------------
          private SecurityUserPermissionDetails ejbGetPermissionDetails(String strUser, long lPermission){
                  BMPConnection bmp=getConnection();
                  try{
                          PreparedStatement ps=bmp.prepareStatement(
                                          " 				SELECT DISTINCT fr.tip_ace "+
                                          " 				FROM RUO_UTN_TAB r, ANA_UTN_TAB u, FUZ_RUO_TAB fr "+
                                          " 				WHERE  "+
                                          " 					r.COD_UTN=u.COD_UTN AND "+
                                          " 					fr.COD_RUO=r.COD_RUO AND "+
                                          " 					(not fr.TIP_ACE is null) AND "+
                                          " 					fr.COD_FUZ=? AND "+
                                          " 					u.USD_UTN=?  "
                          );
                          ps.setString(2, strUser);
                          ps.setLong(1, lPermission);
                          ResultSet rs=ps.executeQuery();
                          SecurityUserPermissionDetails detail=new SecurityUserPermissionDetails();
                    String strTemp=null;
                          while(rs.next()){
                                  strTemp=rs.getString(1);
                                  parseACE(strTemp, detail);
                   }
                    if(strTemp!=null) return detail;
                          else return null;
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
                  finally{bmp.close();}
          }

          public SecurityUserPermissionDetails ejbGetUserPermissionDetails(String strUser, String strFormName){
                  BMPConnection bmp=getConnection();
                  try{
                          PreparedStatement ps=bmp.prepareStatement(
                          " SELECT ana_fuz_tab.nom_fuz, ana_fuz_tab.cod_fuz"+
                          " FROM ana_fuz_tab  "+
                          " WHERE ana_fuz_tab.nom_msc=?"
                          );
                          ps.setString(1, strFormName);
                          ResultSet rs=ps.executeQuery();
                          if(rs.next()){
                                  Hashtable permitted = GetUserPermissions(strUser);
                                  SecurityUserPermission permission=(SecurityUserPermission)permitted.get(new Long(rs.getLong(2)));
                                  if(permission==null) return null;
                                  SecurityUserPermissionDetails details= ejbGetPermissionDetails(strUser, permission.lID);
                                  if(details!=null){
                                          details.lID=permission.lID;
                                          details.strName=permission.strName+"-"+strFormName;
                                  }
                                  return details;
                          }
                          else{
                                  throw new Exception("Permission ["+strFormName+"] is not found");
                          }
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
                  finally{bmp.close();}
          }
          //-----------------------------------------------------------------------------------------------------------------
          void parseACE(String strTemp, SecurityUserPermissionDetails detail){

                  if(strTemp.charAt(0)=='X'){
                          detail.bCanCreate=true;
                  }
                  if(strTemp.charAt(1)=='X'){
                          detail.bCanSave=true;
                          detail.bCanCopyFrom=true;
                  }
                  if(strTemp.charAt(2)=='X'){
                          detail.bCanList=true;
                  }
                  if(strTemp.charAt(3)=='X'){
                          detail.bCanDelete=true;
                  }
                  if(strTemp.charAt(4)=='X'){
                          detail.bCanAssociateCreate=true;
                  }
                  if(strTemp.charAt(5)=='X'){
                          detail.bCanAssociateDelete=true;
                  }
                  if(strTemp.charAt(6)=='X'){
                          detail.bCanPrint=true;
                  }
                  /*
                          7 and 8 -- Return and exit -- always true
                  */

                  if(strTemp.charAt(9)=='X'){
                          detail.bCanDetalize=true;
                  }

                  if(strTemp.charAt(10)=='X'){
                          detail.bCanPrint2=true;
                  }
          }
          //--------------------------------------------------------------------------------------------------------------
          public Hashtable GetConsultantPermissions(){
                  BMPConnection bmp=getConnection();
                  try{
                          PreparedStatement ps=bmp.prepareStatement(
                                  "SELECT aft.cod_fuz, aft.nom_fuz, aft.cod_fuz_asc "+
                                  " FROM ANA_FUZ_TAB aft "+
                                  " WHERE aft.COD_FUZ IN ("+LICENSE_PERMISSIONS+")  "+
                                  " ORDER BY 3"
                          );
                          return FillPermissions(ps.executeQuery());
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
                  finally{bmp.close();}
          }

          //--------------------------------------------------------------------------------------------------------------
          public Collection ejbGetConsultantPermissions(){
                  try{
                   Hashtable permitted=GetConsultantPermissions();
                          java.util.ArrayList arr= new java.util.ArrayList();
                          for (Enumeration e = permitted.elements() ; e.hasMoreElements() ;) {
                                  SecurityUserPermission w=(SecurityUserPermission)e.nextElement();
                                  arr.add(w);
                          }
                          return arr;
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
          }
          //--------------------------------------------------------------------------------------------------------------
          public Collection ejbGetMultiConsultantPermissions(){
                  BMPConnection bmp=getConnection();
                  try{
                          PreparedStatement ps=bmp.prepareStatement(
                                  "SELECT aft.cod_fuz, aft.nom_fuz, aft.cod_fuz_asc "+
                                  " FROM ANA_FUZ_TAB aft "+
                                  " WHERE aft.COD_FUZ IN ("+LICENSE_PERMISSIONS+") "+
                                  " AND ( aft.COD_FUZ IN ( 1, 10, 11, 9, 12, 35, 17 ) OR (aft.COD_FUZ BETWEEN 86 AND 94) OR (aft.COD_FUZ_ASC BETWEEN 86 AND 94) ) "
                          );
                          ResultSet rs=ps.executeQuery();
                          java.util.ArrayList arr= new java.util.ArrayList();
                   while(rs.next()){
                                  SecurityUserPermission w= new SecurityUserPermission();
                                  w.lID=rs.getLong(1);
                                  w.strName=rs.getString(2);
                                  w.lID_ASC=rs.getLong(3);
                                  arr.add(w);
                  }
                          return arr;
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
                  finally{bmp.close();}
          }
          //--------------------------------------------------------------------------------------------------------------
          public SecurityUserPermissionDetails ejbGetConsultantPermissionDetails(String strFormName){
            BMPConnection bmp=getConnection();
            try{
                    PreparedStatement ps=bmp.prepareStatement(
                    " SELECT ana_fuz_tab.nom_fuz, ana_fuz_tab.cod_fuz"+
                    " FROM ana_fuz_tab  "+
                    " WHERE ana_fuz_tab.nom_msc=?"
                    );
                    ps.setString(1, strFormName);
                    ResultSet rs=ps.executeQuery();
                    if(rs.next()){
                            Hashtable permitted = GetConsultantPermissions();

                            SecurityUserPermission permission=(SecurityUserPermission)permitted.get(new Long(rs.getLong(2)));
                            if(permission==null)
                            	return null;
                            SecurityUserPermissionDetails details=new SecurityUserPermissionDetails();
                            details.allow();
                            return details;
                    }
                    else{
                            throw new Exception("Permission ["+strFormName+"] is not found");
                    }
            }
            catch(Exception ex){
            	ex.printStackTrace();
              throw new EJBException(ex);
            }
            finally{
            	bmp.close();
            }
          }
          //--------------------------------------------------------------------------------------------------------------
          public void ejbSetSecurityModule(SecurityModule module){
                  BMPConnection bmp=getConnection();
                  try{
                          {
                                  PreparedStatement ps=bmp.prepareStatement("DELETE FROM SC_MODULES WHERE NAME=?");
                           ps.setString(1,  module.strName);
                           ps.executeUpdate();
                          }
                          if(module.strPermission==null || module.strPermission.equals("")){
                                  return;
                          }
                          PreparedStatement ps=bmp.prepareStatement("INSERT INTO SC_MODULES (ID_MODULE,NAME,PERMISSION,SECURITY_TYPE,REQUIRE_NEW,REQUIRE_SAVE,REQUIRE_LIST,REQUIRE_SEARCH,REQUIRE_DELETE,REQUIRE_ASS_CREATE,REQUIRE_ASS_DELETE,REQUIRE_PRINT,REQUIRE_PRINT2,REQUIRE_RETURN,REQUIRE_DETALIZE,REQUEST) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                  Thread.currentThread().sleep(10);
                                  module.lID=System.currentTimeMillis();
                                  ps.setLong(1, module.lID);
                                  ps.setString(2, module.strName);
                                  ps.setString(3, module.strPermission);
                                  ps.setLong(4, 	module.lType);
                                  ps.setBoolean(5, module.bRequireCreate);
                                  ps.setBoolean(6, module.bRequireSave);
                                  ps.setBoolean(7, module.bRequireList);
                                  ps.setBoolean(8, module.bRequireSearch);
                                  ps.setBoolean(9, module.bRequireDelete);
                                  ps.setBoolean(10, module.bRequireAssociateCreate);
                                  ps.setBoolean(11, module.bRequireAssociateDelete);
                                  ps.setBoolean(12, module.bRequirePrint);
                                  ps.setBoolean(13, module.bRequirePrint2);
                                  ps.setBoolean(14, module.bRequireReturn);
                                  ps.setBoolean(15, module.bRequireDetalize);
                                  ps.setString(16, module.strRequest);
                                  ps.executeUpdate();
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
                  finally{bmp.close();}
          }

          public SecurityModule ejbGetSecurityModule(String strName){
                  BMPConnection bmp=getConnection();
                  try{
                          PreparedStatement ps=bmp.prepareStatement(
                                  " SELECT * FROM SC_MODULES WHERE NAME=?"
                          );
                          ps.setString(1, strName);
                          ResultSet rs=ps.executeQuery();
                   java.util.ArrayList al=new java.util.ArrayList();
                    if(rs.next()){
                                  SecurityModule m= new SecurityModule();
                                  m.lID=rs.getLong("ID_MODULE");
                                  m.strName=strName;
                                  m.lType=rs.getLong("SECURITY_TYPE");
                                  m.strPermission=rs.getString("PERMISSION");

                                  m.bRequireCreate=rs.getBoolean("REQUIRE_NEW");
                                  m.bRequireSave=rs.getBoolean("REQUIRE_SAVE");
                                  m.bRequireList=rs.getBoolean("REQUIRE_LIST");
                                  m.bRequireSearch=rs.getBoolean("REQUIRE_SEARCH");
                                  m.bRequireDelete=rs.getBoolean("REQUIRE_DELETE");

                                  m.bRequireAssociateCreate=rs.getBoolean("REQUIRE_ASS_CREATE");
                                  m.bRequireAssociateDelete=rs.getBoolean("REQUIRE_ASS_DELETE");
                                  m.bRequirePrint=rs.getBoolean("REQUIRE_PRINT");
                                  m.bRequirePrint2=rs.getBoolean("REQUIRE_PRINT2");
                                  m.bRequireReturn=rs.getBoolean("REQUIRE_RETURN");
                                  m.bRequireDetalize=rs.getBoolean("REQUIRE_DETALIZE");
                                  m.strRequest=rs.getString("REQUEST");
                      return m;
                   }
                    //throw new Exception("Module ["+strName+"] isn't found");
                          return null;
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
                  finally{bmp.close();}
          }

          public SecurityUserPermissionDetails  ejbAccessModule(String strModule, String strUser){
                          SecurityModule module=ejbGetSecurityModule(strModule);
                          SecurityUserPermissionDetails details=ejbGetUserPermissionDetails(strUser, module.strPermission);
                          return details;
          }
          //-------------------------------------------------------------------------------------------------------
          public void ejbSetSecurityContextData(long lContextId, long lCurrentAzienda, String strUser){
                  BMPConnection bmp=getConnection();
                  try{
                          {
                                  PreparedStatement ps=bmp.prepareStatement("DELETE FROM SC_CONTEXT WHERE ID_CONTEXT=?");
                                  ps.setLong(1, lContextId);
                                  ps.executeUpdate();
                          }
                          PreparedStatement ps=bmp.prepareStatement("INSERT INTO SC_CONTEXT (ID_CONTEXT,ID_AZIENDA,LOGIN,DATA) VALUES(?,?,?,?)");
                                  ps.setLong(1, lContextId);
                                  ps.setLong(2, lCurrentAzienda);
                                  ps.setString(3, strUser);
                                  ps.setDate(4, new java.sql.Date(System.currentTimeMillis()));
                                  ps.executeUpdate();
                  }
                  catch(Exception ex){
                  	ex.printStackTrace();
                    throw new EJBException(ex);
                  }
                  finally{bmp.close();}
          }
          //------------------------------------------------------------------------------------------------------
          public int ejbAccessObject(long lObjectId, String strUser, boolean isConsultant){
            BMPConnection bmp=getConnection();
            try{
              PreparedStatement ps=null;
              StringBuffer strBuf=new StringBuffer();
              {
                /*
                ps=bmp.prepareStatement(
                        " SELECT sc.ID_AZIENDA FROM SC_OBJECTS sc "+
                        " 	WHERE sc.ID_OBJECT=? "
                );
                */
                
								ps=bmp.prepareStatement("SELECT sc.ID_AZIENDA FROM SC_OBJECTS sc " +
									"WHERE sc.TYPE NOT IN ("+
									"'AgenteMateriale','Ala','AnagCorso','AnagrDocumento','AssMisuraAttivita','AssociativaAgentoChimico','AttivaManutenzione','Azzienda', "+
									"'Capitoli','CategoriaAgeMateriale','CategoriaDocumento','CategoriePreside','CategorioRischio','ChimicoAgento',"+
									"'ClassificazioneAgentiChimici','Collegamenti','CollegamentoInternet','Consultant','Corsi',"+
									"'DipendenteCorsi','DittaEsternaTelefono','Domande',"+
									"'FattoriRischio','Firm','FornitoreTelefono','FraseR','FraseS','FunzioniAziendali',"+
									"'GestioneTabellare',"+
									"'Immobili','IndirizzoPostaElettronica',"+
									"'Lingua',"+
									"'MisurePreventive',"+
									"'NaturaLesione','Nazionalita','NormativeSentenze',"+
									"'OperazioneSvolta','Organi',"+
									"'Paragrafo','Piano','Presidi',"+
									"'RischioFattore','Risposta','Ruoli',"+
									"'SchedeInterventoDPI','SchedeInterventoPSD','SchedeParagrafo','SediLesione','Settori','Simbolo','Sottosettori','StatoFisico',"+
									"'Testimone','TestVerifica','TipologiaCorsi','TipologiaDocumenti','TipologiaDPI','TipologiaMisurePreventive','TipologieAccertamenti',"+
									"'TipologieFormeDinfortunio','TipologieMacchine','TipologieMaccine','TipologieNomativeSentenze','TipologieUnitaOrganizzativa'"+
									") AND sc.ID_OBJECT=?");
                
                ps.setLong(1, lObjectId);

                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                        strBuf.append(rs.getLong(1));
                        strBuf.append(",");
                }
                if(strBuf.length()==0){
                        return ACCESS_OBJECT_NOT_FOUND;
                }
              }

              String strAziende=strBuf.substring(0,strBuf.length()-1);
              if(isConsultant){
                ps=bmp.prepareStatement(
                        "SELECT con.COD_AZL  "+
                        "FROM  "+
                        " 	ana_cou_tab ac, azl_cou_tab con "+
                        "WHERE  "+
                        " 	ac.COD_COU=con.COD_COU "+
                        " 	AND con.COD_AZL IN("+strAziende+") "+
                        " 	AND ac.USD_COU=?"
                );
              }else{
                ps=bmp.prepareStatement(
                        "SELECT utn.COD_AZL "+
                        "FROM "+
                        "	ana_utn_tab utn "+
                        " WHERE "+
                        " 	utn.COD_AZL IN("+strAziende+") "+
                        " 	AND utn.USD_UTN=?  "
                );
              }
              ps.setString(1, strUser);
              ResultSet rs=ps.executeQuery();
              if(!rs.next()){
                      return ACCESS_OBJECT_WRONG_AZIENDA;
              }
              return ACCESS_OBJECT_OK;

            }
            catch(Exception ex){
            	ex.printStackTrace();
              throw new EJBException(ex);
            }
            finally{bmp.close();}
          }
}

