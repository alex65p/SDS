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

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package s2s.ejb.pseudoejb;

import com.apconsulting.luna.ejb.Ala.AlaBean;
import com.apconsulting.luna.ejb.AnaContServ.AnaContServBean;
import com.apconsulting.luna.ejb.AnagrDocumento.AnagrDocumentoBean; 
import com.apconsulting.luna.ejb.AnagrLuoghiFisici.AnagrLuoghiFisiciBean;
import com.apconsulting.luna.ejb.AssMisuraAttivita.AssMisuraAttivitaBean;
import com.apconsulting.luna.ejb.AssRischioAttivita.AssRischioAttivitaBean;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.AssociativaAgentoChimicoBean;
import com.apconsulting.luna.ejb.AttivaManutenzione.AttivaManutenzioneBean;
import com.apconsulting.luna.ejb.AttivitaLavorative.AttivitaLavorativeBean;
import com.apconsulting.luna.ejb.Azienda.AziendaBean;
import com.apconsulting.luna.ejb.AziendaTelefono.AziendaTelefonoBean;
import com.apconsulting.luna.ejb.Capitoli.CapitoliBean;
import com.apconsulting.luna.ejb.CartelleSanitarie.CartelleSanitarieBean;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.CategorioRischioBean;
import com.apconsulting.luna.ejb.CollegamentoInternet.CollegamentoInternetBean;
import com.apconsulting.luna.ejb.Consulente.ConsultantBean;
import com.apconsulting.luna.ejb.Dipendente.DipendenteBean;
import com.apconsulting.luna.ejb.DipendenteCorsi.DipendenteCorsiBean;
import com.apconsulting.luna.ejb.DittaEsterna.DittaEsternaBean;
import com.apconsulting.luna.ejb.FunzioniAziendali.FunzioniAziendaliBean;
import com.apconsulting.luna.ejb.GestioneTabellare.GestioneTabellareBean;
import com.apconsulting.luna.ejb.GestioneVisiteIdoneita.GestioneVisiteIdoneitaBean;
import com.apconsulting.luna.ejb.GestioneVisiteMediche.GestioneVisiteMedicheBean;
import com.apconsulting.luna.ejb.GestioniSezioni.GestioniSezioniBean;
import com.apconsulting.luna.ejb.IndirizzoPostaElettronica.IndirizzoPostaElettronicaBean;
import com.apconsulting.luna.ejb.InterventoAudut.InterventoAudutBean;
import com.apconsulting.luna.ejb.LuogoFisicoRischio.LuogoFisicoRischioBean;
import com.apconsulting.luna.ejb.Macchina.MacchinaBean;
import com.apconsulting.luna.ejb.MisuraPreventiva.MisuraPreventivaBean;
import com.apconsulting.luna.ejb.MisurePreventProtettiveAz.MisurePreventProtettiveAzBean;
import com.apconsulting.luna.ejb.MisurePreventive.MisurePreventiveBean;
import com.apconsulting.luna.ejb.OperazioneSvolta.OperazioneSvoltaBean;
import com.apconsulting.luna.ejb.Paragrafo.ParagrafoBean;
import com.apconsulting.luna.ejb.ProtocoleSanitare.ProtocoleSanitareBean;
import com.apconsulting.luna.ejb.Rischio.RischioBean;
import com.apconsulting.luna.ejb.RischioFattore.RischioFattoreBean;
import com.apconsulting.luna.ejb.Ruoli.RuoliBean;
import com.apconsulting.luna.ejb.RuoliSicurezza.RuoliSicurezzaBean;
import com.apconsulting.luna.ejb.SchedeParagrafo.SchedeParagrafoBean;
import com.apconsulting.luna.ejb.SediAziendali.SitaAziendeBean;
import com.apconsulting.luna.ejb.SediLesione.SediLesioneBean;
import com.apconsulting.luna.ejb.Simbolo.SimboloBean;
import com.apconsulting.luna.ejb.TipologiaContratti.TipologiaContrattiBean;
import com.apconsulting.luna.ejb.TipologiaMisurePreventive.TipologiaMisurePreventiveBean;
import com.apconsulting.luna.ejb.TipologieMacchine.TipologieMacchineBean;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.UnitaOrganizzativaBean;
import com.apconsulting.luna.ejb.UnitaSicurezza.UnitaSicurezzaBean;
import com.apconsulting.luna.ejb.Utente.UtenteBean;
import com.apconsulting.luna.ejb.ValutazioneRischi.ValutazioneRischiBean;
import com.apconsulting.luna.ejb.ErogazioneCorsi.ErogazioneCorsiBean;
import com.apconsulting.luna.ejb.Presidi.PresidiBean;
import com.apconsulting.luna.ejb.GiorniLavorati.GiorniLavoratiBean;
import com.apconsulting.luna.ejb.RischioChimico.RischioChimicoBean;
import com.apconsulting.luna.ejb.SubAppAnalisiRischi.SubAppAnalisiRischiBean;
import com.apconsulting.luna.ejb.TipologiaDPI.TipologiaDPIBean;
import com.apconsulting.luna.ejb.InfortuniIncidenti.InfortuniIncidentiBean;
import com.apconsulting.luna.ejb.Testimone.TestimoneBean;
import com.apconsulting.luna.ejb.NaturaLesione.NaturaLesioneBean;
import com.apconsulting.luna.ejb.AgenteMateriale.AgenteMaterialeBean;
import com.apconsulting.luna.ejb.AnagrAttivitaCantieri.AnagrAttivitaCantieriBean;
import com.apconsulting.luna.ejb.AnagrConstatazioni.AnagrConstatazioniBean;
import com.apconsulting.luna.ejb.AnagrCantieri.AnagrCantieriBean;
import com.apconsulting.luna.ejb.AnagrDisposizioni.AnagrDisposizioniBean;
import com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.AnagrDocumentiGestioneCantieriBean;
import com.apconsulting.luna.ejb.AnagrProcedimento.AnagrProcedimentoBean;
import com.apconsulting.luna.ejb.ContServCentriEmergenza.ContServCentriEmergenzaBean;
import com.apconsulting.luna.ejb.ContServDUVRI.ContServDUVRIBean;
import com.apconsulting.luna.ejb.ContServFluidi.ContServFluidiBean;
import com.apconsulting.luna.ejb.ContServLuoghiEsecuzione.ContServLuoghiEsecuzioneBean;
import com.apconsulting.luna.ejb.ContServServiziSanitari.ContServServiziSanitariBean;
import com.apconsulting.luna.ejb.ContServSubApp.ContServSubAppBean;
import com.apconsulting.luna.ejb.TipologieFormeDinfortunio.TipologieFormeDinfortunioBean;
import com.apconsulting.luna.ejb.NormativeSentenze.NormativeSentenzeBean;
import com.apconsulting.luna.ejb.LottiDPI.LottiDPIBean;
import com.apconsulting.luna.ejb.FattoriRischio.FattoriRischioBean;
import com.apconsulting.luna.ejb.AssociazioneMansioniSAP_S2S.AssociazioneMansioniSAP_S2SBean;
import com.apconsulting.luna.ejb.AppProdottiSostanze.AppProdottiSostanzeBean;
import com.apconsulting.luna.ejb.ArtLegge.ArtLeggeBean;
import com.apconsulting.luna.ejb.AttivitaSegnalazione.AttivitaSegnalazioneBean;
import com.apconsulting.luna.ejb.Corsi.CorsiBean;
import com.apconsulting.luna.ejb.PSC.PSCBean;
import com.apconsulting.luna.ejb.SezioneGenerale.SezioneGeneraleBean;
import com.apconsulting.luna.ejb.Immobili.ImmobiliBean;
import com.apconsulting.luna.ejb.Immobili3lv.Immobili3lvBean;
import com.apconsulting.luna.ejb.Piano.PianoBean;
import com.apconsulting.luna.ejb.SchedediSicurezza.SchedediSicurezzaBean;
import com.apconsulting.luna.ejb.Fascicolo.FascicoloBean;
import com.apconsulting.luna.ejb.SezioneParticolare.SezioneParticolareBean;
import com.apconsulting.luna.ejb.Sopraluogo.SopraluogoBean;
import com.apconsulting.luna.ejb.Procedimento.ProcedimentoBean;
import com.apconsulting.luna.ejb.AnagrOpere.AnagrOpereBean;
import com.apconsulting.luna.ejb.Cantiere.CantiereBean;
import com.apconsulting.luna.ejb.Rapporto.RapportoBean;
import com.apconsulting.luna.ejb.CategoriePreside.CategoriePresideBean;
import com.apconsulting.luna.ejb.Collegamenti.CollegamentiBean;
import com.apconsulting.luna.ejb.Fornitore.FornitoreBean;
import com.apconsulting.luna.ejb.Media.MediaBean;
import com.apconsulting.luna.ejb.Nazionalita.NazionalitaBean;
import com.apconsulting.luna.ejb.AnagrPOS.AnagrPOSBean;
import com.apconsulting.luna.ejb.AzioniCorrectivePreventive.AzioniCorrectivePreventiveBean;
import com.apconsulting.luna.ejb.CategoriaAgeMateriale.CategoriaAgeMaterialeBean;
import com.apconsulting.luna.ejb.CauseInfortuni.CauseInfortuniBean;
import com.apconsulting.luna.ejb.FattoriRischioCantiere.FattoriRischioCantiereBean;
import com.apconsulting.luna.ejb.InfortuniIncidentiCantiere.InfortuniIncidentiCantiereBean;
import com.apconsulting.luna.ejb.NonConformita.NonConformitaBean;
import com.apconsulting.luna.ejb.OpzioniUtilizzatore.OpzioniUtilizzatoreBean;
import com.apconsulting.luna.ejb.PercorsiFormativi.PercorsiFormativiBean;
import com.apconsulting.luna.ejb.RapportiniSegnalazione.RapportiniSegnalazioneBean;
import com.apconsulting.luna.ejb.RischioCantiere.RischioCantiereBean;
import com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione.SchedaAttivitaSegnalazioneBean;
import com.apconsulting.luna.ejb.SchedeInterventoDPI.SchedeInterventoDPIBean;
import com.apconsulting.luna.ejb.SchedeInterventoPSD.SchedeInterventoPSDBean;
import com.apconsulting.luna.ejb.SediLesioneCantiere.SediLesioneCantiereBean;
import com.apconsulting.luna.ejb.TipologiaDocumentiCantiere.TipologiaDocumentiCantiereBean;
import javax.naming.NamingException;
import com.apconsulting.luna.ejb.exception.ExceptionBean;

