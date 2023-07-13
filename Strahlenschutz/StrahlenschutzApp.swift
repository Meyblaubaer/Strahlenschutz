import SwiftUI

@main
struct StrahlenschutzApp: App {
    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Strahlenschutz-App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                NavigationLink(
                    destination: DosisberechnungView(),
                    label: {
                        Text("Dosisberechnung")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                
                NavigationLink(
                    destination: QuadratAbstandsGesetzView(),
                    label: {
                        Text("Quadrat-Abstands-Gesetz")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                    })
                
                NavigationLink(
                    destination: ErweitertesQuadratAbstandsGesetzView(),
                    label: {
                        Text("Erweitertes Quadrat-Abstands-Gesetz")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.orange)
                            .cornerRadius(10)
                    })
                
                NavigationLink(
                    destination: RadioaktiverZerfallView(),
                    label: {
                        Text("Radioaktiver Zerfall")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.purple)
                            .cornerRadius(10)
                    })
            }
            .padding()
            .navigationBarTitle("Start")
        }
    }
}

struct DosisberechnungView: View {
    @State private var doserate: String = ""
    @State private var belichtungszeit: String = ""
    @State private var dosis: String = ""
    @State private var berechnung: String = "Dosis"
    @State private var istZahlentastaturSichtbar = false
    
    let berechnungen = ["Dosis", "Dosisrate", "Belichtungszeit"]
    
    var body: some View {
        VStack {
            Picker(selection: $berechnung, label: Text("Berechnung")) {
                ForEach(berechnungen, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            TextField("Dosisrate (mSv/h)", text: $doserate)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Belichtungszeit (Stunden)", text: $belichtungszeit)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Dosis (mSv)", text: $dosis)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            Button(action: berechnen) {
                Text("Berechnen")
            }
            
            Text("Ergebnis: " + ergebnisAnzeigen())
            
            Button(action: eingabenLöschen) {
                Text("Eingaben löschen")
            }
            
            Button(action: zahlentastaturVerstecken) {
                Text("Zahlentastatur verstecken")
            }
        }
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.istZahlentastaturSichtbar = false
            }
        }
    }
    
    func berechnen() {
        switch berechnung {
        case "Dosis":
            let doserateWert = Double(doserate) ?? 0
            let belichtungszeitWert = Double(belichtungszeit) ?? 0
            let berechneteDosis = doserateWert * belichtungszeitWert
            dosis = String(format: "%.2f", berechneteDosis)
        case "Dosisrate":
            let dosisWert = Double(dosis) ?? 0
            let belichtungszeitWert = Double(belichtungszeit) ?? 0
            let berechneteDosisrate = dosisWert / belichtungszeitWert
            doserate = String(format: "%.2f", berechneteDosisrate)
        case "Belichtungszeit":
            let dosisWert = Double(dosis) ?? 0
            let doserateWert = Double(doserate) ?? 0
            let berechneteBelichtungszeit = dosisWert / doserateWert
            belichtungszeit = String(format: "%.2f", berechneteBelichtungszeit)
        default:
            break
        }
    }
    
    func ergebnisAnzeigen() -> String {
        switch berechnung {
        case "Dosis":
            return "\(dosis) mSv"
        case "Dosisrate":
            return "\(doserate) mSv/h"
        case "Belichtungszeit":
            return "\(belichtungszeit) Stunden"
        default:
            return ""
        }
    }
    
    func eingabenLöschen() {
        doserate = ""
        belichtungszeit = ""
        dosis = ""
    }
    
    func zahlentastaturVerstecken() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        istZahlentastaturSichtbar = false
    }
}

struct QuadratAbstandsGesetzView: View {
    @State private var anfangsIntensität: String = ""
    @State private var entfernung: String = ""
    @State private var endIntensität: String = ""
    @State private var berechnung: String = "Anfangsintensität"
    @State private var istZahlentastaturSichtbar = false
    
