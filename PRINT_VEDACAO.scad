// ============================================================
// PRINT: VEDAÇÃO DIVISÓRIA — 8 segmentos
// Frame que envolve borda do MDF para vedação
// Mesa: 122mm × 72mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~1h30
// ============================================================
// 4× horizontais (122mm) + 4× verticais (120mm)
// Encaixes dovetail nos cantos para montagem do frame
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;
frame_w = 6;

// 4 segmentos horizontais (122mm cada)
for (i = [0:1]) {
    translate([0, i * (frame_w + gap), 0])
        vedacao_segmento_h_a();
}
for (i = [0:1]) {
    translate([0, (2 + i) * (frame_w + gap), 0])
        vedacao_segmento_h_b();
}

// 4 segmentos verticais (120mm cada, rotacionados para deitar)
for (i = [0:1]) {
    translate([0, (4 + i) * (frame_w + gap), 0])
    rotate([0, 0, -90])
    translate([-120, 0, 0])
        vedacao_segmento_v_a();
}
for (i = [0:1]) {
    translate([0, (6 + i) * (frame_w + gap), 0])
    rotate([0, 0, -90])
    translate([-120, 0, 0])
        vedacao_segmento_v_b();
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
