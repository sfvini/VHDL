# Guia Rápido de VHDL: Conceitos, Sintaxe e Estrutura

Este repositório serve como uma referência prática para desenvolvimento em **VHDL** (*VHSIC Hardware Description Language*), cobrindo bibliotecas, tipos de dados, estruturas básicas e sintaxe essencial para projetos digitais e FPGA.

---

# 1. Bibliotecas Comuns (`libraries`)

As bibliotecas adicionam tipos de dados, operadores e funções extras à linguagem.

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Tipos lógicos padrão
use IEEE.NUMERIC_STD.ALL;    -- Operações aritméticas com SIGNED e UNSIGNED
```

## Principais bibliotecas

| Biblioteca | Função |
|---|---|
| `STD_LOGIC_1164` | Define `std_logic` e `std_logic_vector` |
| `NUMERIC_STD` | Operações matemáticas seguras |

---

# 2. Estrutura Básica de um Arquivo VHDL

Todo código VHDL é dividido em duas partes principais:

- **Entity** → Interface física (entradas/saídas)
- **Architecture** → Funcionamento interno

---

# 3. Entity (Interface)

Define:
- nome do circuito
- entradas
- saídas
- largura dos barramentos

```vhdl
entity NomeDoCircuito is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        dado_in  : in  std_logic_vector(7 downto 0);
        q_out    : out std_logic_vector(7 downto 0)
    );
end NomeDoCircuito;
```

---

# 4. Architecture (Comportamento)

Define a lógica do circuito.

```vhdl
architecture behavior of NomeDoCircuito is

    signal fio_interno : std_logic_vector(7 downto 0);

begin

    -- Lógica do circuito

end behavior;
```

---

# 5. Principais Tipos de Dados

| Tipo | Descrição | Exemplo |
|---|---|---|
| `std_logic` | Bit único | `'1'` |
| `std_logic_vector` | Vetor de bits | `"1010"` |
| `integer` | Número inteiro | `42` |
| `unsigned` | Número sem sinal | `unsigned(bus)` |
| `signed` | Número com sinal | `signed(bus)` |

---

# 6. Aspas em VHDL

| Tipo | Sintaxe |
|---|---|
| Bit único | `'0'` |
| Vetor de bits | `"1010"` |

```vhdl
bit_a <= '1';
vetor <= "1100";
```

---

# 7. Vetores: `downto` vs `to`

## Contagem decrescente

```vhdl
std_logic_vector(7 downto 0)
```

Representa:

```text
7 6 5 4 3 2 1 0
```

## Contagem crescente

```vhdl
std_logic_vector(0 to 7)
```

Representa:

```text
0 1 2 3 4 5 6 7
```

---

# 8. Conversão de Tipos

`std_logic_vector`, `signed` e `unsigned` são tipos diferentes.

```vhdl
signal A : unsigned(7 downto 0);
signal B : std_logic_vector(7 downto 0);

A <= unsigned(B);
```

Conversão para inteiro:

```vhdl
signal valor : integer;

valor <= to_integer(unsigned(B));
```

---

# 9. Operadores

## Operadores Lógicos

```vhdl
and
or
nand
nor
xor
xnor
not
```

## Operadores Aritméticos

```vhdl
+
-
*
/
```

> Operações aritméticas em vetores exigem `numeric_std`.

## Concatenação

```vhdl
novo_vetor <= bit_A & vetor_B;
```

---

# 10. Lógica Concorrente

Em VHDL, tudo fora de `process` executa em paralelo.

## Exemplo simples

```vhdl
saida <= A and B;
```

## Multiplexador concorrente

```vhdl
saida <= entrada_A when chave = '1' else entrada_B;
```

---

# 11. Processos (`process`)

Usados para:
- lógica sequencial
- registradores
- máquinas de estado
- lógica combinacional complexa

---

## Processo síncrono com clock

```vhdl
process(clk, reset)
begin

    if reset = '1' then

        q_out <= (others => '0');

    elsif rising_edge(clk) then

        q_out <= dado_in;

    end if;

end process;
```

# 12. Estruturas Condicionais

## IF / ELSIF / ELSE

```vhdl
if selecao = "00" then

    saida <= entrada_A;

elsif selecao = "01" then

    saida <= entrada_B;

else

    saida <= entrada_C;

end if;
```

---

## CASE

```vhdl
case selecao is

    when "00" =>
        saida <= entrada_A;

    when "01" =>
        saida <= entrada_B;

    when others =>
        saida <= (others => '0');

end case;
```

> A cláusula `others` é obrigatória.

---

# 13. WITH / SELECT - WHEN / ELSE

```vhdl
with seletor select

    saida <= entrada_A when "00",
             entrada_B when "01",
             entrada_C when others;
```

```vhdl
saida <= entrada_A when (chave = '1') else entrada_B;
```

---

# 14. Signals vs Variables

## Signal

Representa conexões físicas.

Atualiza ao final do ciclo do processo.

```vhdl
signal contador : integer := 0;
```

Atribuição:

```vhdl
contador <= contador + 1;
```

---

## Variable

Existe apenas dentro de `process`.

Atualiza imediatamente.

```vhdl
variable temp : integer := 0;
```

Atribuição:

```vhdl
temp := temp + 1;
```
