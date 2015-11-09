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

var sortSGZ="asc", sortSCA="";
var curTd=0, curOpen=0, curParent=0;

function orderColumn(nameColumn){
    if (nameColumn=="dsgz") {
        switch (sortSGZ){
            case "asc":
                document.all["SORT_DAT_SGZ"].value=" DESC ";
                document.all["imgDataSegnal"].src="../_images/ORDINE_UP.GIF";
                document.all["imgDataSegnal"].alt="up";
                document.all["imgDataSegnal"].style.display="";
                sortSGZ="desc";
                break;
            case "desc":
                document.all["SORT_DAT_SGZ"].value=" ASC ";
                document.all["imgDataSegnal"].src="../_images/ORDINE_DOWN.gif";
                document.all["imgDataSegnal"].alt="down";
                document.all["imgDataSegnal"].style.display="";
                sortSGZ="asc";
                break;
            case "":
                document.all["SORT_DAT_SGZ"].value=" ASC ";
                document.all["imgDataSegnal"].src="../_images/ORDINE_DOWN.gif";
                document.all["imgDataSegnal"].alt="down";
                document.all["imgDataSegnal"].style.display="";
                sortSGZ="asc";
                break;
        }
        sortSCA="";
        document.all["SORT_DAT_SCA"].value="X";
        document.all["imgDataScad"].style.display="none";
    }
    if (nameColumn=="dsca") {
        switch (sortSCA){
            case "asc":
                document.all["SORT_DAT_SCA"].value=" DESC ";
                document.all["imgDataScad"].src="../_images/ORDINE_UP.GIF";
                document.all["imgDataScad"].alt="up";
                document.all["imgDataScad"].style.display="";
                sortSCA="desc";
                break;
            case "desc":
                document.all["SORT_DAT_SCA"].value=" ASC ";
                document.all["imgDataScad"].src="../_images/ORDINE_DOWN.GIF";
                document.all["imgDataScad"].alt="down";
                document.all["imgDataScad"].style.display="";
                sortSCA="asc";
                break;
            case "":
                document.all["SORT_DAT_SCA"].value=" ASC ";
                document.all["imgDataScad"].src="../_images/ORDINE_DOWN.GIF";
                document.all["imgDataScad"].alt="down";
                document.all["imgDataScad"].style.display="";
                sortSCA="asc";
                break;
        }
        sortSGZ="";
        document.all["SORT_DAT_SGZ"].value="X";
        document.all["imgDataSegnal"].style.display="none";
    }
    document.all["frm1"].submit();
}

function selTrSCH_ADT(count_inp,COD_TR,COD_PARENT){
    if (curTd!=0) {
        document.all["tr"+curTd].className="listTr";
        for (i=1; i<=count_inp; i++){
            document.all['inp'+i+curTd].className="dataInput";
        }
    }
    document.all["tr"+COD_TR].className="dataTrSelected";
    for (i=1; i<=count_inp; i++) document.all['inp'+i+COD_TR].className="dataInputSelected";
    curTd=COD_TR;
    curParent=COD_PARENT;
    ToolBar.Detail.setEnabled(true);
}

function showDetailSCH_ADT(){
    if(curTd!=0 && curParent!=0)
        result=window.showModalDialog('../Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Form.jsp?ID='
            +curTd+'&ID_PARENT='
            +curParent,'','scroll:no;status:no;help:no');
}

function setDAT_SCA(){
    if(document.all["STA_INT"].value=="N"){
        document.all["DAT_SCA_DAL"].value="";
        document.all["DAT_SCA_AL"].value="";
    }
}

function goTab(){
    document.all['SORT_DAT_SCA'].value="X";
    document.all['SORT_DAT_SGZ'].value=" asc ";
    document.all["frm1"].submit();
    curTd=0;
    curOpen=0;
    curParent=0;
}
