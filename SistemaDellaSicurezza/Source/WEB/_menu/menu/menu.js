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

//----------DHTML Menu Created using AllWebMenus PRO ver 3.1-#526---------------
//C:\Beatrice 626\nuovo Menu\menu\menu1.awm
var awmMenuName='menu';
var awmLibraryBuild=526;
var awmLibraryPath='/awmData-menu';
var awmImagesPath='/awmData-menu';
var awmSupported=(navigator.appName + navigator.appVersion.substring(0,1)=="Netscape5" || document.all || document.layers || navigator.userAgent.indexOf('Opera')>-1)?1:0;
if (awmAltUrl!='' && !awmSupported) window.location.replace(awmAltUrl);
if (awmSupported){
var awmMenuPath;
if (document.layers) mpi=((document.images['awmMenuPathImg-menu'])?document.images['awmMenuPathImg-menu'].src:document.layers['xawmMenuPathImg-menu'].document.images['awmMenuPathImg-menu'].src); else mpi=document.images['awmMenuPathImg-menu'].src;
awmMenuPath=mpi.substring(0,mpi.length-17);
while (awmMenuPath.search("'")>-1) {awmMenuPath=awmMenuPath.replace("'", "&#39;");}
var nua=navigator.userAgent,scriptNo=(nua.indexOf('Safari')>-1)?7:(nua.indexOf('Gecko')>-1)?2:((document.layers)?3:((nua.indexOf('Opera')>-1)?4:((nua.indexOf('Mac')>-1)?5:((nua.indexOf('Konqueror')>-1)?6:1))));
document.write("<SCRIPT SRC='"+awmMenuPath+awmLibraryPath+"/awmlib"+scriptNo+".js'><\/SCRIPT>");
var n=null;
awmzindex=1000;
}

var awmSubmenusFrame='';
var awmSubmenusFrameOffset;
var awmOptimize=0;

