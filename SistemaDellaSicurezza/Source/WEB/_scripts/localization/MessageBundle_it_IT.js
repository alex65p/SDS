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

var arraylng = new Array();

arraylng["MSG_0001"]="Il record � stato salvato correttamente";
arraylng["MSG_0002"]="Domenica";
arraylng["MSG_0003"]="Il record � stato inserito correttamente";
arraylng["MSG_0004"]="Il record selezionato � stato eliminato";
arraylng["MSG_0005"]="Il record gi� esiste";
arraylng["MSG_0006"]="Non � possibile eliminare la riga";
arraylng["MSG_0007"]="L'associazione gi� esiste";
arraylng["MSG_0008"]="La riga non � stata trovata";
arraylng["MSG_0009"]="Il record non pu� essere salvato";
arraylng["MSG_0010"]="Tutte le annotazioni verificate sono aggiunte dal repository con successo";
arraylng["MSG_0011"]="annotazioni sono aggiunte dal repository con successo";
arraylng["MSG_0012"]="Questa annotazione � aggiunta al repository con successo";
arraylng["MSG_0013"]="Nessuna annotazione � aggiunta dal repository";
arraylng["MSG_0014"]="Errore. Nessuna annotazione � aggiunta al repository.";
arraylng["MSG_0015"]="Elimina la riga?";
arraylng["MSG_0016"]="Vuoi eliminare questa riga?";
arraylng["MSG_0017"]="Vuoi eliminare questo lavoratore?";
arraylng["MSG_0018"]="Vuoi eliminare questo consulente?";
arraylng["MSG_0019"]="Vuoi eliminare questa cartella sanitaria?";
arraylng["MSG_0020"]="Vuoi eliminare questa domanda?";
arraylng["MSG_0021"]="Vuoi eliminare questo fornitore?";
arraylng["MSG_0022"]="Vuoi eliminare questa misura?";
arraylng["MSG_0023"]="Vuoi eliminare questa ala?";
arraylng["MSG_0024"]="Vuoi eliminare questa normativa?";
arraylng["MSG_0025"]="Vuoi eliminare questo protocollo sanitario?";
arraylng["MSG_0026"]="Vuoi eliminare questo rischio?";
arraylng["MSG_0027"]="Vuoi eliminare questo rapporto?";
arraylng["MSG_0028"]="Vuoi eliminare questo test di verifica?";
arraylng["MSG_0029"]="Vuoi eliminare questa unit� di sicurezza?";
arraylng["MSG_0030"]="Vuoi eliminare questa attivit� lavorativa?";
arraylng["MSG_0031"]="Vuoi eliminare questa visita di idoneit�?";
arraylng["MSG_0032"]="Vuoi eliminare questa ditta precedente?";
arraylng["MSG_0033"]='ATTENZIONE!\nQuesta operazione assocer� i "Lavoratori/Mansioni SAP" alle "Unit� organizzative/Attivit� lavorative - S2S".\n\nContinuare?';
arraylng["MSG_0034"]="Riportare le modifiche anche alle attivit� lavorative?";
arraylng["MSG_0035"]="Nella condizione di \"modifica della scheda paragrafo\" non puoi selezionare pi� di elemento della lista.\n\nVuoi sostituire la scheda paragrafo attuale con quella selezionata?";
arraylng["MSG_0036"]="Sei sicuro di voler eliminare il record?";
arraylng["MSG_0037"]="La riga � stata aggiunta con successo!";
arraylng["MSG_0038"]="La riga � stata aggiornata con successo!";
arraylng["MSG_0039"]="La riga � stata modificata con successo!";
arraylng["MSG_0040"]="'Num. Punteggio domanda' deve essere >= 'Punteggio minimo per approvazione'";
arraylng["MSG_0041"]="Il campo 'codice fiscale' deve contenere 16 caratteri";
arraylng["MSG_0042"]="Il campo 'provincia' non deve contenere valori numerici";
arraylng["MSG_0043"]="'Codice fiscale' gi� presente in archivio";
arraylng["MSG_0044"]="Misura preventiva DA PARTE DELL'AZIENDA non definita";
arraylng["MSG_0045"]="Dati non presenti per i parametri di ricerca impostati";
arraylng["MSG_0046"]="Creare una scheda di manutenzione ed una di sostituzione.";
arraylng["MSG_0047"]="L'azienda ha gi� dei rischi associati.\nImpossibile modificare la modalit� di calcolo del rischio.";
arraylng["MSG_0048"]="ATTENZIONE!.\n\n� stato raggiunto il numero massimo di aziende gestibili.\nImpossibile aggiungere un'altra azienda.";
arraylng["MSG_0049"]="Non � possibile eliminare la riga!";
arraylng["MSG_0050"]="La riga � stata eliminata con successo";
arraylng["MSG_0051"]="Non � possibile eliminare la riga\n\n";
arraylng["MSG_0052"]="Non � stata apportata nessuna modifica rispetto alla selezione di elementi iniziale.\n\n Effettuare una modifica per proseguire, oppure uscire.";
arraylng["MSG_0053"]="Non � stato possibile inserire la scheda paragrafo.\n\nOperazione annullata.";
arraylng["MSG_0054"]="Selezionare il tipo!";
arraylng["MSG_0055"]="La riga";
arraylng["MSG_0056"]="� stata eliminata con successo!";
arraylng["MSG_0057"]="Non";
arraylng["MSG_0058"]="� possibile eliminare la riga\n\n";
arraylng["MSG_0059"]="Scegliere una unit� organizzativa.";
arraylng["MSG_0060"]="Non � possibile associare una unit� organizzativa a se stessa!";
arraylng["MSG_0061"]="Non � possibile spostare un ramo padre all'interno dei suoi rami figli!";
arraylng["MSG_0062"]="Scegliere una unit� di sicurezza.";
arraylng["MSG_0063"]="Associazione non effettuata!";
arraylng["MSG_0064"]="\n- Selezionare uno o pi� 'Lavoratori/Mansioni SAP'.";
arraylng["MSG_0065"]="\n- Selezionare una 'Unit� organizzativa/Attivit� lavorativa - S2S'.";
arraylng["MSG_0066"]="ATTENZIONE!\nImpossibile proseguire.\n";
arraylng["MSG_0067"]="Associazione effettuata correttamente.";
arraylng["MSG_0068"]="Associazione non effettuata o effettuata in maniera parziale!\n\nNon � stato possibile associare uno o pi� 'dipendenti SAP' alla 'mansione S2S'.\n\nAssociazione gi� esistente!";
arraylng["MSG_0069"]="Non � possibile salvare l'associazione!";
arraylng["MSG_0070"]="Non � possibile aggiungere 'Macchina' ad 'Operazione svolta'!";
arraylng["MSG_0071"]="Non � possibile aggiungere 'Sostanza chimica' ad 'Operazione svolta'!";
arraylng["MSG_0072"]="Non � possibile aggiungere 'Rischio' alle 'Attivit� lavorative' selezionate!";
arraylng["MSG_0073"]="'Data inizio' deve essere inferiore a 'Data fine'!";
arraylng["MSG_0074"]="'Probabilit� dell'evento lesivo' deve essere un valore numerico!";
arraylng["MSG_0075"]="'Entit� danno' deve essere un valore numerico!";
arraylng["MSG_0076"]="'Data segnalazione dal' deve essere inferiore a 'Data segnalazione al'";
arraylng["MSG_0077"]="'Data scadenza dal' deve essere inferiore a 'Data scadenza al'";
arraylng["MSG_0078"]="'Data effettuazione dal' deve essere inferiore a 'Data effettuazione al'";
arraylng["MSG_0079"]="'Data pianificazione dal' deve essere inferiore a 'Data pianificazione al'";
arraylng["MSG_0080"]="Selezionare un record.";
arraylng["MSG_0081"]="'Data revisione dal' deve essere inferiore a 'Data revisione al'";
arraylng["MSG_0082"]="Selezionare il lavoratore iscritto al corso nel tab 'Lavoratori iscritti'.\n\nImpossibile continuare.";
arraylng["MSG_0083"]="Il campo 'Identificativo' deve avere un valore!";
arraylng["MSG_0084"]="Il campo 'Tipologia d'intervento' deve avere un valore!";
arraylng["MSG_0085"]="'Data intervento dal' deve essere inferiore a 'Data intervento al'";
arraylng["MSG_0086"]="'Data rivalutazione dal' deve essere inferiore a 'Data rivalutazione al'";
arraylng["MSG_0087"]="'Data pianificazione visita' deve essere inferiore a 'Data svolgimento visita'!";
arraylng["MSG_0088"]="'Non � possibile salvare l'associazione ";
arraylng["MSG_0089"]="Inserire una stringa da ricercare!";
arraylng["MSG_0090"]="Nessuna stringa corrispondente trovata.";
arraylng["MSG_0091"]="Raggiunta la fine dell'area di ricerca.";
arraylng["MSG_0092"]="corrispondenze trovate.";
arraylng["MSG_0093"]="Sostituire questa occorrenza?";
arraylng["MSG_0094"]="Vuoi eliminare questo record?";
arraylng["MSG_0095"]="Si vuole";
arraylng["MSG_0096"]="per le altre aziende?";
arraylng["MSG_0097"]="Eliminare il record?";
arraylng["MSG_0098"]="il rischio";
arraylng["MSG_0099"]="il protocollo sanitario";
arraylng["MSG_0100"]="la misura di prevenzione e protezione";
arraylng["MSG_0101"]="l'attivit� lavorativa";
arraylng["MSG_0102"]="la macchina/attrezzatura";
arraylng["MSG_0103"]="Si vuole inserire l'associazione per le altre aziende?";
arraylng["MSG_0104"]="Errore! Non � possibile aggiungere una nuova riga.";
arraylng["MSG_0105"]="Prima di creare l'associazione � necessario salvare le informazioni!";
arraylng["MSG_0106"]="Inserire tutti i campi obbligatori.";
arraylng["MSG_0107"]="La data di inizio deve essere minore o uguale alla data di fine.";
arraylng["MSG_0108"]="La data di fine deve essere minore o uguale alla data odierna.";
arraylng["MSG_0109"]="Non � possibile eliminare il record!";
arraylng["MSG_0110"]="I record dei dipendenti sono stati trovati.";
arraylng["MSG_0111"]="Nuova associazione";
arraylng["MSG_0112"]="Modifica associazione";
arraylng["MSG_0113"]="Elimina associazione";
arraylng["MSG_0114"]="Help";
arraylng["MSG_0115"]="Ricerca completata.";
arraylng["MSG_0116"]="Luned�";
arraylng["MSG_0117"]="Marted�";
arraylng["MSG_0118"]="Mercoled�";
arraylng["MSG_0119"]="Gioved�";
arraylng["MSG_0120"]="Venerd�";
arraylng["MSG_0121"]="Sabato";
arraylng["MSG_0122"]="Dom";
arraylng["MSG_0123"]="Lun";
arraylng["MSG_0124"]="Mar";
arraylng["MSG_0125"]="Mer";
arraylng["MSG_0126"]="Gio";
arraylng["MSG_0127"]="Ven";
arraylng["MSG_0128"]="Sab";
arraylng["MSG_0129"]="Gennaio";
arraylng["MSG_0130"]="Febbraio";
arraylng["MSG_0131"]="Marzo";
arraylng["MSG_0132"]="Aprile";
arraylng["MSG_0133"]="Maggio";
arraylng["MSG_0134"]="Giugno";
arraylng["MSG_0135"]="Luglio";
arraylng["MSG_0136"]="Agosto";
arraylng["MSG_0137"]="Settembre";
arraylng["MSG_0138"]="Ottobre";
arraylng["MSG_0139"]="Novembre";
arraylng["MSG_0140"]="Dicembre";
arraylng["MSG_0141"]="Gen";
arraylng["MSG_0142"]="Feb";
arraylng["MSG_0143"]="Mar";
arraylng["MSG_0144"]="Apr";
arraylng["MSG_0145"]="Mag";
arraylng["MSG_0146"]="Giu";
arraylng["MSG_0147"]="Lug";
arraylng["MSG_0148"]="Ago";
arraylng["MSG_0149"]="Set";
arraylng["MSG_0150"]="Ott";
arraylng["MSG_0151"]="Nov";
arraylng["MSG_0152"]="Dic";
arraylng["MSG_0153"]="Informazioni sul calendario";
arraylng["MSG_0154"]="Selezione data:\n";
arraylng["MSG_0155"]="- Usa \xab, \xbb per selezionare l'anno\n";
arraylng["MSG_0156"]="- Usa";
arraylng["MSG_0157"]="per i mesi\n";
arraylng["MSG_0158"]="- Tieni premuto a lungo il mouse per accedere alle funzioni di selezione veloce.";
arraylng["MSG_0159"]="Selezione orario:\n";
arraylng["MSG_0160"]="- Clicca sul numero per incrementarlo\n";
arraylng["MSG_0161"]="- o Shift+click per decrementarlo\n";
arraylng["MSG_0162"]="- o click e sinistra o destra per variarlo.";
arraylng["MSG_0163"]="Anno prec.(clicca a lungo per il men�)";
arraylng["MSG_0164"]="Mese prec. (clicca a lungo per il men�)";
arraylng["MSG_0165"]="Oggi";
arraylng["MSG_0166"]="Pross. mese (clicca a lungo per il men�)";
arraylng["MSG_0167"]="Pross. anno (clicca a lungo per il men�)";
arraylng["MSG_0168"]="Seleziona data";
arraylng["MSG_0169"]="Trascina per spostarlo";
arraylng["MSG_0170"]="(oggi)";
arraylng["MSG_0171"]="Mostra prima";
arraylng["MSG_0172"]="Chiudi";
arraylng["MSG_0173"]="Oggi";
arraylng["MSG_0174"]="(Shift-)Click o trascina per cambiare il valore";
arraylng["MSG_0175"]="set";
arraylng["MSG_0176"]="Ora:";
arraylng["MSG_0177"]="Riportare le modifiche anche alle \"Attivita' lavorative / Luoghi fisici?\"";
arraylng["MSG_0178"]="Specializza";
arraylng["MSG_0179"]='ATTENZIONE!\nQuesta operazione eliminer� dalla lista i "Lavoratori/Mansioni SAP" selezionati, impedendone, tramite questa funzionalit�,\nla futura associazione alle "Unit� organizzative/Attivit� lavorative - S2S".\n\nSar� comunque possibile, in ogni momento, effettuare questa associazione dalla funzionalit� \"Anagrafiche Azienda > Lavoratori - Gestione\"\n\nContinuare?';
arraylng["MSG_0180"]='Eliminazione non effettuata!';
arraylng["MSG_0181"]="Eliminazione effettuata correttamente.";
arraylng["MSG_0182"]="Vuoi eliminare questo contratto/servizio?";
arraylng["MSG_0183"]="Numero massimo di caratteri permessi: ";
arraylng["MSG_0184"]="Numero di caratteri inseriti: ";
arraylng["MSG_0185"]="Testo troppo lungo. Impossibile Proseguire.";
arraylng["MSG_0186"]="Non e' consentito eliminare posizioni correlate ad altre informazioni.\n\nProcedere prima alla�eliminazione delle seguenti correlazioni esistenti:";
arraylng["MSG_0187"]="Questa associazione � attualmente la sola che permette l'accesso al sistema ad un consulente,\neliminandola non sarebbe pi� possibile effettuare l'accesso con questa figura.\n\nOperazione annullata.";
arraylng["MSG_0188"]="Unit� Organizzativa associata a D.V.R.\n\nOperazione annullata.";
arraylng["MSG_0189"]="il luogo fisico";
arraylng["MSG_0190"]="'inserire / modificare'";
arraylng["MSG_0191"]="eliminare";
arraylng["MSG_0192"]="La data di cessazione impostata e' uguale o futura rispetto alla data odierna quindi il nominativo non risulta cessato rimane in nero ed e' gestibile. Quando la data odierna superer� quella imposta, il nominativo diventer� rosso e non sar� pi� modificabile. Salvare?";
arraylng["MSG_0193"]="La data di cessazione impostata e' precedente alla data odierna. Il nominativo diventer� rosso e non sar� pi� modificabile. Salvare?";
arraylng["MSG_0194"]="La data comunicazione deve essere inferiore o uguale alla data odierna.";
arraylng["MSG_0195"]="La data evento deve essere inferiore o uguale alla data odierna.";
arraylng["MSG_0196"]="La data inizio assenza deve essere inferiore o uguale alla data odierna.";
arraylng["MSG_0197"]="La data fine assenza deve essere inferiore o uguale alla data odierna.";
arraylng["MSG_0198"]="La data comunicazione deve essere maggiore o uguale alla data evento.";
arraylng["MSG_0199"]="La data inizio assenza deve essere maggiore o uguale alla data evento.";
arraylng["MSG_0200"]="La data fine assenza deve essere maggiore o uguale alla data comunicazione.";
arraylng["MSG_0201"]="La data fine assenza deve essere maggiore o uguale alla data evento.";
arraylng["MSG_0202"]="La data fine assenza deve essere maggiore o uguale alla data inizio assenza.";
arraylng["MSG_0203"]="Impossibile effettuare l'operazione richiesta.";
arraylng["MSG_0204"]="Errore riscontrato: ";
arraylng["MSG_0205"]="La data emissione deve essere inferiore o uguale alla data protocollo.";
arraylng["MSG_0206"]="Alcuni corsi sono previsti dal:\n - Percorso formativo associato al dipendete\n - Attivit� lavorativa associata al dipendente\nma non ancora previsti per dipendente.\n\nImpossibile aprire il corso selezionato.";
arraylng["MSG_0207"]="Non � possibile associare una unit� di sicurezza a se stessa!\n";
arraylng["MSG_0208"]="La data comunicazione deve essere maggiore o uguale alla data infortunio!\n";
arraylng["MSG_0209"]="La data fine infortunio deve essere maggiore o uguale alla data comunicazione!\n";
arraylng["MSG_0210"]="La data fine infortunio deve essere maggiore o uguale alla data infortunio!\n";
arraylng["MSG_0211"]="La data emissione deve essere inferiore o uguale alla data odierna.";
arraylng["MSG_0212"]="La data protocollo deve essere inferiore o uguale alla data odierna.";
arraylng["MSG_0213"]="La dimensione del file � maggiore del limite massimo consentito.";
arraylng["MSG_0214"]="Il tipo di file non � ammesso.";
arraylng["MSG_0215"]="Prima di procedere assicurarsi di aver eliminato tutte le eventuali associazioni a questo elemento presenti nella relativa maschera di gestione (tab).\nNel caso ci fossero associazioni non direttamente visibili queste verranno mostrare indicandone la tipologia.\n\nSei sicuro di voler eliminare il record?";
arraylng["MSG_0216"]="Prima di procedere assicurarsi di aver eliminato tutte le eventuali associazioni presenti in questa maschera (tab).\nNel caso ci fossero associazioni non direttamente visibili queste verranno mostrare indicandone la tipologia.\n\nSei sicuro di voler eliminare il record?";
arraylng["MSG_0217"]="Impossibile proseguire l'operazione.";
arraylng["MSG_0218"]="Si � verificato un errore di sistema non diversamente determinabile.";
arraylng["MSG_0219"]="Si � verificato il seguente errore:";
arraylng["MSG_0220"]="Sei sicuro di voler eliminare questa impostazione?";
arraylng["MSG_0221"]="ATTENZIONE!! - OPERAZIONE ANNULLATA.\n\nIl percorso del browser \"Firefox\", utilizzato per la navigazione della reportistica, non sembra essere correttamente configurato.\n\n- Aprire la voce di men� \"GESTIONE > OPZIONI\"\n- Consultare l'help ed eseguire nell'ordine i passi indicati.";
arraylng["MSG_0222"]="ATTENZIONE!! - OPERAZIONE ANNULLATA.\n\nIl percorso del browser \"Firefox\" configurato nelle opzioni utente non sembra essere presente sul disco locale.\n\n- Aprire la voce di men� \"GESTIONE > OPZIONI\"\n- Consultare l'help ed eseguire nell'ordine i passi indicati.";
arraylng["MSG_0223"]="Il record selezionato � stato riabilitato";
arraylng["MSG_0224"]="Non � possibile riattivare il record";
arraylng["MSG_0225"]="riattivare il record?";
arraylng["MSG_0226"]="Il campo sesso accetta solo i parametri 'M' o 'F'";