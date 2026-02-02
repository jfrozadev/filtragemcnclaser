// =====================================================
// FLANGE CONECTOR PARA TUBO DE 150mm
// Caixa de Filtragem - Exaustão
// =====================================================
// Para imprimir: Exportar como STL (F6 depois F7)
// Material sugerido: PETG ou ABS
// Preenchimento: 20-30%
// Paredes: 3-4 perímetros
// =====================================================

// PARÂMETROS AJUSTÁVEIS
tubo_diametro = 150;        // Diâmetro interno do tubo (mm)
tubo_espessura = 2;         // Espessura da parede do conector (mm)
tubo_altura = 40;           // Altura do tubo/bocal (mm)
tubo_folga = 0.5;           // Folga para encaixe (mm)

flange_tamanho = 180;       // Tamanho da base quadrada (mm)
flange_espessura = 4;       // Espessura da base (mm)
flange_raio_canto = 8;      // Raio dos cantos arredondados (mm)

furo_diametro = 5;          // Diâmetro dos furos de fixação (mm)
furo_margem = 12;           // Distância do furo até a borda (mm)

// Opção: tubo interno ou externo
// true = tubo encaixa POR DENTRO do duto (mais comum)
// false = tubo encaixa POR FORA do duto
encaixe_interno = true;

// =====================================================
// CÓDIGO - NÃO MODIFICAR ABAIXO
// =====================================================

$fn = 100; // Resolução dos círculos

// Cálculo do diâmetro do bocal
diametro_bocal = encaixe_interno ? 
    tubo_diametro - tubo_folga : 
    tubo_diametro + tubo_espessura*2 + tubo_folga;

module flange_base() {
    // Base quadrada com cantos arredondados
    difference() {
        // Placa base
        hull() {
            for (x = [flange_raio_canto, flange_tamanho - flange_raio_canto])
                for (y = [flange_raio_canto, flange_tamanho - flange_raio_canto])
                    translate([x, y, 0])
                        cylinder(h = flange_espessura, r = flange_raio_canto);
        }
        
        // Furo central para passagem de ar
        translate([flange_tamanho/2, flange_tamanho/2, -1])
            cylinder(h = flange_espessura + 2, d = tubo_diametro - tubo_espessura*2);
        
        // Furos de fixação nos 4 cantos
        for (x = [furo_margem, flange_tamanho - furo_margem])
            for (y = [furo_margem, flange_tamanho - furo_margem])
                translate([x, y, -1])
                    cylinder(h = flange_espessura + 2, d = furo_diametro);
    }
}

module tubo_bocal() {
    translate([flange_tamanho/2, flange_tamanho/2, flange_espessura]) {
        difference() {
            // Tubo externo
            cylinder(h = tubo_altura, d = diametro_bocal);
            
            // Furo interno
            translate([0, 0, -1])
                cylinder(h = tubo_altura + 2, d = diametro_bocal - tubo_espessura*2);
        }
        
        // Anel de reforço na base
        difference() {
            cylinder(h = 3, d = diametro_bocal + 6);
            translate([0, 0, -1])
                cylinder(h = 5, d = diametro_bocal - tubo_espessura*2);
        }
    }
}

module flange_completa() {
    color("white") {
        flange_base();
        tubo_bocal();
    }
}

// Renderizar
flange_completa();

// Info
echo("=== FLANGE 150mm ===");
echo("Diâmetro do tubo:", tubo_diametro, "mm");
echo("Diâmetro do bocal:", diametro_bocal, "mm");
echo("Base:", flange_tamanho, "x", flange_tamanho, "mm");
echo("Altura total:", flange_espessura + tubo_altura, "mm");
