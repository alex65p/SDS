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

	function ZAlert(){
	
		this.Success=new Object();
			this.Success.showCreated=showCreated;
			this.Success.showSaved=showSaved;
			this.Success.showDeleted=showDeleted;
                        this.Success.showEnable=showEnable;
			// For Repository
			this.Success.showAllRepositoryImport = showAllRepositoryImport;
			this.Success.showRepositoryImport = showRepositoryImport;
			this.Success.showRepositoryExport = showRepositoryExport;
		this.Error=new Object();
			this.Error.showDublicate=showDublicate;
			this.Error.showDelete=showErrDelete;
                        this.Error.showEnable=showErrEnable;
			this.Error.showDublicateChild=showDublicateChild;
			this.Error.showNotFound=showNotFound;
			this.Error.showCustomError=showCustomError;
                        this.Error.showIntegrityConstraintViolation=showIntegrityConstraintViolation;
                        this.Error.showNotDeterminableError=showNotDeterminableError;
                        this.Error.showGenericError=showGenericError;
                        // For Repository
			this.Error.showErrorRepositoryImport = showErrorRepositoryImport;
			this.Error.showErrorRepositoryExport = showErrorRepositoryExport;
			this.Error.showSaved=alert;
			this.alert=alert;
			this.Error.showSaved=showErrSaved;
			this.showMsg=showMsg;
		return this;
		
		function showCreated(){
                    return alert(arraylng["MSG_0003"]);
		}

		function showSaved(){
                    return alert(arraylng["MSG_0001"]); 
		}
		
		function showDeleted(){
                    return alert(arraylng["MSG_0004"]);
		}
                
                function showEnable(){
                    return alert(arraylng["MSG_0223"]);
		}
		
		function showDublicate(){
                    return alert(arraylng["MSG_0005"]);
		}
                
		function showErrDelete(){
                    return alert(arraylng["MSG_0006"]);	
		}
                
                function showErrEnable(){
                    return alert(arraylng["MSG_0224"]);	
		}
                
		function showDublicateChild(message){
                    return oldAlert(getErrString(arraylng["MSG_0007"], null/*message*/));	
		}
		
		function showNotFound(message){
                    return alert(getErrString(arraylng["MSG_0008"], message));	
		}
                
		function showCustomError(mess, descr){
                    return alert(getErrString(mess, descr));
		}

		function showIntegrityConstraintViolation(message){
                    return alert(arraylng["MSG_0186"]+"\n" + message + "\n\n" + arraylng["MSG_0217"]);
		}
		
		function showNotDeterminableError(){
                    return alert(arraylng["MSG_0218"]+"\n\n" + arraylng["MSG_0217"]);
		}
                
		function showGenericError(message){
                    return alert(arraylng["MSG_0219"]+"\n\n" + message + "\n\n" + arraylng["MSG_0217"]);
		}

                function getErrString(str, strEx){
			if (strEx!=null){
			 str+=":\n";
			 str+=strEx;
			}
			return str;
		}		
		function showErrSaved(){
			return alert(arraylng["MSG_0009"]);	
		} 
		
		function showMsg(msg){
			return alert(""+msg);
		}		
        function showAllRepositoryImport(){
			return alert(arraylng["MSG_0010"]);
//All checked records added from repository succesfully.");
		}
		function showRepositoryImport(number){
			return alert(number + " " + arraylng["MSG_0011"]);
//records added from repository succesfully.");
		}
		function showRepositoryExport(){
			return alert(arraylng["MSG_0012"]);
//This record added to repository succesfully.");
		}
		function showErrorRepositoryImport(){
			return alert(arraylng["MSG_0013"]);
//No records added from repository.");
		}
		function showErrorRepositoryExport(){
			return alert(arraylng["MSG_0014"]);
//Error. No records added to repository.");
		}
	}
    oldAlert = window.alert;
	window.alert = OnAlert;
	
	function OnAlert(str){
		var strAlert = "";
		if (OnAlert.arguments.length>0) {
			strAlert=OnAlert.arguments[0];
			if (strAlert.indexOf("referential integrity violation")!=-1){
				strAlert = arraylng["MSG_0006"];
			}
			else if (strAlert.indexOf("duplicate key")!=-1){
				strAlert = arraylng["MSG_0006"];
			}
			oldAlert(""+strAlert);
		}
		else
			oldAlert("");
	}
	var Alert= new ZAlert();

	//Alert.Success.showCreated();
	//Alert.Error.showDublicate();