/**
 *
 * @author Dario
 */
public class PseudoContextContainer {

    private static PseudoContextContainer ys = null;

    private PseudoContextContainer() {
    }

    public static PseudoContextContainer getInstance() {
        if (ys == null) {
            ys = new PseudoContextContainer();
        }
        return ys;
    }

    public void AddAllBean() throws NamingException {
        PseudoContext.bind("ExceptionBean", ExceptionBean.getInstance());
        PseudoContext.bind("AlaBean", AlaBean.getInstance());
        PseudoContext.bind("AssMisuraAttivitaBean", AssMisuraAttivitaBean.getInstance());
        PseudoContext.bind("AssRischioAttivitaBean", AssRischioAttivitaBean.getInstance());
        PseudoContext.bind("AttivitaLavorativeBean", AttivitaLavorativeBean.getInstance());
        PseudoContext.bind("AnaContServBean", AnaContServBean.getInstance());
        PseudoContext.bind("RischioBean", RischioBean.getInstance());
        PseudoContext.bind("RischioCantiereBean", RischioCantiereBean.getInstance());
        PseudoContext.bind("MisuraPreventivaBean", MisuraPreventivaBean.getInstance());
        PseudoContext.bind("GestioneVisiteMedicheBean", GestioneVisiteMedicheBean.getInstance());
        PseudoContext.bind("GestioneVisiteIdoneitaBean", GestioneVisiteIdoneitaBean.getInstance());
        PseudoContext.bind("MisurePreventiveBean", MisurePreventiveBean.getInstance());
        PseudoContext.bind("SchedeParagrafoBean", SchedeParagrafoBean.getInstance());
        PseudoContext.bind("ValutazioneRischiBean", ValutazioneRischiBean.getInstance());
        PseudoContext.bind("DipendenteBean", DipendenteBean.getInstance());
        PseudoContext.bind("OperazioneSvoltaBean", OperazioneSvoltaBean.getInstance());
        PseudoContext.bind("UnitaOrganizzativaBean", UnitaOrganizzativaBean.getInstance());
        PseudoContext.bind("MacchinaBean", MacchinaBean.getInstance());
        PseudoContext.bind("AnagrDocumentoBean", AnagrDocumentoBean.getInstance());
        PseudoContext.bind("AnagrLuoghiFisiciBean", AnagrLuoghiFisiciBean.getInstance());
        PseudoContext.bind("AssociativaAgentoChimicoBean", AssociativaAgentoChimicoBean.getInstance());
        PseudoContext.bind("ProtocoleSanitareBean", ProtocoleSanitareBean.getInstance());
        PseudoContext.bind("RuoliBean", RuoliBean.getInstance());
        PseudoContext.bind("LuogoFisicoRischioBean", LuogoFisicoRischioBean.getInstance());
        PseudoContext.bind("AziendaBean", AziendaBean.getInstance());
        PseudoContext.bind("UtenteBean", UtenteBean.getInstance());
        PseudoContext.bind("FunzioniAziendaliBean", FunzioniAziendaliBean.getInstance());
        PseudoContext.bind("TipologiaMisurePreventiveBean", TipologiaMisurePreventiveBean.getInstance());
        PseudoContext.bind("MisurePreventProtettiveAzBean", MisurePreventProtettiveAzBean.getInstance());
        PseudoContext.bind("InterventoAudutBean", InterventoAudutBean.getInstance());
        PseudoContext.bind("GestioniSezioniBean", GestioniSezioniBean.getInstance());
        PseudoContext.bind("CapitoliBean", CapitoliBean.getInstance());
        PseudoContext.bind("ParagrafoBean", ParagrafoBean.getInstance());
        PseudoContext.bind("GestioneTabellareBean", GestioneTabellareBean.getInstance());
        PseudoContext.bind("DittaEsternaBean", DittaEsternaBean.getInstance());
        PseudoContext.bind("RuoliSicurezzaBean", RuoliSicurezzaBean.getInstance());
        PseudoContext.bind(UnitaSicurezzaBean.BEAN_NAME, UnitaSicurezzaBean.getInstance());
        PseudoContext.bind(TipologiaContrattiBean.BEAN_NAME, TipologiaContrattiBean.getInstance());
        PseudoContext.bind("SitaAziendeBean", SitaAziendeBean.getInstance());
        PseudoContext.bind("AttivaManutenzioneBean", AttivaManutenzioneBean.getInstance());
        PseudoContext.bind(SimboloBean.BEAN_NAME, SimboloBean.getInstance());
        PseudoContext.bind(IndirizzoPostaElettronicaBean.BEAN_NAME, IndirizzoPostaElettronicaBean.getInstance());
        PseudoContext.bind(CollegamentoInternetBean.BEAN_NAME, CollegamentoInternetBean.getInstance());
        PseudoContext.bind("DipendenteCorsiBean", DipendenteCorsiBean.getInstance());
        PseudoContext.bind("TipologieMacchineBean", TipologieMacchineBean.getInstance());
        PseudoContext.bind("CategorioRischioBean", CategorioRischioBean.getInstance());
        PseudoContext.bind("ErogazioneCorsiBean", ErogazioneCorsiBean.getInstance());
        PseudoContext.bind("PresidiBean", PresidiBean.getInstance());
        PseudoContext.bind(RischioFattoreBean.BEAN_NAME, RischioFattoreBean.getInstance());
        PseudoContext.bind("FattoriRischioCantiereBean", FattoriRischioCantiereBean.getInstance());
        PseudoContext.bind("SediLesioneBean", SediLesioneBean.getInstance());
        PseudoContext.bind("SediLesioneCantiereBean", SediLesioneCantiereBean.getInstance());
        PseudoContext.bind("CauseInfortuniBean", CauseInfortuniBean.getInstance());
        PseudoContext.bind("GiorniLavoratiBean", GiorniLavoratiBean.getInstance());
        PseudoContext.bind("RischioChimicoBean", RischioChimicoBean.getInstance());
        PseudoContext.bind(ConsultantBean.BEAN_NAME, ConsultantBean.getInstance());
        PseudoContext.bind("TipologiaDPIBean", TipologiaDPIBean.getInstance());
        PseudoContext.bind("InfortuniIncidentiBean", InfortuniIncidentiBean.getInstance());
        PseudoContext.bind("CartelleSanitarieBean", CartelleSanitarieBean.getInstance());
        PseudoContext.bind("AziendaTelefonoBean", AziendaTelefonoBean.getInstance());
        PseudoContext.bind("SubAppAnalisiRischiBean", SubAppAnalisiRischiBean.getInstance());
        PseudoContext.bind(TestimoneBean.BEAN_NAME, TestimoneBean.getInstance());
        PseudoContext.bind("NaturaLesioneBean", NaturaLesioneBean.getInstance());
        PseudoContext.bind("AgenteMaterialeBean", AgenteMaterialeBean.getInstance());
        PseudoContext.bind("TipologieFormeDinfortunioBean", TipologieFormeDinfortunioBean.getInstance());
        PseudoContext.bind("NormativeSentenzeBean", NormativeSentenzeBean.getInstance());
        PseudoContext.bind("LottiDPIBean", LottiDPIBean.getInstance());
        PseudoContext.bind(FattoriRischioBean.BEAN_NAME, FattoriRischioBean.getInstance());
        PseudoContext.bind(SezioneGeneraleBean.BEAN_NAME, SezioneGeneraleBean.getInstance());
        PseudoContext.bind("SezioneParticolareBean", SezioneParticolareBean.getInstance());
        PseudoContext.bind("SchedediSicurezzaBean", SchedediSicurezzaBean.getInstance());
        PseudoContext.bind("FascicoloBean", FascicoloBean.getInstance());
        PseudoContext.bind("ContServDUVRIBean", ContServDUVRIBean.getInstance());
        PseudoContext.bind("ContServLuoghiEsecuzioneBean", ContServLuoghiEsecuzioneBean.getInstance());
        PseudoContext.bind("ContServSubAppBean", ContServSubAppBean.getInstance());
        PseudoContext.bind("ContServCentriEmergenzaBean", ContServCentriEmergenzaBean.getInstance());
        PseudoContext.bind("ContServServiziSanitariBean", ContServServiziSanitariBean.getInstance());
        PseudoContext.bind("AssociazioneMansioniSAP_S2SBean", AssociazioneMansioniSAP_S2SBean.getInstance());
        PseudoContext.bind("AppProdottiSostanzeBean", AppProdottiSostanzeBean.getInstance());
        PseudoContext.bind("PSCBean", PSCBean.getInstance());
        PseudoContext.bind("AnagrProcedimentoBean", AnagrProcedimentoBean.getInstance());
        PseudoContext.bind("AnagrConstatazioniBean", AnagrConstatazioniBean.getInstance());
        PseudoContext.bind("AnagrDisposizioniBean", AnagrDisposizioniBean.getInstance());
        PseudoContext.bind("AnagrOpereBean", AnagrOpereBean.getInstance());
        PseudoContext.bind("AnagrCantieriBean", AnagrCantieriBean.getInstance());
        PseudoContext.bind(AttivitaSegnalazioneBean.BEAN_NAME, AttivitaSegnalazioneBean.getInstance());
        PseudoContext.bind("ContServFluidiBean", ContServFluidiBean.getInstance());
        PseudoContext.bind("ImmobiliBean", ImmobiliBean.getInstance());
        PseudoContext.bind("PianoBean", PianoBean.getInstance());
        PseudoContext.bind("PianoBean", PianoBean.getInstance());
        PseudoContext.bind("Immobili3lvBean", Immobili3lvBean.getInstance());
        PseudoContext.bind("SopraluogoBean", SopraluogoBean.getInstance());
        PseudoContext.bind("ProcedimentoBean", ProcedimentoBean.getInstance());
        PseudoContext.bind("CantiereBean", CantiereBean.getInstance());
        PseudoContext.bind("RapportoBean", RapportoBean.getInstance());
        PseudoContext.bind("AnagrDocumentiGestioneCantieriBean", AnagrDocumentiGestioneCantieriBean.getInstance());
        PseudoContext.bind("TipologiaDocumentiCantiereBean", TipologiaDocumentiCantiereBean.getInstance());
        PseudoContext.bind(CorsiBean.BEAN_NAME, CorsiBean.getInstance());
        PseudoContext.bind("SchedeInterventoPSDBean", SchedeInterventoPSDBean.getInstance());
        PseudoContext.bind("CategoriePresideBean", CategoriePresideBean.getInstance());
        PseudoContext.bind("ArtLeggeBean", ArtLeggeBean.getInstance());
        PseudoContext.bind("AnagrPOSBean", AnagrPOSBean.getInstance());
        PseudoContext.bind(CollegamentiBean.BEAN_NAME, CollegamentiBean.getInstance());
        PseudoContext.bind("NazionalitaBean", NazionalitaBean.getInstance());
        PseudoContext.bind("MediaBean", MediaBean.getInstance());
        PseudoContext.bind("AnagrAttivitaCantieriBean", AnagrAttivitaCantieriBean.getInstance());
        PseudoContext.bind("FornitoreBean", FornitoreBean.getInstance());
        PseudoContext.bind("InfortuniIncidentiCantiereBean", InfortuniIncidentiCantiereBean.getInstance());
        PseudoContext.bind(SchedaAttivitaSegnalazioneBean.BEAN_NAME, SchedaAttivitaSegnalazioneBean.getInstance());
        PseudoContext.bind(RapportiniSegnalazioneBean.BEAN_NAME, RapportiniSegnalazioneBean.getInstance());
        PseudoContext.bind(NonConformitaBean.BEAN_NAME, NonConformitaBean.getInstance());
        PseudoContext.bind("SchedeInterventoDPIBean", SchedeInterventoDPIBean.getInstance());
        PseudoContext.bind(PercorsiFormativiBean.BEAN_NAME, PercorsiFormativiBean.getInstance());
        PseudoContext.bind("CategoriaAgeMaterialeBean", CategoriaAgeMaterialeBean.getInstance());
        PseudoContext.bind(AzioniCorrectivePreventiveBean.BEAN_NAME, AzioniCorrectivePreventiveBean.getInstance());
        PseudoContext.bind(OpzioniUtilizzatoreBean.BEAN_NAME, OpzioniUtilizzatoreBean.getInstance());
    }
}