    let berechnungen = ["Anfangsintensität", "Entfernung", "Endintensität"]
    
    var body: some View {
        VStack {
            Picker(selection: $berechnung, label: Text("Berechnung")) {
                ForEach(berechnungen, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            TextField("Anfangsintensität", text: $anfangsIntensität)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Entfernung", text: $entfernung)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Endintensität", text: $endIntensität)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            Button(action: berechnen) {
                Text("Berechnen")
            }
            
            Text("Ergebnis: " + ergebnisAnzeigen())
            
            Button(action: eingabenLöschen) {
                Text("Eingaben löschen")
            }
            
            Button(action: zahlentastaturVerstecken) {
                Text("Zahlentastatur verstecken")
            }
        }
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.istZahlentastaturSichtbar = false
            }
        }
    }
    
    func berechnen() {
        switch berechnung {
        case "Anfangsintensität":
            let entfernungWert = Double(entfernung) ?? 0
            let endIntensitätWert = Double(endIntensität) ?? 0
            let berechneteAnfangsIntensität = endIntensitätWert / (entfernungWert * entfernungWert)
            anfangsIntensität = String(format: "%.2f", berechneteAnfangsIntensität)
        case "Entfernung":
            let anfangsIntensitätWert = Double(anfangsIntensität) ?? 0
            let endIntensitätWert = Double(endIntensität) ?? 0
            let berechneteEntfernung = sqrt(endIntensitätWert / anfangsIntensitätWert)
            entfernung = String(format: "%.2f", berechneteEntfernung)
        case "Endintensität":
            let anfangsIntensitätWert = Double(anfangsIntensität) ?? 0
            let entfernungWert = Double(entfernung) ?? 0
            let berechneteEndIntensität = anfangsIntensitätWert * (entfernungWert * entfernungWert)
            endIntensität = String(format: "%.2f", berechneteEndIntensität)
        default:
            break
        }
    }
    
    func ergebnisAnzeigen() -> String {
        switch berechnung {
        case "Anfangsintensität":
            return "\(anfangsIntensität)"
        case "Entfernung":
            return "\(entfernung)"
        case "Endintensität":
            return "\(endIntensität)"
        default:
            return ""
        }
    }
    
    func eingabenLöschen() {
        anfangsIntensität = ""
        entfernung = ""
        endIntensität = ""
    }
    
    func zahlentastaturVerstecken() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        istZahlentastaturSichtbar = false
    }
}

struct ErweitertesQuadratAbstandsGesetzView: View {
    @State private var anfangsIntensität: String = ""
    @State private var entfernung: String = ""
    @State private var endIntensität: String = ""
    @State private var berechnung: String = "Anfangsintensität"
    @State private var istZahlentastaturSichtbar = false
    
    let berechnungen = ["Anfangsintensität", "Entfernung", "Endintensität"]
    