function awmBuildMenu(){
if (awmSupported){
awmImagesColl=['underselect_sub_over.gif',14,12,'animselect.gif',10,10];
awmCreateCSS(1,2,1,'#FFFFFF','#5B5B5B',n,'14px sans-serif',n,'none',2,n,0,4);
awmCreateCSS(0,1,0,n,'#FFF2CC',n,n,n,'outset',2,'#FFF2CC',0,0);
awmCreateCSS(1,2,0,'#000000',n,n,'14px Tahoma',n,'outset',1,n,0,1);
awmCreateCSS(0,2,0,'#000000','#000080',1,'14px Tahoma',n,'outset',1,n,0,1);
awmCreateCSS(0,2,0,'#000000','#008080',1,'14px Tahoma',n,'outset',1,n,0,1);
awmCreateCSS(1,2,0,'#FFFFFF','#5B5B5B',n,'14px sans-serif',n,'none',2,n,0,4);
awmCreateCSS(1,2,0,'#000000',n,n,'14px Tahoma',n,'none',1,n,0,1);
awmCreateCSS(0,2,0,'#000000','#008080',1,'14px Tahoma',n,'none',1,n,0,1);
awmCreateCSS(0,2,0,'#000000','#000080',1,'14px Tahoma',n,'none',1,n,0,1);
awmCreateCSS(0,2,1,'#000000','#000080',1,'14px Tahoma',n,'outset',1,n,0,1);
awmCreateCSS(0,2,1,'#000000','#008080',1,'14px Tahoma',n,'none',1,n,0,1);
var s0=awmCreateMenu(0,0,0,0,1,0,0,0,0,10,250,0,0,1,0,"","",n,1,3,1,0,n,n,100,0); //626 &nbsp

it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[0]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //&nbsp Gestione
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuGestione[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href= 'Form_MULTIAZIENDA/MULTIAZIENDA_View.jsp?_Refresh=1'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuGestione[1]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Accessi
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAccessi[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_COU/ANA_COU_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAccessi[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_UTN/ANA_UTN_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAccessi[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_RUO/ANA_RUO_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[1]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Azienda
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAzienda[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_AZL/ANA_AZL_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAzienda[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href= 'Form_ANA_FOR/ANA_FOR_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAzienda[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_DTE/ANA_DTE_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAzienda[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_CON/TPL_CON_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAzienda[4]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href= 'Form_ANA_DPD/ANA_DPD_View.jsp?_Refresh=1'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuAzienda[5]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); // Distribuzione territoralie
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDistribuzioneTerritorialie[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_SIT_AZL/ANA_SIT_AZL_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDistribuzioneTerritorialie[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_LUO_FSC/ANA_LUO_FSC_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDistribuzioneTerritorialie[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_IMO/ANA_IMO_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDistribuzioneTerritorialie[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_ALA/ANA_ALA_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDistribuzioneTerritorialie[4]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_PNO/ANA_PNO_View.jsp?_Refresh=1'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuAzienda[6]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Organizzazione
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuOrganizzazione[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_UNI_ORG/TPL_UNI_ORG_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuOrganizzazione[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_UNI_ORG/ANA_UNI_ORG_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuOrganizzazione[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_FUZ_AZL/ANA_FUZ_AZL_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuOrganizzazione[4]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_UNI_SIC/ANA_UNI_SIC_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[2]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Attività lavorative
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAttivitaLavorative[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_MAN/ANA_MAN_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAttivitaLavorative[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_OPE_SVO/ANA_OPE_SVO_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[3]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Macchinari
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuMacchinari[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_MAC/TPL_MAC_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuMacchinari[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_MAC/ANA_MAC_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuMacchinari[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[4]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Agenti Chimici
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAgentiChimici[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_FRS_R/ANA_FRS_R_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAgentiChimici[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_FRS_S/ANA_FRS_S_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAgentiChimici[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_CLF_SOS/ANA_CLF_SOS_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAgentiChimici[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_SOS_CHI/ANA_SOS_CHI_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[5]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Rischi
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuRischi[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_CAG_FAT_RSO/CAG_FAT_RSO_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuRischi[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_FAT_RSO/ANA_FAT_RSO_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuRischi[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_RSO/ANA_RSO_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[6]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Strumenti di Controllo dei Rischi
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuStrumenti[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_MIS_PET/ANA_MIS_PET_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuStrumenti[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_View.jsp?_Refresh=1'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuStrumenti[2]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //D.P.I.
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDPI[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_DPI/TPL_DPI_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDPI[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_LOT_DPI/ANA_LOT_DPI_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDPI[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_INR_DPI/SCH_INR_DPI_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[7]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Formazione del Personale
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuFormazione[0]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Corsi
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuCorsi[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_COR/TPL_COR_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuCorsi[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_COR/ANA_COR_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuCorsi[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_EGZ_COR/SCH_EGZ_COR_View.jsp?_Refresh=1'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuFormazione[1]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Test di Verifica
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuTestVerifica[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_TES_VRF/ANA_TES_VRF_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuTestVerifica[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_DMD/ANA_DMD_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuTestVerifica[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_RST/ANA_RST_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuFormazione[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_PCS_FRM/ANA_PCS_FRM_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuFormazione[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_DBT_FRM/SCH_DBT_FRM_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[8]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Verifiche Sanitarie
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSanitarie[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_VST_MED/ANA_VST_MED_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSanitarie[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_VST_IDO/ANA_VST_IDO_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSanitarie[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_CTL_SAN/ANA_CTL_SAN_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSanitarie[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_PRO_SAN/ANA_PRO_SAN_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[9]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Infortuni
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuInfortuni[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_SED_LES/ANA_SED_LES_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuInfortuni[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_NAT_LES/ANA_NAT_LES_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuInfortuni[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_CAG_AGE_MAT/CAG_AGE_MAT_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuInfortuni[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_AGE_MAT/ANA_AGE_MAT_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuInfortuni[4]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_FRM_INO/TPL_FRM_INO_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuInfortuni[5]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_INO/TPL_INO_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuInfortuni[6]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_INO/ANA_INO_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[10]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Presidi Antincendio
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuPresidi[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_CAG_PSD_ACD/CAG_PSD_ACD_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuPresidi[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_PSD_ACD/ANA_PSD_ACD_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuPresidi[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_INR_PSD/SCH_INR_PSD_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[11]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Documenti
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDocumenti[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_DOC/TPL_DOC_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDocumenti[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_CAG_DOC/CAG_DOC_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDocumenti[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_DOC/ANA_DOC_View.jsp?_Refresh=1'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuDocumenti[3]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Normative
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuNormative[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_SET/ANA_SET_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuNormative[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_SOT_SET/ANA_SOT_SET_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuNormative[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_ORN/ANA_ORN_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuNormative[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_TPL_NOR_SEN/TPL_NOR_SEN_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuNormative[4]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_NOR_SEN/ANA_NOR_SEN_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[12]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Verifiche S.P.P.
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSPP[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_INR_ADT/ANA_INR_ADT_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSPP[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_NON_CFO/ANA_NON_CFO_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSPP[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_SGZ/ANA_SGZ_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSPP[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_AZN_CRR_PET/AZN_CRR_PET_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuVerificheSPP[4]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_GEST_AZN_CRR_PET/GEST_AZN_CRR_PET_View.jsp?_Refresh=1'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[13]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Analisi e Controllo
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_VST/SCH_VST_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_MIS_PET/SCH_MIS_PET_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_MIS_PET_AZL/SCH_MIS_PET_AZL_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_INR_ADT/SCH_INR_ADT_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[4]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_COR/SCH_COR_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[5]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_DOC/SCH_DOC_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[6]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_RIV_RSO/SCH_RIV_RSO_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[7]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_ADT/SCH_ADT_View.jsp?_Refresh=1'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[8]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Presidi Antincendio
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuPresidiAntincendio[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_PSD_ACD/SCH_PSD_ACD_View.jsp?_Refresh=1&SCH_PSD_ACD=M'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuPresidiAntincendio[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_PSD_ACD/SCH_PSD_ACD_View.jsp?_Refresh=1&SCH_PSD_ACD=S'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[9]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Macchinari
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuMacchinari2[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_MAC/SCH_MAC_View.jsp?_Refresh=1&FROM=MAN'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuMacchinari2[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_MAC/SCH_MAC_View.jsp?_Refresh=1&FROM=SOS'",n,n);
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuAnalisiControllo[10]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //D.P.I.
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDPI2[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_DPI/SCH_DPI_View.jsp?_Refresh=1&FROM=M'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDPI2[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_SCH_DPI/SCH_DPI_View.jsp?_Refresh=1&FROM=S'",n,n);
it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[14]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //D.V.R.
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDVR[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href= 'Form_ANA_ARE/ANA_ARE_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,8,7,"&nbsp;&nbsp;"+SubMenuDVR[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href= 'Form_ANA_CPL/ANA_CPL_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDVR[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_PRG/ANA_PRG_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDVR[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_DOC_VLU/ANA_DOC_VLU_View.jsp?_Refresh=1'",n,n);

it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[15]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //DUVRI
it=s1.addItemWithImages(6,3,7,"&nbsp;&nbsp;"+SubMenuDUVRI[0]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Contratti/Servizi
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuContrattiServizi[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_CON_SER/ANA_CON_SER_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuContrattiServizi[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_DET_CMT/DET_CMT_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuContrattiServizi[2]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_DET_APL/DET_APL_View.jsp?_Refresh=1'",n,n);
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuContrattiServizi[3]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_CON_SER_SUB_APP/CON_SER_SUB_APP_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuDUVRI[1]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_STP_DUVRI/STP_DUVRI_View.jsp?_Refresh=1'",n,n);


it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[16]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Gestione cantieri
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuGestionecantieri[0]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n,"frameView.document.location.href='Form_ANA_PSC/ANA_PSC_View.jsp?_Refresh=1'",n,n);
var s2=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Anagrafica generale
it=s2.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuAnagraficagenerale[0]+"&nbsp;&nbsp;",n,n,"","",n,n,"frameView.document.location.href='Form_ANA_OPE/ANA_OPE_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuGestionecantieri[1]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n,"frameView.document.location.href='Form_ANA_SOP/ANA_SOP_View.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuGestionecantieri[2]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n,"frameView.document.location.href='Form_ANA_SOP/ANA_SOP_View.jsp?_Refresh=1'",n,n);


it=s0.addItemWithImages(2,3,4,"&nbsp;&nbsp;"+MenuRoot[17]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n);
var s1=it.addSubmenu(0,0,-4,2,0,0,0,1,5,"","",n,1,3,1,0,n,n,100); //Help
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuHelp[0]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n,"frameView.document.location.href='Form_ABOUT/ABOUT.jsp?_Refresh=1'",n,n);
it=s1.addItem(6,3,7,"&nbsp;&nbsp;"+SubMenuHelp[1]+"&nbsp;&nbsp;",n,n,"",n,n,n,0,0,0,0,0,0,"",n,n,n,n,n,"frameView.document.location.href='Form_HELP/HELP.jsp?_Refresh=1'",n,n);


s0.pm.buildMenu();
}}
