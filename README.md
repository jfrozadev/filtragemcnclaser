# 📦 CAIXA DE FILTRAGEM 250×250×250mm
## ✅ VERSÃO FINAL CORRIGIDA - Encaixes Testados

---

## ⚠️ CORREÇÕES DESTA VERSÃO (CRÍTICAS):

### 🔧 PROBLEMAS ORIGINAIS:
1. Os arquivos originais tinham **dentes e ranhuras nas mesmas posições Y**
2. Os **slots das divisórias** estavam desalinhados com as **abas**

### ✅ CORREÇÕES APLICADAS:

**1. Frontal e Traseira - Padrão de dentes INVERTIDO:**
   - Antes: Dentes em Y=25-50, 75-100, 125-150, 175-200, 225-250
   - Agora: Dentes em Y=**0-25**, **50-75**, **100-125**, **150-175**, **200-225**

**2. Sistema de Encaixe Complementar:**
   ```
   LATERAL (ranhuras):    ░░███░░███░░███░░███░░███
   FRONTAL (dentes):      ███░░███░░███░░███░░███░░
   Posição Y:            0  25 50 75 100 ... 225 250
   
   █ = Sólido (25mm)
   ░ = Recuo/Dente (25mm)
   ```

**3. Slots das Divisórias CORRIGIDOS:**
   - Antes: Slots em Y=15-55 e Y=195-235 (desalinhados!)
   - Agora: Slots em Y=**12-52** e Y=**192-232** (alinhados com abas)

**4. Lateral Direita ESPELHADA:**
   - Slots espelhados para encaixar corretamente quando montada

**5. Filtro Wega:** 220×160mm (22×16cm) - VERIFICADO ✓

---

## ⚙️ PARÂMETROS DE CORTE

| Parâmetro | Valor |
|-----------|-------|
| **Potência** | S1000 (100%) |
| **Velocidade** | F150 mm/min |
| **Passagens** | 3× |
| **Air Assist** | OBRIGATÓRIO |

---

## 📐 DIMENSÕES DO CUBO 250mm

### Estrutura Principal:
| Peça | Dimensão | Espessura | Qtd |
|------|----------|-----------|-----|
| Laterais (Esq/Dir) | 250×250mm | 3mm | 2 |
| Frontal (entrada) | 244×250mm | 3mm | 1 |
| Traseira (saída) | 244×250mm | 3mm | 1 |
| Tampa | 250×250mm | 3mm | 1 |
| Base | 250×250mm | 3mm | 1 |

### Divisórias (com abas de 5mm para encaixe):
| Peça | Corpo | Furo do Filtro |
|------|-------|----------------|
| Manta G3 | 244×244mm | 200×200mm (pré-filtro) |
| GM | 244×244mm | 205×220mm |
| **Wega** | 244×244mm | **220×160mm** |

### Gaveta de Carvão:
| Peça | Dimensão |
|------|----------|
| Fundo | 200×40mm (perfurado) |
| Frente | 200×45mm (com puxador) |
| Traseira | 194×45mm |
| Laterais | 40×42mm × 2 |

---

## 📁 ARQUIVOS DE CORTE (11 total)

| # | Arquivo | Descrição |
|---|---------|-----------|
| 1 | `01_LATERAL_ESQ.nc` | 250×250mm com ranhuras + slots divisórias |
| 2 | `02_LATERAL_DIR.nc` | Idêntica (espelhada) |
| 3 | `03_FRONTAL.nc` | 244×250mm com dentes + furo 70mm |
| 4 | `04_TRASEIRA.nc` | 244×250mm com dentes + furo 150mm |
| 5 | `05_TAMPA.nc` | 250×250mm com 4 furos fixação |
| 6 | `06_BASE.nc` | 250×250mm com 4 furos para pés |
| 7 | `07_DIVISORIA_MANTA_G3.nc` | 2× placas sanduíche com abas |
| 8 | `08_DIVISORIA_GM.nc` | 244×244mm + furo 205×220mm |
| 9 | `09_DIVISORIA_WEGA.nc` | 244×244mm + furo 220×160mm |
| 10 | `10_GAVETA.nc` | 5 peças da gaveta |
| 11 | `11_FLANGES.nc` | Entrada 70mm + Saída 150mm |

---

## 🔧 SISTEMA DE ENCAIXE

### Finger Joints (Laterais ↔ Frontal/Traseira):
```
LATERAL (ranhuras):     FRONTAL (dentes):
    ┌───┐                   ├───┤
────┘   └────           ────┤   ├────
 (3mm profundidade)      (3mm salientes)
 
Os DENTES do frontal/traseira entram
nas RANHURAS das laterais!
```

### Divisórias (Slots nas Laterais):
```
LATERAL:               DIVISÓRIA:
   │ ▭ │ ← slot 4×40mm    ─┬─
   │   │                    │├── aba 5mm
   │   │                   ─┴─
   
As ABAS (5mm) passam pelos SLOTS (4×40mm)
```

### Trilhos Gaveta:
```
LATERAL:
   ═══════  ← trilho superior
   
   ═══════  ← trilho inferior
   
Gaveta desliza entre os 2 trilhos
```

---

## 🛠️ ORDEM DE MONTAGEM

1. **Base** → Colocar na mesa
2. **Lateral Esquerda** → Cole sobre a borda da base
3. **Lateral Direita** → Paralela, a 244mm de distância
4. **Frontal** → Dentes nos slots das laterais
5. **Traseira** → Igual ao frontal
6. **Divisórias** → Deslizar de cima (abas nos slots)
7. **Gaveta** → Deslizar nos trilhos
8. **Tampa** → Parafusar

---

## 🎯 VERIFICAÇÃO 3D

Abra `MONTAGEM_3D.html` no navegador para:
- Ver a montagem passo a passo
- Verificar encaixes visuais
- Rotacionar e dar zoom no modelo

| Divisória | Posição X | Filtro |
|-----------|-----------|--------|
| Manta G3 | 40mm | Manta G3 (pré-filtro) |
| GM | 90mm | 205×220mm, 20mm esp. |
| Wega | 150mm | 220×160mm, 45mm esp. |
| Gaveta | 195mm | Carvão ativado |

---

## 📋 MATERIAIS

- MDF 3mm: ~12 chapas 300×300mm
- Filtro GM cabine
- Filtro Wega motor
- Manta G3 (pré-filtro)
- Carvão ativado ~1.5kg
- Cola PVA + Silicone
- Parafusos M3

---

**Versão:** 5.0 CORRIGIDA  
**Data:** Fevereiro 2025
