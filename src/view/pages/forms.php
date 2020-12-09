<link href="<?=ROOTPATH.'/assets/design/design-form.css'?>" rel="stylesheet">
<h1>Form Page</h1>
<form method="post">
    <fieldset>
        <legend><h3>Kontaktformular</h3></legend>
        <table>
            <th colspan="2">
                <h4>Welche Planungleistung möchten Sie anfragen?*</h4>
            </th>
            <tr>
                <td>
                    <input type="checkbox" name="Dienstleistung" id="Baueingabe">
                    <label for="Baueingabe">Baueingabe</label>
                </td>
                <td>
                    <input type="checkbox" name="Dienstleistung" id="Tragwerksplanung">
                    <label for="Tragwerksplanung">Tragwerksplanung</label>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="checkbox" name="Dienstleistung" id="Energieberechnung">
                    <label for="Energieberechnung">Energieberechnung</label>
                </td>
                <td>
                    <input type="checkbox" name="Dienstleistung" id="Brandschutz">
                    <label for="Brandschutz">Brandschutz</label>
                </td>
            </tr>
            <th colspan="2">
                <h4>Handelt es sich um einen Bestand oder um einen Neubau?</h4>
            </th>
            <tr>
                <td>
                    <input type="radio" name="bestand" id="Bestandsbauwerk">
                    <label for="Bestandsbauwerk">Bestandsbauwerk</label>
                </td>
                <td>
                    <input type="radio" name="bestand" id="Neubauplanung">
                    <label for="Neubauplanung">Neubauplanung</label>
                </td>
            </tr>
            <th colspan="2">
                <h4>Wo befindet sich das Objekt / der Bauort?</h4>
            </th>
            <tr>
                <td>
                    <label>Straße + Hausnummer:</label>
                </td>
                <td>
                    <input type="text" name="strasse" placeholder="Musterstraße, 123">
                </td>
            </tr>
            <tr>
                <td>
                    <label>Baugebiet + Parzellennummer:</label>
                </td>
                <td>
                    <input type="text" name="baugebiet" placeholder="Musterstadt 123456">
                </td>
            </tr>
            <tr>
                <td>
                    <label>PLZ + Ort / Stadt*:</label>
                </td>
                <td>
                    <input type="text" name="stadt" placeholder="12345 Musterdorf">
                </td>
            </tr>
            <th colspan="2">
                <h4>Was soll beplant werden?</h4>
            </th>
            <tr>
                <td>
                    <input type="radio" name="objekt" id="Wohngebäude">
                    <label for="Wohngebäude">Wohngebäude</label>
                </td>
                <td>
                    <input type="radio" name="objekt" id="Einfamilienhaus">
                    <label for="Einfamilienhaus">Einfamilienhaus</label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input type="radio" name="objekt" id="Mehrfamilienhaus">
                    <label for="Mehrfamilienhaus">Mehrfamilienhaus</label>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" name="objekt" id="Planungsleistung">
                    <label for="Planungsleistung">andere Planungsleistung</label>
                </td>
                <td>
                    <input type="text" name="sonderobjekt" placeholder="Sonderleistung...">
                </td>
            </tr>
            <th colspan="2">
                <h4>Kommentare, Anmerkungen</h4>
            </th>
            <tr>
                <td colspan="2">
                    <textarea name="kommentar" cols="50" rows="10" placeholder="Kommentar... "></textarea>
                </td>
            </tr>
        </table>
        <input type="submit" name="sendForm" value="Senden">
    </fieldset>
</form>