    var body: some View {
        VStack {
            Picker(selection: $berechnung, label: Text("Berechnung")) {
                ForEach(berechnungen, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            TextField("Anfangsintensität", text: $anfangsIntensität)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Entfernung", text: $entfernung)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Endintensität", text: $endIntensität)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            Button(action: berechnen) {
                Text("Berechnen")
            }
            
            Text("Ergebnis: " + ergebnisAnzeigen())
            
            Button(action: eingabenLöschen) {
                Text("Eingaben löschen")
            }
            
            Button(action: zahlentastaturVerstecken) {
                Text("Zahlentastatur verstecken")
            }
        }
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.istZahlentastaturSichtbar = false
            }
        }
    }
    
    func berechnen() {
        switch berechnung {
        case "Anfangsintensität":
            let entfernungWert = Double(entfernung) ?? 0
            let endIntensitätWert = Double(endIntensität) ?? 0
            let berechneteAnfangsIntensität = endIntensitätWert / (entfernungWert * entfernungWert)
            anfangsIntensität = String(format: "%.2f", berechneteAnfangsIntensität)
        case "Entfernung":
            let anfangsIntensitätWert = Double(anfangsIntensität) ?? 0
            let endIntensitätWert = Double(endIntensität) ?? 0
            let berechneteEntfernung = sqrt(endIntensitätWert / anfangsIntensitätWert)
            entfernung = String(format: "%.2f", berechneteEntfernung)
        case "Endintensität":
            let anfangsIntensitätWert = Double(anfangsIntensität) ?? 0
            let entfernungWert = Double(entfernung) ?? 0
            let berechneteEndIntensität = anfangsIntensitätWert * (entfernungWert * entfernungWert)
            endIntensität = String(format: "%.2f", berechneteEndIntensität)
        default:
            break
        }
    }
    
    func ergebnisAnzeigen() -> String {
        switch berechnung {
        case "Anfangsintensität":
            return "\(anfangsIntensität)"
        case "Entfernung":
            return "\(entfernung)"
        case "Endintensität":
            return "\(endIntensität)"
        default:
            return ""
        }
    }
    
    func eingabenLöschen() {
        anfangsIntensität = ""
        entfernung = ""
        endIntensität = ""
    }
    
    func zahlentastaturVerstecken() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        istZahlentastaturSichtbar = false
    }
}

struct RadioaktiverZerfallView: View {
    @State private var anfangsMenge: String = ""
    @State private var zeit: String = ""
    @State private var endMenge: String = ""
    @State private var berechnung: String = "Anfangsmenge"
    @State private var istZahlentastaturSichtbar = false
    
    let berechnungen = ["Anfangsmenge", "Zeit", "Endmenge"]
    
    var body: some View {
        VStack {
            Picker(selection: $berechnung, label: Text("Berechnung")) {
                ForEach(berechnungen, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            TextField("Anfangsmenge", text: $anfangsMenge)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Zeit", text: $zeit)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            TextField("Endmenge", text: $endMenge)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.istZahlentastaturSichtbar = true
                }
            
            Button(action: berechnen) {
                Text("Berechnen")
            }
            
            Text("Ergebnis: " + ergebnisAnzeigen())
            
            Button(action: eingabenLöschen) {
                Text("Eingaben löschen")
            }
            
            Button(action: zahlentastaturVerstecken) {
                Text("Zahlentastatur verstecken")
            }
        }
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.istZahlentastaturSichtbar = false
            }
        }
    }
    
    func berechnen() {
        switch berechnung {
        case "Anfangsmenge":
            let zeitWert = Double(zeit) ?? 0
            let endMengeWert = Double(endMenge) ?? 0
            let berechneteAnfangsmenge = endMengeWert / pow(2, zeitWert)
            anfangsMenge = String(format: "%.2f", berechneteAnfangsmenge)
        case "Zeit":
            let anfangsMengeWert = Double(anfangsMenge) ?? 0
            let endMengeWert = Double(endMenge) ?? 0
            let berechneteZeit = log2(endMengeWert / anfangsMengeWert)
            zeit = String(format: "%.2f", berechneteZeit)
        case "Endmenge":
            let anfangsMengeWert = Double(anfangsMenge) ?? 0
            let zeitWert = Double(zeit) ?? 0
            let berechneteEndmenge = anfangsMengeWert * pow(2, zeitWert)
            endMenge = String(format: "%.2f", berechneteEndmenge)
        default:
            break
        }
    }
    
    func ergebnisAnzeigen() -> String {
        switch berechnung {
        case "Anfangsmenge":
            return "\(anfangsMenge)"
        case "Zeit":
            return "\(zeit)"
        case "Endmenge":
            return "\(endMenge)"
        default:
            return ""
        }
    }
    
    func eingabenLöschen() {
        anfangsMenge = ""
        zeit = ""
        endMenge = ""
    }
    
    func zahlentastaturVerstecken() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        istZahlentastaturSichtbar = false
    }
}

struct StrahlenschutzApp_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

