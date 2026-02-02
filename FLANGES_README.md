# Flanges/Conectores para Tubos de Ventilação

## 📁 Arquivos

| Arquivo | Tubo | Base | Uso |
|---------|------|------|-----|
| `FLANGE_150mm.scad` | Ø150mm | 180x180mm | Entrada/saída principal |
| `FLANGE_70mm.scad` | Ø70mm | 100x100mm | Saídas secundárias |

## 🔧 Como usar

### 1. Instalar OpenSCAD
Baixe em: https://openscad.org/downloads.html

### 2. Abrir o arquivo .scad

### 3. Ajustar parâmetros (se necessário)
No topo do arquivo você pode alterar:
- `tubo_diametro` - Diâmetro do seu tubo
- `tubo_folga` - Ajuste de encaixe (0.3-0.8mm)
- `tubo_altura` - Comprimento do bocal
- `flange_tamanho` - Tamanho da base quadrada
- `encaixe_interno` - true/false

### 4. Exportar STL
1. Pressione **F6** (renderizar)
2. Pressione **F7** (exportar STL)
3. Salve o arquivo .stl

## 🖨️ Configurações de Impressão

### Material Recomendado
- **PETG** (melhor resistência térmica e química)
- **ABS** (mais resistente ao calor)
- PLA funciona para teste, mas pode deformar com calor

### Configurações do Slicer
| Parâmetro | Valor |
|-----------|-------|
| Altura de camada | 0.2mm |
| Paredes/Perímetros | 3-4 |
| Preenchimento | 20-30% |
| Suportes | Não necessário |
| Aderência | Brim recomendado |

### Orientação
Imprima com a **base (flange) para baixo** - a peça já está na orientação correta.

## 📐 Dimensões

### Flange 150mm
```
Base: 180 x 180 x 4mm
Bocal: Ø150mm x 40mm altura
Furos: 4x Ø5mm nos cantos
Altura total: 44mm
```

### Flange 70mm
```
Base: 100 x 100 x 3mm
Bocal: Ø70mm x 30mm altura
Furos: 4x Ø4mm nos cantos
Altura total: 33mm
```

## 🔩 Fixação

Para fixar na caixa de MDF:
1. Corte um furo circular na parede da caixa
2. Posicione a flange com o bocal para fora
3. Parafuse pelos 4 furos
4. Use vedação (silicone ou borracha) se necessário

### Parafusos sugeridos
- Flange 150mm: Parafusos M5 x 15mm
- Flange 70mm: Parafusos M4 x 12mm

## ⚠️ Observações

1. **Teste o encaixe** - Imprima primeiro uma amostra pequena do tubo para verificar a folga
2. **Ajuste `tubo_folga`** se o encaixe estiver muito apertado ou frouxo
3. **Meça seu tubo** - Tubos de "150mm" podem variar entre 148-152mm dependendo do fabricante

## 🔄 Variações

### Encaixe Externo
Se seu tubo precisar encaixar **por fora** do bocal (não por dentro), altere:
```
encaixe_interno = false;
```

### Flange para outro diâmetro
Basta copiar um dos arquivos e alterar `tubo_diametro` para o valor desejado.
